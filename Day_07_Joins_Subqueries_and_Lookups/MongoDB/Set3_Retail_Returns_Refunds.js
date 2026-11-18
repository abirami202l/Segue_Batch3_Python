

const rt = db.getSiblingDB("retail_returns_db");
rt.dropDatabase();

const show = (title, cursor) => {
  print("\n=== " + title + " ===");
  printjson(cursor.toArray());
};


rt.stores.insertMany([
  { _id: 1, name: "Chennai Central",       region: "South" },
  { _id: 2, name: "Coimbatore Mall",       region: "South" },
  { _id: 3, name: "Bengaluru Indiranagar", region: "South" },
  { _id: 4, name: "Mumbai Andheri",        region: "West"  },
  { _id: 5, name: "Pune Camp",             region: "West"  },
  { _id: 6, name: "Delhi Saket",           region: "North" }
]);

rt.customers.insertMany([
  { _id: 1, name: "Anitha" }, { _id: 2, name: "Bharath" }, { _id: 3, name: "Charan" },
  { _id: 4, name: "Divya" },  { _id: 5, name: "Eswar" },   { _id: 6, name: "Farhan" }
]);

rt.products.insertMany([
  { _id: 1, name: "Wireless Headphones", category: "Electronics", price: 2500 },
  { _id: 2, name: "Smartwatch",          category: "Electronics", price: 8000 },
  { _id: 3, name: "Cotton T-Shirt",      category: "Apparel",     price: 600  },
  { _id: 4, name: "Running Sneakers",    category: "Footwear",    price: 3500 },
  { _id: 5, name: "Laptop Backpack",     category: "Accessories", price: 1800 },
  { _id: 6, name: "Mixer Grinder",       category: "Home",        price: 4000 }
]);

const saleRows = [
  [ 1,1,   1,1, 2,"2026-02-03"], [ 2,1,   2,2, 1,"2026-02-04"], [ 3,1,   3,3,20,"2026-02-05"],
  [ 4,2,   1,4, 2,"2026-02-06"], [ 5,2,   4,1, 3,"2026-02-07"], [ 6,3,   5,2, 2,"2026-02-08"],
  [ 7,3,   2,5, 1,"2026-02-09"], [ 8,4,   3,6, 1,"2026-02-10"], [ 9,4,null,1, 1,"2026-02-11"],
  [10,5,   4,3, 4,"2026-02-12"], [11,5,   5,4,10,"2026-02-13"], [12,6,   1,2, 1,"2026-02-14"],
  [13,1,   4,1, 5,"2026-02-15"], [14,2,   6,6, 2,"2026-02-16"]
];
rt.sales.insertMany(saleRows.map(r => ({
  _id: r[0], storeId: r[1], customerId: r[2], productId: r[3], qty: r[4], saleDate: new Date(r[5])
})));

const returnRows = [
  [ 1, 1,1,"2026-02-20","Defective",   2500,"UPI"],  [ 2, 5,1,"2026-02-21","Changed mind",null,null],
  [ 3, 9,1,"2026-02-22","Defective",   2500,"Card"], [ 4, 2,1,"2026-02-23","Defective",   8000,"Card"],
  [ 5, 6,1,"2026-02-24","Damaged",     null,null],   [ 6, 3,1,"2026-02-25","Wrong size",   600,"Cash"],
  [ 7, 4,1,"2026-02-26","Wrong size",  3500,"UPI"],  [ 8, 7,1,"2026-02-27","Changed mind",null,null],
  [ 9,13,1,"2026-02-28","Defective",   2500,"UPI"],  [10,10,1,"2026-03-01","Wrong size",   600,"Cash"],
  [11,12,1,"2026-03-02","Damaged",     8000,"Card"]
];
rt.returns.insertMany(returnRows.map(r => ({
  _id: r[0], saleId: r[1], qty: r[2], returnDate: new Date(r[3]), reason: r[4],
  refund: r[5] === null ? null : { amount: r[5], method: r[6] }
})));

rt.returnFeedback.insertMany([
  { _id: 1, returnId: 1,  rating: 2, comment: "Left earcup stopped working" },
  { _id: 2, returnId: 3,  rating: 1, comment: "Refund took too long" },
  { _id: 3, returnId: 4,  rating: 3, comment: "Replacement offered, declined" },
  { _id: 4, returnId: 5,  rating: 1, comment: "Screen cracked in the box; no refund yet" },
  { _id: 5, returnId: 6,  rating: 4, comment: "Quick and easy" },
  { _id: 6, returnId: 7,  rating: 2, comment: "Size chart was misleading" },
  { _id: 7, returnId: 9,  rating: 2, comment: "Second defective unit" },
  { _id: 8, returnId: 11, rating: 1, comment: "Strap snapped" }
]);

rt.returns.createIndex({ saleId: 1 });
rt.returnFeedback.createIndex({ returnId: 1 });
rt.sales.createIndex({ productId: 1 });



const pipeline1 = [
  { $lookup: { from: "returnFeedback", localField: "_id", foreignField: "returnId", as: "feedback" } },
  { $unwind: { path: "$feedback", preserveNullAndEmptyArrays: true } },
  { $project: {
      reason: 1,
      refundAmount: { $ifNull: ["$refund.amount", 0] },
      refundStatus: { $cond: [ { $eq: ["$refund", null] }, "Pending", "Refunded" ] },
      rating: "$feedback.rating",
      comment: "$feedback.comment"
  }},
  { $sort: { _id: 1 } }
];
show("P1: returns + feedback (LEFT join)", rt.returns.aggregate(pipeline1));



const pipeline2 = [
  { $lookup: { from: "sales", localField: "saleId", foreignField: "_id", as: "sale" } },
  { $unwind: "$sale" },
  { $lookup: { from: "returnFeedback", localField: "_id", foreignField: "returnId", as: "fb" } },
  { $group: {
      _id: "$sale.productId",
      unitsReturned: { $sum: "$qty" },
      ratings: { $push: { $arrayElemAt: ["$fb.rating", 0] } }
  }},
  { $lookup: { from: "products", localField: "_id", foreignField: "_id", as: "product" } },
  { $unwind: "$product" },
  { $lookup: {
      from: "sales",
      let: { pid: "$_id" },
      pipeline: [ { $match: { $expr: { $eq: ["$productId", "$$pid"] } } },
                  { $group: { _id: null, unitsSold: { $sum: "$qty" } } } ],
      as: "soldInfo"
  }},
  { $project: {
      _id: 0,
      product: "$product.name",
      unitsSold: { $arrayElemAt: ["$soldInfo.unitsSold", 0] },
      unitsReturned: 1,
      returnRatePct: { $round: [ { $multiply: [ 100,
                         { $divide: ["$unitsReturned", { $arrayElemAt: ["$soldInfo.unitsSold", 0] }] } ] }, 2 ] },
      avgRating: { $round: [ { $avg: "$ratings" }, 2 ] }
  }},
  { $match: { returnRatePct: { $gt: 10 } } },
  { $sort: { returnRatePct: -1 } }
];
show("P2: products with return rate > 10% + average rating", rt.returns.aggregate(pipeline2));



const pipeline3 = [
  { $lookup: { from: "sales", localField: "saleId", foreignField: "_id", as: "sale" } },
  { $unwind: "$sale" },
  { $lookup: { from: "returnFeedback", localField: "_id", foreignField: "returnId", as: "fb" } },
  { $group: {
      _id: "$sale.storeId",
      returnsCount: { $sum: 1 },
      totalRefund: { $sum: { $ifNull: ["$refund.amount", 0] } },
      pendingRefunds: { $sum: { $cond: [ { $eq: ["$refund", null] }, 1, 0 ] } },
      ratings: { $push: { $arrayElemAt: ["$fb.rating", 0] } }
  }},
  { $lookup: { from: "stores", localField: "_id", foreignField: "_id", as: "store" } },
  { $unwind: "$store" },
  { $setWindowFields: {
      partitionBy: "$store.region",
      sortBy: { totalRefund: -1 },
      output: { rankInRegion: { $rank: {} } }
  }},
  { $project: {
      _id: 0, store: "$store.name", region: "$store.region",
      returnsCount: 1, totalRefund: 1, pendingRefunds: 1,
      avgRating: { $round: [ { $avg: "$ratings" }, 2 ] },
      rankInRegion: 1
  }},
  { $sort: { region: 1, rankInRegion: 1 } }
];
show("P3: stores - refunds, feedback and rank within region", rt.returns.aggregate(pipeline3));



