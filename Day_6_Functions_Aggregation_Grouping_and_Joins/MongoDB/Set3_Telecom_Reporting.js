db = db.getSiblingDB("telecom");
db.usage_events.drop();
db.usage_events.insertMany([
  { event_id: 1, subscriber_id: 1, cell_tower: "T-101", event_time: ISODate("2026-10-03T09:15:00Z"), session_minutes: 12, data_mb: 300 },
  { event_id: 2, subscriber_id: 2, cell_tower: "T-102", event_time: ISODate("2026-10-03T09:40:00Z"), session_minutes: 30, data_mb: 800 },
  { event_id: 3, subscriber_id: 3, cell_tower: "T-101", event_time: ISODate("2026-10-03T10:05:00Z"), session_minutes: 8,  data_mb: 150 },
  { event_id: 4, subscriber_id: 1, cell_tower: "T-101", event_time: ISODate("2026-10-03T10:30:00Z"), session_minutes: 20, data_mb: 400 },
  { event_id: 5, subscriber_id: 4, cell_tower: "T-103", event_time: ISODate("2026-10-03T10:50:00Z"), session_minutes: 15, data_mb: 250 },
  { event_id: 6, subscriber_id: 2, cell_tower: "T-102", event_time: ISODate("2026-10-03T21:10:00Z"), session_minutes: 45, data_mb: 1200 },
  { event_id: 7, subscriber_id: 5, cell_tower: "T-101", event_time: ISODate("2026-10-03T21:25:00Z"), session_minutes: 11, data_mb: 100 },
  { event_id: 8, subscriber_id: 6, cell_tower: "T-102", event_time: ISODate("2026-10-03T21:45:00Z"), session_minutes: 25, data_mb: 700 }
]);

// Pipeline 1: hourly usage (hour is in UTC)
printjson(db.usage_events.aggregate([
  { $group: { _id: { $hour: "$event_time" }, events: { $sum: 1 }, total_data_mb: { $sum: "$data_mb" } } },
  { $sort: { _id: 1 } }
]).toArray());

// Pipeline 2: average session length
printjson(db.usage_events.aggregate([
  { $group: { _id: null, avg_session_minutes: { $avg: "$session_minutes" } } }
]).toArray());

// Pipeline 3: busiest cell tower (most events)
printjson(db.usage_events.aggregate([
  { $group: { _id: "$cell_tower", events: { $sum: 1 }, total_data_mb: { $sum: "$data_mb" } } },
  { $sort: { events: -1 } },
  { $limit: 1 }
]).toArray());