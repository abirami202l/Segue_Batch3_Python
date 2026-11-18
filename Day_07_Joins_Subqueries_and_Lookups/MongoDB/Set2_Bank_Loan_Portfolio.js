

const bk = db.getSiblingDB("bank_loan_db");
bk.dropDatabase();

const show = (title, cursor) => {
  print("\n=== " + title + " ===");
  printjson(cursor.toArray());
};

const AS_OF = new Date("2026-11-18");


bk.branches.insertMany([
  { _id: 1, name: "Adyar" },     { _id: 2, name: "Anna Nagar" },
  { _id: 3, name: "Velachery" }, { _id: 4, name: "Tambaram" }
]);

bk.customers.insertMany([
  { _id: 1, name: "Anand" },   { _id: 2, name: "Bhavana" }, { _id: 3, name: "Chandru" },
  { _id: 4, name: "Deepa" },   { _id: 5, name: "Elango" },  { _id: 6, name: "Fathima" },
  { _id: 7, name: "Gokul" }
]);

const loanRows = [
  [1,1,1, 500000, 45000,"2026-05-01",6,[]],
  [2,1,2, 300000, 27000,"2026-07-01",4,[]],
  [3,2,1, 800000, 72000,"2026-04-01",2,[1]],
  [4,3,2, 200000, 18000,"2026-06-01",1,[7]],
  [5,4,3,1200000,105000,"2026-08-01",3,[2]],
  [6,5,3, 450000, 40000,"2026-03-01",6,[7]],
  [7,2,3, 250000, 23000,"2026-09-01",2,[]],
  [8,6,1, 150000, 14000,"2026-02-01",4,[5]]
];

bk.loans.insertMany(loanRows.map(r => ({
  _id: r[0], customerId: r[1], branchId: r[2], amount: r[3], emi: r[4],
  startDate: new Date(r[5]), tenureMonths: 12, guarantorIds: r[7]
})));

const repayments = [];
let repId = 1;
loanRows.forEach(r => {
  const s = new Date(r[5]);
  for (let n = 0; n < r[6]; n++) {
    repayments.push({
      _id: repId++, loanId: r[0],
      paidDate: new Date(Date.UTC(s.getUTCFullYear(), s.getUTCMonth() + n, 5)),
      amount: r[4]
    });
  }
});
bk.repayments.insertMany(repayments);

bk.loans.createIndex({ customerId: 1 });
bk.loans.createIndex({ branchId: 1 });
bk.repayments.createIndex({ loanId: 1, paidDate: -1 });



const pipeline1 = [
  { $lookup: { from: "customers",  localField: "customerId", foreignField: "_id", as: "customer" } },
  { $unwind: "$customer" },
  { $lookup: { from: "repayments", localField: "_id", foreignField: "loanId", as: "repayments" } },
  { $addFields: {
      instalmentsDue: { $min: [ "$tenureMonths",
                                { $dateDiff: { startDate: "$startDate", endDate: AS_OF, unit: "month" } } ] },
      instalmentsPaid: { $size: "$repayments" },
      totalRepaid: { $sum: "$repayments.amount" }
  }},
  { $addFields: { instalmentsOverdue: { $subtract: ["$instalmentsDue", "$instalmentsPaid"] } } },
  { $project: { customer: "$customer.name", branchId: 1, amount: 1,
                instalmentsDue: 1, instalmentsPaid: 1, instalmentsOverdue: 1, totalRepaid: 1 } },
  { $match: { instalmentsOverdue: { $gt: 3 } } },
  { $sort: { instalmentsOverdue: -1 } }
];
show("P1: loans + customer + repayments (overdue > 3)", bk.loans.aggregate(pipeline1));



const pipeline2 = [
  { $lookup: { from: "loans", localField: "_id", foreignField: "customerId", as: "loans" } },
  { $project: {
      name: 1,
      loanCount: { $size: "$loans" },
      totalExposure: { $sum: "$loans.amount" },
      branchesUsed: { $size: { $setUnion: ["$loans.branchId", []] } }
  }},
  { $sort: { totalExposure: -1 } }
];
show("P2: customers + loans (exposure, branches)", bk.customers.aggregate(pipeline2));



const pipeline3 = [
  { $lookup: {
      from: "repayments",
      let: { lid: "$_id" },
      pipeline: [
        { $match: { $expr: { $eq: ["$loanId", "$$lid"] } } },
        { $sort: { paidDate: -1 } },
        { $limit: 1 },
        { $project: { _id: 0, paidDate: 1, amount: 1 } }
      ],
      as: "lastRepayment"
  }},
  { $unwind: { path: "$lastRepayment", preserveNullAndEmptyArrays: true } },
  { $project: {
      customerId: 1, amount: 1,
      lastPaidDate: "$lastRepayment.paidDate",
      lastPaidAmount: "$lastRepayment.amount",
      daysSinceLastPayment: {
        $cond: [ { $ifNull: ["$lastRepayment.paidDate", false] },
                 { $dateDiff: { startDate: "$lastRepayment.paidDate", endDate: AS_OF, unit: "day" } },
                 null ]
      },
      noPaymentLast60Days: {
        $not: [ { $gte: [ { $ifNull: ["$lastRepayment.paidDate", new Date(0)] },
                          new Date(AS_OF.getTime() - 60 * 24 * 3600 * 1000) ] } ]
      }
  }},
  { $sort: { _id: 1 } }
];
show("P3: last repayment per loan", bk.loans.aggregate(pipeline3));



