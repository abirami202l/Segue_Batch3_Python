use RetailInventoryDB;

db.createCollection("reviews", {
    validator: {
        $jsonSchema: {
            bsonType: "object",
            required: ["sku", "customerId", "rating", "reviewText", "createdAt"],
            properties: {
                sku: { bsonType: "string" },
                customerId: { bsonType: "string" },
                rating: { bsonType: "int", minimum: 1, maximum: 5 },
                reviewText: { bsonType: "string" },
                createdAt: { bsonType: "date" },
                images: {
                    bsonType: "array",
                    items: { bsonType: "string" }
                },
                helpfulVotes: { bsonType: "int", minimum: 0 }
            }
        }
    },
    validationLevel: "strict",
    validationAction: "error"
});

db.reviews.insertMany([
    { sku:"SKU001", customerId:"C001", rating:NumberInt(5), reviewText:"Excellent mouse", createdAt:new Date("2026-11-01"), images:[], helpfulVotes:NumberInt(4) },
    { sku:"SKU001", customerId:"C002", rating:NumberInt(4), reviewText:"Works well", createdAt:new Date("2026-11-02"), images:["mouse.jpg"], helpfulVotes:NumberInt(2) },
    { sku:"SKU002", customerId:"C003", rating:NumberInt(3), reviewText:"Comfortable but costly", createdAt:new Date("2026-11-03"), images:[], helpfulVotes:NumberInt(1) },
    { sku:"SKU003", customerId:"C004", rating:NumberInt(5), reviewText:"Good quality notebook", createdAt:new Date("2026-11-04"), images:[], helpfulVotes:NumberInt(3) },
    { sku:"SKU004", customerId:"C005", rating:NumberInt(4), reviewText:"Fresh product", createdAt:new Date("2026-11-05"), images:[], helpfulVotes:NumberInt(0) },
    { sku:"SKU005", customerId:"C006", rating:NumberInt(2), reviewText:"Incorrect size", createdAt:new Date("2026-11-06"), images:[], helpfulVotes:NumberInt(0) },
    { sku:"SKU006", customerId:"C007", rating:NumberInt(5), reviewText:"Very comfortable shoes", createdAt:new Date("2026-11-07"), images:["shoes.jpg"], helpfulVotes:NumberInt(5) },
    { sku:"SKU007", customerId:"C008", rating:NumberInt(4), reviewText:"Good appliance", createdAt:new Date("2026-11-08"), images:[], helpfulVotes:NumberInt(1) },
    { sku:"SKU008", customerId:"C009", rating:NumberInt(3), reviewText:"Average quality", createdAt:new Date("2026-11-09"), images:[], helpfulVotes:NumberInt(0) },
    { sku:"SKU009", customerId:"C010", rating:NumberInt(5), reviewText:"Children loved it", createdAt:new Date("2026-11-10"), images:[], helpfulVotes:NumberInt(6) }
]);

db.reviews.find();
db.reviews.find({ sku: "SKU001" });
db.reviews.find({ rating: { $gt: 3 } });

db.reviews.updateOne(
    { sku: "SKU001", customerId: "C001" },
    { $set: { reviewText: "Excellent wireless mouse. Highly recommended." } }
);

db.reviews.find({ customerId: "C001" });

db.reviews.deleteOne({
    sku: "SKU009",
    customerId: "C010"
});

db.reviews.find({ sku: "SKU009" });
