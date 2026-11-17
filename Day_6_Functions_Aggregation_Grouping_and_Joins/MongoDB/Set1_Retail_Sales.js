
const retail = db.getSiblingDB("retail");
retail.orders.drop();

retail.orders.insertMany([
  { _id: 1001, customer_id: 1, customer_name: "Arjun Kumar", city: "Chennai", order_date: ISODate("2026-08-03T00:00:00Z"), status: "Delivered", items: [
      { product_id: 1, product_name: "Laptop Stand", category: "Electronics", quantity: 1, unit_price: 1499, discount_pct: null },
      { product_id: 8, product_name: "Notebook Pack", category: "Stationery", quantity: 3, unit_price: 249, discount_pct: null }
  ] },
  { _id: 1002, customer_id: 2, customer_name: "Priya Sharma", city: "Mumbai", order_date: ISODate("2026-08-05T00:00:00Z"), status: "Delivered", items: [
      { product_id: 3, product_name: "Bluetooth Speaker", category: "Electronics", quantity: 1, unit_price: 2499, discount_pct: 10 },
      { product_id: 4, product_name: "Cotton T-Shirt", category: "Apparel", quantity: 2, unit_price: 599, discount_pct: null }
  ] },
  { _id: 1003, customer_id: 3, customer_name: "Rahul Verma", city: "Delhi", order_date: ISODate("2026-08-12T00:00:00Z"), status: "Delivered", items: [
      { product_id: 5, product_name: "Running Shoes", category: "Apparel", quantity: 1, unit_price: 2999, discount_pct: null }
  ] },
  { _id: 1004, customer_id: 4, customer_name: "Sneha Iyer", city: "Chennai", order_date: ISODate("2026-08-17T00:00:00Z"), status: "Delivered", items: [
      { product_id: 6, product_name: "Steel Water Bottle", category: "Home", quantity: 2, unit_price: 449, discount_pct: 5 },
      { product_id: 7, product_name: "Desk Lamp", category: "Home", quantity: 1, unit_price: 1199, discount_pct: null }
  ] },
  { _id: 1005, customer_id: 1, customer_name: "Arjun Kumar", city: "Chennai", order_date: ISODate("2026-08-21T00:00:00Z"), status: "Delivered", items: [
      { product_id: 2, product_name: "Wireless Mouse", category: "Electronics", quantity: 2, unit_price: 799, discount_pct: null }
  ] },
  { _id: 1006, customer_id: 2, customer_name: "Priya Sharma", city: "Mumbai", order_date: ISODate("2026-08-28T00:00:00Z"), status: "Delivered", items: [
      { product_id: 4, product_name: "Cotton T-Shirt", category: "Apparel", quantity: 3, unit_price: 599, discount_pct: 5 },
      { product_id: 5, product_name: "Running Shoes", category: "Apparel", quantity: 1, unit_price: 2999, discount_pct: 10 }
  ] },
  { _id: 1007, customer_id: 5, customer_name: "Karthik Raj", city: "Bengaluru", order_date: ISODate("2026-09-01T00:00:00Z"), status: "Delivered", items: [
      { product_id: 1, product_name: "Laptop Stand", category: "Electronics", quantity: 1, unit_price: 1499, discount_pct: null },
      { product_id: 2, product_name: "Wireless Mouse", category: "Electronics", quantity: 1, unit_price: 799, discount_pct: null },
      { product_id: 8, product_name: "Notebook Pack", category: "Stationery", quantity: 2, unit_price: 249, discount_pct: null }
  ] },
  { _id: 1008, customer_id: 6, customer_name: "Divya Nair", city: "Kochi", order_date: ISODate("2026-09-05T00:00:00Z"), status: "Cancelled", items: [
      { product_id: 3, product_name: "Bluetooth Speaker", category: "Electronics", quantity: 1, unit_price: 2499, discount_pct: null }
  ] },
  { _id: 1009, customer_id: 4, customer_name: "Sneha Iyer", city: "Chennai", order_date: ISODate("2026-09-10T00:00:00Z"), status: "Delivered", items: [
      { product_id: 4, product_name: "Cotton T-Shirt", category: "Apparel", quantity: 2, unit_price: 599, discount_pct: null },
      { product_id: 8, product_name: "Notebook Pack", category: "Stationery", quantity: 5, unit_price: 249, discount_pct: null }
  ] },
  { _id: 1010, customer_id: 1, customer_name: "Arjun Kumar", city: "Chennai", order_date: ISODate("2026-09-14T00:00:00Z"), status: "Delivered", items: [
      { product_id: 7, product_name: "Desk Lamp", category: "Home", quantity: 2, unit_price: 1199, discount_pct: 10 }
  ] },
  { _id: 1011, customer_id: 2, customer_name: "Priya Sharma", city: "Mumbai", order_date: ISODate("2026-09-18T00:00:00Z"), status: "Delivered", items: [
      { product_id: 3, product_name: "Bluetooth Speaker", category: "Electronics", quantity: 2, unit_price: 2499, discount_pct: null },
      { product_id: 6, product_name: "Steel Water Bottle", category: "Home", quantity: 1, unit_price: 449, discount_pct: null }
  ] },
  { _id: 1012, customer_id: 3, customer_name: "Rahul Verma", city: "Delhi", order_date: ISODate("2026-09-18T00:00:00Z"), status: "Delivered", items: [
      { product_id: 5, product_name: "Running Shoes", category: "Apparel", quantity: 2, unit_price: 2999, discount_pct: 5 },
      { product_id: 2, product_name: "Wireless Mouse", category: "Electronics", quantity: 1, unit_price: 799, discount_pct: null }
  ] },
  { _id: 1013, customer_id: 7, customer_name: "Mohammed Faisal", city: "Hyderabad", order_date: ISODate("2026-09-30T00:00:00Z"), status: "Delivered", items: [
      { product_id: 1, product_name: "Laptop Stand", category: "Electronics", quantity: 2, unit_price: 1499, discount_pct: null }
  ] },
  { _id: 1014, customer_id: 2, customer_name: "Priya Sharma", city: "Mumbai", order_date: ISODate("2026-10-02T00:00:00Z"), status: "Delivered", items: [
      { product_id: 7, product_name: "Desk Lamp", category: "Home", quantity: 1, unit_price: 1199, discount_pct: null },
      { product_id: 8, product_name: "Notebook Pack", category: "Stationery", quantity: 4, unit_price: 249, discount_pct: null }
  ] },
  { _id: 1015, customer_id: 5, customer_name: "Karthik Raj", city: "Bengaluru", order_date: ISODate("2026-10-05T00:00:00Z"), status: "Delivered", items: [
      { product_id: 3, product_name: "Bluetooth Speaker", category: "Electronics", quantity: 1, unit_price: 2499, discount_pct: 15 }
  ] },
  { _id: 1016, customer_id: 1, customer_name: "Arjun Kumar", city: "Chennai", order_date: ISODate("2026-10-09T00:00:00Z"), status: "Delivered", items: [
      { product_id: 4, product_name: "Cotton T-Shirt", category: "Apparel", quantity: 1, unit_price: 599, discount_pct: null },
      { product_id: 6, product_name: "Steel Water Bottle", category: "Home", quantity: 3, unit_price: 449, discount_pct: null }
  ] },
  { _id: 1017, customer_id: 4, customer_name: "Sneha Iyer", city: "Chennai", order_date: ISODate("2026-10-12T00:00:00Z"), status: "Delivered", items: [
      { product_id: 5, product_name: "Running Shoes", category: "Apparel", quantity: 1, unit_price: 2999, discount_pct: null },
      { product_id: 2, product_name: "Wireless Mouse", category: "Electronics", quantity: 1, unit_price: 799, discount_pct: 10 }
  ] },
  { _id: 1018, customer_id: 8, customer_name: "Anita Desai", city: "Mumbai", order_date: ISODate("2026-10-15T00:00:00Z"), status: "Delivered", items: [
      { product_id: 1, product_name: "Laptop Stand", category: "Electronics", quantity: 1, unit_price: 1499, discount_pct: 5 },
      { product_id: 7, product_name: "Desk Lamp", category: "Home", quantity: 1, unit_price: 1199, discount_pct: null }
  ] },
  { _id: 1019, customer_id: 2, customer_name: "Priya Sharma", city: "Mumbai", order_date: ISODate("2026-10-20T00:00:00Z"), status: "Shipped", items: [
      { product_id: 5, product_name: "Running Shoes", category: "Apparel", quantity: 2, unit_price: 2999, discount_pct: null },
      { product_id: 3, product_name: "Bluetooth Speaker", category: "Electronics", quantity: 1, unit_price: 2499, discount_pct: null }
  ] },
  { _id: 1020, customer_id: 7, customer_name: "Mohammed Faisal", city: "Hyderabad", order_date: ISODate("2026-10-25T00:00:00Z"), status: "Shipped", items: [
      { product_id: 2, product_name: "Wireless Mouse", category: "Electronics", quantity: 3, unit_price: 799, discount_pct: null }
  ] },
  { _id: 1021, customer_id: 9, customer_name: "Vikram Singh", city: "Delhi", order_date: ISODate("2026-10-28T00:00:00Z"), status: "Shipped", items: [
      { product_id: 6, product_name: "Steel Water Bottle", category: "Home", quantity: 4, unit_price: 449, discount_pct: 10 }
  ] },
  { _id: 1022, customer_id: 9, customer_name: "Vikram Singh", city: "Delhi", order_date: ISODate("2026-10-30T00:00:00Z"), status: "Pending", items: [
      { product_id: 8, product_name: "Notebook Pack", category: "Stationery", quantity: 6, unit_price: 249, discount_pct: null }
  ] }
]);

// Line revenue = quantity * unit_price * (1 - discount/100); a null discount counts as 0.
const lineRevenue = { $multiply: [ "$items.quantity", "$items.unit_price", { $subtract: [ 1, { $divide: [ { $ifNull: [ "$items.discount_pct", 0 ] }, 100 ] } ] } ] };

print("\n--- Report 1: month-wise sales (cf. Q2) ---");
printjson(retail.orders.aggregate([
  { $match: { status: { $ne: "Cancelled" } } },
  { $unwind: "$items" },
  { $group: {
      _id: { $dateToString: { format: "%Y-%m", date: "$order_date" } },
      order_ids: { $addToSet: "$_id" },
      revenue: { $sum: lineRevenue }
  } },
  { $project: { orders: { $size: "$order_ids" }, revenue: { $round: [ "$revenue", 2 ] } } },
  { $sort: { _id: 1 } }
]).toArray());

print("\n--- Report 2: top-5 products by revenue (cf. Q1) ---");
printjson(retail.orders.aggregate([
  { $match: { status: { $ne: "Cancelled" } } },
  { $unwind: "$items" },
  { $group: {
      _id: "$items.product_name",
      units_sold: { $sum: "$items.quantity" },
      revenue: { $sum: lineRevenue }
  } },
  { $sort: { revenue: -1, _id: 1 } },
  { $limit: 5 },
  { $project: { units_sold: 1, revenue: { $round: [ "$revenue", 2 ] } } }
]).toArray());

print("\n--- Report 3: average basket value per city (cf. Q4) ---");
printjson(retail.orders.aggregate([
  { $match: { status: { $ne: "Cancelled" } } },
  { $addFields: {
      basket_value: { $sum: { $map: { input: "$items", as: "i", in: {
        $multiply: [ "$$i.quantity", "$$i.unit_price",
                     { $subtract: [ 1, { $divide: [ { $ifNull: [ "$$i.discount_pct", 0 ] }, 100 ] } ] } ]
      } } } }
  } },
  { $group: { _id: "$city", orders: { $sum: 1 }, avg_basket_value: { $avg: "$basket_value" } } },
  { $project: { orders: 1, avg_basket_value: { $round: [ "$avg_basket_value", 2 ] } } },
  { $sort: { avg_basket_value: -1 } }
]).toArray());
