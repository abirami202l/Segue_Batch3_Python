

use("SalesDB");



db.createCollection("customers");
db.createCollection("products");
db.createCollection("orders");
db.createCollection("order_items");
db.createCollection("payments");


// CUSTOMERS
db.customers.insertMany([
    { customer_id: 1, name: "Arjun", city: "Chennai", age: 25 },
    { customer_id: 2, name: "Priya", city: "Mumbai", age: 30 },
    { customer_id: 3, name: "Rahul", city: "Delhi", age: null },
    { customer_id: 4, name: "Sneha", city: "Chennai", age: 28 },
    { customer_id: 5, name: "Karthik", city: "Mumbai", age: null }
]);

// PRODUCTS
db.products.insertMany([
    { product_id: 1, product_name: "Laptop Stand", category: "Electronics", price: 1500 },
    { product_id: 2, product_name: "Mouse", category: "Electronics", price: 800 },
    { product_id: 3, product_name: "T-Shirt", category: "Apparel", price: 600 },
    { product_id: 4, product_name: "Shoes", category: "Apparel", price: 3000 },
    { product_id: 5, product_name: "Notebook", category: "Stationery", price: 250 },
    { product_id: 6, product_name: "Lamp", category: "Home", price: 1200 }
]);

// ORDERS
db.orders.insertMany([
    { order_id: 101, customer_id: 1, order_date: ISODate("2026-08-05") },
    { order_id: 102, customer_id: 2, order_date: ISODate("2026-08-05") },
    { order_id: 103, customer_id: 1, order_date: ISODate("2026-08-20") },
    { order_id: 104, customer_id: 4, order_date: ISODate("2026-09-10") },
    { order_id: 105, customer_id: 1, order_date: ISODate("2026-09-15") },
    { order_id: 106, customer_id: 2, order_date: ISODate("2026-09-15") },
    { order_id: 107, customer_id: 1, order_date: ISODate("2026-10-02") },
    { order_id: 108, customer_id: 3, order_date: ISODate("2026-10-02") }
]);

// ORDER ITEMS
db.order_items.insertMany([
    { order_id: 101, product_id: 1, quantity: 1 },
    { order_id: 101, product_id: 5, quantity: 2 },
    { order_id: 102, product_id: 4, quantity: 1 },
    { order_id: 103, product_id: 2, quantity: 2 },
    { order_id: 104, product_id: 3, quantity: 2 },
    { order_id: 104, product_id: 5, quantity: 4 },
    { order_id: 105, product_id: 6, quantity: 1 },
    { order_id: 106, product_id: 1, quantity: 1 },
    { order_id: 106, product_id: 2, quantity: 1 },
    { order_id: 107, product_id: 4, quantity: 1 },
    { order_id: 107, product_id: 3, quantity: 1 },
    { order_id: 108, product_id: 5, quantity: 3 }
]);

// PAYMENTS
db.payments.insertMany([
    { payment_id: 1, order_id: 101 },
    { payment_id: 2, order_id: 102 },
    { payment_id: 3, order_id: 103 },
    { payment_id: 4, order_id: 104 },
    { payment_id: 5, order_id: 105 },
    { payment_id: 6, order_id: 106 },
    { payment_id: 7, order_id: 107 }
]);


db.order_items.aggregate([
    {
        $lookup: {
            from: "products",
            localField: "product_id",
            foreignField: "product_id",
            as: "product"
        }
    },
    { $unwind: "$product" },
    {
        $group: {
            _id: "$product.product_name",
            units_sold: { $sum: "$quantity" },
            revenue: {
                $sum: { $multiply: ["$quantity", "$product.price"] }
            }
        }
    },
    { $sort: { revenue: -1 } },
    { $limit: 5 },
    {
        $project: {
            _id: 0,
            product_name: "$_id",
            units_sold: 1,
            revenue: 1
        }
    }
]);

db.orders.aggregate([
    {
        $lookup: {
            from: "order_items",
            localField: "order_id",
            foreignField: "order_id",
            as: "items"
        }
    },
    { $unwind: "$items" },
    {
        $lookup: {
            from: "products",
            localField: "items.product_id",
            foreignField: "product_id",
            as: "product"
        }
    },
    { $unwind: "$product" },
    {
        $group: {
            _id: {
                $dateToString: {
                    format: "%Y-%m",
                    date: "$order_date"
                }
            },
            order_ids: { $addToSet: "$order_id" },
            revenue: {
                $sum: {
                    $multiply: ["$items.quantity", "$product.price"]
                }
            }
        }
    },
    {
        $project: {
            _id: 0,
            sales_month: "$_id",
            orders: { $size: "$order_ids" },
            revenue: 1
        }
    },
    { $sort: { sales_month: 1 } }
]);


db.orders.aggregate([
    {
        $group: {
            _id: "$customer_id",
            order_count: { $sum: 1 }
        }
    },
    { $match: { order_count: { $gt: 3 } } },
    {
        $lookup: {
            from: "customers",
            localField: "_id",
            foreignField: "customer_id",
            as: "customer"
        }
    },
    { $unwind: "$customer" },
    {
        $project: {
            _id: 0,
            name: "$customer.name",
            order_count: 1
        }
    }
]);

db.orders.aggregate([
    {
        $lookup: {
            from: "order_items",
            localField: "order_id",
            foreignField: "order_id",
            as: "items"
        }
    },
    { $unwind: "$items" },
    {
        $lookup: {
            from: "products",
            localField: "items.product_id",
            foreignField: "product_id",
            as: "product"
        }
    },
    { $unwind: "$product" },
    {
        $group: {
            _id: "$order_id",
            customer_id: { $first: "$customer_id" },
            total: {
                $sum: {
                    $multiply: ["$items.quantity", "$product.price"]
                }
            }
        }
    },
    {
        $lookup: {
            from: "customers",
            localField: "customer_id",
            foreignField: "customer_id",
            as: "customer"
        }
    },
    { $unwind: "$customer" },
    {
        $group: {
            _id: "$customer.city",
            avg_basket_value: { $avg: "$total" }
        }
    },
    {
        $project: {
            _id: 0,
            city: "$_id",
            avg_basket_value: { $round: ["$avg_basket_value", 2] }
        }
    },
    { $sort: { avg_basket_value: -1 } }
]);

db.orders.aggregate([
    {
        $lookup: {
            from: "payments",
            localField: "order_id",
            foreignField: "order_id",
            as: "payment"
        }
    },
    { $match: { payment: { $size: 0 } } },
    {
        $lookup: {
            from: "customers",
            localField: "customer_id",
            foreignField: "customer_id",
            as: "customer"
        }
    },
    { $unwind: "$customer" },
    {
        $project: {
            _id: 0,
            order_id: 1,
            name: "$customer.name",
            order_date: 1
        }
    }
]);

db.customers.aggregate([
    {
        $lookup: {
            from: "orders",
            localField: "customer_id",
            foreignField: "customer_id",
            as: "orders"
        }
    },
    { $match: { orders: { $size: 0 } } },
    {
        $project: {
            _id: 0,
            customer_id: 1,
            name: 1,
            city: 1
        }
    }
]);


db.order_items.aggregate([
    {
        $lookup: {
            from: "products",
            localField: "product_id",
            foreignField: "product_id",
            as: "product"
        }
    },
    { $unwind: "$product" },
    {
        $group: {
            _id: "$product.category",
            revenue: {
                $sum: {
                    $multiply: ["$quantity", "$product.price"]
                }
            }
        }
    },
    {
        $group: {
            _id: null,
            categories: {
                $push: {
                    category: "$_id",
                    revenue: "$revenue"
                }
            },
            total_revenue: { $sum: "$revenue" }
        }
    },
    { $unwind: "$categories" },
    {
        $project: {
            _id: 0,
            category: "$categories.category",
            revenue: "$categories.revenue",
            share_pct: {
                $round: [
                    {
                        $multiply: [
                            {
                                $divide: [
                                    "$categories.revenue",
                                    "$total_revenue"
                                ]
                            },
                            100
                        ]
                    },
                    2
                ]
            }
        }
    },
    { $sort: { revenue: -1 } }
]);


db.orders.aggregate([
    {
        $lookup: {
            from: "order_items",
            localField: "order_id",
            foreignField: "order_id",
            as: "items"
        }
    },
    { $unwind: "$items" },
    {
        $lookup: {
            from: "products",
            localField: "items.product_id",
            foreignField: "product_id",
            as: "product"
        }
    },
    { $unwind: "$product" },
    {
        $group: {
            _id: "$order_date",
            daily_sales: {
                $sum: {
                    $multiply: ["$items.quantity", "$product.price"]
                }
            }
        }
    },
    { $sort: { daily_sales: -1 } },
    { $limit: 1 },
    {
        $project: {
            _id: 0,
            order_date: "$_id",
            daily_sales: 1
        }
    }
]);


db.orders.aggregate([
    {
        $lookup: {
            from: "customers",
            localField: "customer_id",
            foreignField: "customer_id",
            as: "customer"
        }
    },
    { $unwind: "$customer" },
    {
        $lookup: {
            from: "order_items",
            localField: "order_id",
            foreignField: "order_id",
            as: "items"
        }
    },
    { $unwind: "$items" },
    {
        $lookup: {
            from: "products",
            localField: "items.product_id",
            foreignField: "product_id",
            as: "product"
        }
    },
    { $unwind: "$product" },
    {
        $group: {
            _id: "$order_id",
            name: { $first: "$customer.name" },
            order_date: { $first: "$order_date" },
            total: {
                $sum: {
                    $multiply: ["$items.quantity", "$product.price"]
                }
            }
        }
    },
    {
        $project: {
            _id: 0,
            order_id: "$_id",
            order_summary: {
                $concat: [
                    { $toUpper: "$name" },
                    " | ",
                    {
                        $dateToString: {
                            format: "%d-%b-%Y",
                            date: "$order_date"
                        }
                    },
                    " (",
                    {
                        $toString: {
                            $dateDiff: {
                                startDate: "$order_date",
                                endDate: ISODate("2026-11-17"),
                                unit: "day"
                            }
                        }
                    },
                    " days ago) | Total Rs. ",
                    { $toString: "$total" },
                    " | GST Rs. ",
                    {
                        $toString: {
                            $round: [
                                { $multiply: ["$total", 0.18] },
                                0
                            ]
                        }
                    }
                ]
            }
        }
    },
    { $sort: { order_id: 1 } }
]);



db.customers.aggregate([
    {
        $group: {
            _id: null,

            count_star: {
                $sum: 1
            },

            count_age: {
                $sum: {
                    $cond: [
                        { $ne: ["$age", null] },
                        1,
                        0
                    ]
                }
            },

            avg_age: {
                $avg: "$age"
            },

            avg_age_null_as_zero: {
                $avg: {
                    $ifNull: ["$age", 0]
                }
            }
        }
    },
    {
        $project: {
            _id: 0,
            count_star: 1,
            count_age: 1,
            avg_age: {
                $round: ["$avg_age", 2]
            },
            avg_age_null_as_zero: {
                $round: ["$avg_age_null_as_zero", 2]
            }
        }
    }
]);
