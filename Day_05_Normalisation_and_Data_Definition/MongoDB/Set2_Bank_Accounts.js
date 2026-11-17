use BankBranchDB;

db.createCollection("customerActivity", {
    capped: true,
    size: 1048576,
    max: 1000
});

const activityDocs = [];

for (let i = 1; i <= 20; i++) {
    activityDocs.push({
        customerId: "C001",
        eventType: i % 2 === 0 ? "LOGIN" : "LOGOUT",
        device: i % 3 === 0 ? "Mobile" : "Laptop",
        ipAddress: "192.168.1." + i,
        eventTime: new Date(Date.now() - (20 - i) * 60000)
    });
}

db.customerActivity.insertMany(activityDocs);

db.customerActivity.find();

db.customerActivity.find({
    customerId: "C001"
});

db.customerActivity.find({
    customerId: "C001",
    eventType: "LOGIN"
})
.sort({ $natural: -1 })
.limit(5);
