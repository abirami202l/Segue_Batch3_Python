use HospitalDB;

db.createCollection("clinicalNotes", {
    validator: {
        $jsonSchema: {
            bsonType: "object",
            required: ["patientId","doctorId","visitDate","diagnosis","note"],
            properties: {
                patientId: { bsonType: "string" },
                doctorId: { bsonType: "string" },
                visitDate: { bsonType: "date" },
                diagnosis: { bsonType: "string" },
                note: { bsonType: "string" },
                prescription: { bsonType: "string" },
                vitals: {
                    bsonType: "object",
                    properties: {
                        temperature: { bsonType: ["double","int","decimal"] },
                        bloodPressure: { bsonType: "string" },
                        pulse: { bsonType: ["int","double"] }
                    }
                },
                attachments: {
                    bsonType: "array",
                    items: { bsonType: "string" }
                },
                followUpDate: { bsonType: "date" }
            }
        }
    },
    validationLevel: "strict",
    validationAction: "error"
});

db.clinicalNotes.insertOne({
    patientId: "P001",
    doctorId: "D001",
    visitDate: new Date("2026-11-01"),
    diagnosis: "Hypertension",
    note: "Patient advised to monitor blood pressure.",
    prescription: "Medication A",
    vitals: {
        temperature: 36.8,
        bloodPressure: "130/85",
        pulse: 78
    },
    attachments: []
});

db.clinicalNotes.insertOne({
    patientId: "P004",
    doctorId: "D004",
    visitDate: new Date("2026-11-04"),
    diagnosis: "Skin allergy",
    note: "Rash observed on the right arm.",
    prescription: "Cream D",
    attachments: ["rash-photo-01.jpg","rash-photo-02.jpg"],
    followUpDate: new Date("2026-11-18")
});

db.clinicalNotes.insertMany([
    {
        patientId: "P002",
        doctorId: "D002",
        visitDate: new Date("2026-11-02"),
        diagnosis: "Migraine",
        note: "Headache review completed.",
        prescription: "Medication B"
    },
    {
        patientId: "P003",
        doctorId: "D003",
        visitDate: new Date("2026-11-03"),
        diagnosis: "Knee pain",
        note: "Pain while walking.",
        prescription: "Medication C"
    },
    {
        patientId: "P005",
        doctorId: "D005",
        visitDate: new Date("2026-11-05"),
        diagnosis: "Fever",
        note: "Mild fever observed.",
        prescription: "Medication E"
    },
    {
        patientId: "P006",
        doctorId: "D006",
        visitDate: new Date("2026-11-06"),
        diagnosis: "Ear infection",
        note: "Ear pain reported.",
        prescription: "Drops F"
    },
    {
        patientId: "P007",
        doctorId: "D007",
        visitDate: new Date("2026-11-07"),
        diagnosis: "Anemia",
        note: "Follow-up advised.",
        prescription: "Medication G"
    },
    {
        patientId: "P008",
        doctorId: "D008",
        visitDate: new Date("2026-11-08"),
        diagnosis: "Cold",
        note: "Common cold symptoms.",
        prescription: "Medication H"
    },
    {
        patientId: "P009",
        doctorId: "D009",
        visitDate: new Date("2026-11-09"),
        diagnosis: "Tooth decay",
        note: "Dental consultation completed.",
        prescription: "Treatment I"
    },
    {
        patientId: "P010",
        doctorId: "D010",
        visitDate: new Date("2026-11-10"),
        diagnosis: "Eye irritation",
        note: "Eye examination completed.",
        prescription: "Drops J"
    }
]);

db.clinicalNotes.find();

db.clinicalNotes.find({
    diagnosis: "Hypertension"
});

db.clinicalNotes.find({
    diagnosis: "Skin allergy"
});

db.clinicalNotes.find({
    diagnosis: { $regex: "pain", $options: "i" }
});

db.clinicalNotes.updateOne(
    { patientId: "P001" },
    {
        $set: {
            note: "Blood pressure monitoring advised. Follow-up required."
        }
    }
);

db.clinicalNotes.find({ patientId: "P001" });

db.clinicalNotes.deleteOne({
    patientId: "P010"
});

db.clinicalNotes.find({ patientId: "P010" });
