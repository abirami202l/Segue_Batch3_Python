const lg = db.getSiblingDB("logistics_db");
lg.dropDatabase();

const show = (title, cursor) => {
  print("\n=== " + title + " ===");
  printjson(cursor.toArray());
};

lg.hubs.insertMany([
  { _id: 1, name: "Chennai Hub" },   { _id: 2, name: "Mumbai Hub" },
  { _id: 3, name: "Delhi Hub" },     { _id: 4, name: "Bengaluru Hub" },
  { _id: 5, name: "Kolkata Hub" }
]);

lg.carriers.insertMany([
  { _id: 1, name: "SwiftCargo" },    { _id: 2, name: "RoadRunner" },
  { _id: 3, name: "SkyLine Freight" }, { _id: 4, name: "TruNorth Logistics" }
]);

lg.customers.insertMany([
  { _id: 1, name: "Zenith Retail",  city: "Chennai" },
  { _id: 2, name: "Orion Traders",  city: "Mumbai" },
  { _id: 3, name: "Lotus Exports",  city: "Delhi" },
  { _id: 4, name: "Maple Foods",    city: "Bengaluru" },
  { _id: 5, name: "Nova Textiles",  city: "Kolkata" },
  { _id: 6, name: "Pioneer Tools",  city: "Pune" }
]);

const shipmentRows = [
  [ 1,1,1,1,2,"2026-01-05","2026-01-08","2026-01-07", 450],
  [ 2,1,2,1,3,"2026-01-06","2026-01-10","2026-01-14", 900],
  [ 3,1,1,2,4,"2026-01-07","2026-01-11","2026-01-11", 600],
  [ 4,1,3,3,5,"2026-01-10","2026-01-15","2026-01-19",1200],
  [ 5,1,2,4,1,"2026-01-12","2026-01-15","2026-01-15", 300],
  [ 6,2,1,1,2,"2026-01-08","2026-01-12","2026-01-13", 500],
  [ 7,2,3,2,3,"2026-01-09","2026-01-14","2026-01-17", 800],
  [ 8,3,2,3,1,"2026-01-11","2026-01-14","2026-01-16", 700],
  [ 9,3,4,4,2,"2026-01-12","2026-01-16","2026-01-21",1500],
  [10,4,1,1,4,"2026-01-15","2026-01-19","2026-01-18", 650],
  [11,4,4,2,1,"2026-01-16","2026-01-20",null        , 400],
  [12,5,3,3,2,"2026-01-18","2026-01-22","2026-01-27",1100],
  [13,5,2,1,3,"2026-01-20","2026-01-24","2026-01-24", 550],
  [14,2,1,4,3,"2026-01-21","2026-01-25","2026-01-26", 480],
  [15,3,4,1,4,"2026-01-22","2026-01-26","2026-01-30",1000],
  [16,4,3,2,4,"2026-01-23","2026-01-27","2026-01-27", 700]
];
lg.shipments.insertMany(shipmentRows.map(r => ({
  _id: r[0], customerId: r[1], carrierId: r[2], originHubId: r[3], destHubId: r[4],
  shipDate: new Date(r[5]), promisedDate: new Date(r[6]),
  deliveredDate: r[7] ? new Date(r[7]) : null, shippingCost: r[8]
})));

const eventRows = [
  [ 1, 1,1,"Picked Up","2026-01-05T09:00:00Z"], [ 2, 1,2,"Delivered","2026-01-07T15:30:00Z"],
  [ 3, 2,1,"Picked Up","2026-01-06T10:00:00Z"], [ 4, 2,4,"At Hub"   ,"2026-01-09T08:00:00Z"],
  [ 5, 2,3,"Delivered","2026-01-14T12:00:00Z"],
  [ 6, 3,2,"Picked Up","2026-01-07T11:00:00Z"], [ 7, 3,4,"Delivered","2026-01-11T17:00:00Z"],
  [ 8, 4,3,"Picked Up","2026-01-10T09:30:00Z"], [ 9, 4,1,"At Hub"   ,"2026-01-13T14:00:00Z"],
  [10, 4,5,"Delivered","2026-01-19T10:00:00Z"],
  [11, 7,2,"Picked Up","2026-01-09T08:00:00Z"], [12, 7,3,"Delivered","2026-01-17T09:00:00Z"],
  [13, 9,4,"Picked Up","2026-01-12T08:30:00Z"], [14, 9,2,"Delivered","2026-01-21T16:45:00Z"],
  [15,11,2,"Picked Up","2026-01-16T09:00:00Z"], [16,11,3,"At Hub"   ,"2026-01-19T13:00:00Z"],
  [17,12,3,"Picked Up","2026-01-18T10:15:00Z"], [18,12,2,"Delivered","2026-01-27T11:00:00Z"]
];
lg.deliveryEvents.insertMany(eventRows.map(r => ({
  _id: r[0], shipmentId: r[1], hubId: r[2], eventType: r[3], eventTime: new Date(r[4])
})));

lg.shipments.createIndex({ customerId: 1 });
lg.shipments.createIndex({ carrierId: 1 });
lg.deliveryEvents.createIndex({ shipmentId: 1 });

const pipeline1 = [
  { $lookup: {
      from: "deliveryEvents",
      localField: "_id",
      foreignField: "shipmentId",
      as: "events"
  }},
  { $project: {
      _id: 1, customerId: 1, carrierId: 1, shippingCost: 1,
      eventCount: { $size: "$events" },
      events: { $map: { input: "$events", as: "e",
                        in: { type: "$$e.eventType", hubId: "$$e.hubId", time: "$$e.eventTime" } } }
  }},
  { $sort: { _id: 1 } }
];
show("P1: shipments + delivery events", lg.shipments.aggregate(pipeline1));
const pipeline2 = [
  { $lookup: {
      from: "shipments",
      localField: "_id",
      foreignField: "customerId",
      as: "shipments"
  }},
  { $project: {
      name: 1,
      shipmentCount:  { $size: "$shipments" },
      totalCost:      { $sum: "$shipments.shippingCost" },
      destHubsReached:{ $size: { $setUnion: ["$shipments.destHubId", []] } },
      shippedToEveryHub: { $eq: [ { $size: { $setUnion: ["$shipments.destHubId", []] } }, 5 ] }
  }},
  { $sort: { totalCost: -1 } }
];
show("P2: customers + their shipments", lg.customers.aggregate(pipeline2));
const pipeline3 = [
  { $lookup: {
      from: "shipments",
      let: { cid: "$_id" },
      pipeline: [
        { $match: { $expr: { $eq: ["$carrierId", "$$cid"] }, deliveredDate: { $ne: null } } },
        { $project: { _id: 0,
                      delayDays: { $dateDiff: { startDate: "$promisedDate",
                                                endDate: "$deliveredDate", unit: "day" } } } }
      ],
      as: "delivered"
  }},
  { $project: {
      name: 1,
      deliveredShipments: { $size: "$delivered" },
      avgDelayDays: { $round: [ { $avg: "$delivered.delayDays" }, 2 ] },
      maxDelayDays: { $max: "$delivered.delayDays" },
      shipmentsLateOver2Days: { $size: { $filter: { input: "$delivered",
                                                    cond: { $gt: ["$$this.delayDays", 2] } } } }
  }},
  { $sort: { avgDelayDays: -1 } }
];
show("P3: carriers + delay statistics", lg.carriers.aggregate(pipeline3));
