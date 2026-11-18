# Day 05: Normalisation and Data Definition

This repository contains practical database examples for SQL Server and MongoDB. It covers database and table creation, primary and foreign keys, constraints, identity columns, CRUD operations, joins, schema validation, capped collections, and basic data modelling.

## Repository Structure

```text
SQL_Server/
  Set1_Retail_Inventory.sql
  Set2_Bank_Accounts.sql
  Set3_Hospital_Records.sql

MongoDB/
  Set1_Retail_Inventory.js
  Set2_Bank_Accounts.js
  Set3_Hospital_Records.js
```

## Exercises

### Set 1: Retail Inventory

**SQL Server:** Creates `RetailInventoryDB` with suppliers, categories, warehouses, products, and inventory.

Topics include:
- Primary and foreign keys
- Unique constraints
- Check constraints
- Cascade and restricted delete behaviour
- Duplicate, invalid foreign key, negative quantity, and NULL tests
- Update and delete operations

**MongoDB:** Creates the `reviews` collection in `RetailInventoryDB`.

Topics include:
- JSON Schema validation
- Required fields
- Numeric ratings
- Array fields
- Insert, find, update, and delete operations

### Set 2: Bank Accounts

**SQL Server:** Creates `BankBranchDB` with customers, branches, managers, accounts, and transactions.

Topics include:
- Account and transaction relationships
- Identity columns
- `DELETE`, `TRUNCATE`, and rollback behaviour
- `AND`, `OR`, `IN`, `BETWEEN`, and JOIN queries
- Account balance updates

**MongoDB:** Creates a capped `customerActivity` collection in `BankBranchDB`.

Topics include:
- Capped collections
- Maximum collection size and document count
- Login and logout activity
- Filtering and sorting recent activity

### Set 3: Hospital Records

**SQL Server:** Creates `HospitalDB` with patients, departments, doctors, visits, and billing.

Topics include:
- One-to-many relationships
- Table alteration
- Adding and renaming columns
- Renaming tables
- Dropping constraints
- Schema metadata queries
- Patient, doctor, diagnosis, and billing queries

**MongoDB:** Creates the `clinicalNotes` collection in `HospitalDB`.

Topics include:
- JSON Schema validation
- Nested vitals objects
- Attachment arrays
- Follow-up dates
- Pattern and regex searches
- Update and delete operations

## Requirements

- Microsoft SQL Server
- SQL Server Management Studio or another SQL Server client
- MongoDB Server
- MongoDB Shell (`mongosh`) or a MongoDB GUI that supports JavaScript

## Running the SQL Server Scripts

1. Open SQL Server Management Studio.
2. Connect to a SQL Server instance.
3. Open a script from the `SQL_Server` folder.
4. Execute the complete script.

Run each set independently. The scripts create and switch to their own databases.

## Running the MongoDB Scripts

1. Start MongoDB.
2. Open `mongosh`.
3. Load a script from the `MongoDB` folder:

```javascript
load("C:/path/to/MongoDB/Set1_Retail_Inventory.js")
load("C:/path/to/MongoDB/Set2_Bank_Accounts.js")
load("C:/path/to/MongoDB/Set3_Hospital_Records.js")
```

You can also paste each script directly into `mongosh`. Run one set at a time.

## Key SQL Server Notes

- Scripts use `IDENTITY` for automatic primary key values.
- Foreign keys enforce relationships between tables.
- Check constraints reject invalid values.
- `TRUNCATE TABLE` resets an identity value to its starting value.
- `ROLLBACK` undoing a transaction preserves the previous data state.

## Key MongoDB Notes

- `use <databaseName>` creates or selects a database context.
- `$jsonSchema` validates inserted and updated documents.
- `NumberInt()` explicitly stores 32-bit integer values.
- Capped collections retain data in insertion order and automatically remove oldest documents when the limit is reached.
- MongoDB collections are created explicitly in these exercises to demonstrate schema and validation concepts.
