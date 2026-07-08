# SQL to PySpark Phase 4 – Business Pipeline & Analytics

## Objective

Develop an end-to-end ETL pipeline using PySpark to generate business insights from customer and sales datasets. This phase demonstrates a complete data engineering workflow, from data ingestion and cleaning to analytics and reporting.

---

## ETL Workflow

### Extract

* Read `customers.csv`
* Read `sales.csv`

### Transform

* Inspect datasets
* Remove null customer IDs
* Remove duplicate records
* Convert data types
* Filter invalid values
* Join customer and sales data
* Perform aggregations
* Segment customers based on spending

### Load

* Display reports
* Save the final reporting table as a CSV file

---

## Tasks Completed

### Task 1 – Daily Sales

Calculated total sales for each sale date.

### Task 2 – City-wise Revenue

Calculated total revenue generated from each city.

### Task 3 – Top 5 Customers

Identified the top five customers based on total spending.

### Task 4 – Repeat Customers

Identified customers who placed more than one order.

### Task 5 – Customer Segmentation

Customers were segmented using the following business rules:

* Gold : Total Spend > 10000
* Silver : Total Spend between 5000 and 10000
* Bronze : Total Spend < 5000

### Task 6 – Final Reporting Table

Generated a consolidated report containing:

* Customer Name
* City
* Total Spend
* Order Count
* Customer Segment

### Task 7 – Save Output

Saved the final reporting table to:

`/samples/output/report`

---

## Technologies Used

* Apache Spark
* PySpark
* Spark Playground

---

## Concepts Practiced

* Reading CSV files
* Data Cleaning
* Removing Null Values
* Removing Duplicate Records
* Type Conversion
* Filtering Data
* DataFrame Joins
* Aggregations
* Customer Segmentation
* ETL Pipeline Development

---

## Project Structure

```
SQL-to-PySpark-Phase4/
│
├── phase4.py
├── Screenshots/
├── README.md
```

---

## Learning Outcomes

* Built an end-to-end ETL pipeline.
* Applied business logic for customer segmentation.
* Generated analytical reports using PySpark.
* Saved processed data for reporting purposes.
* Practiced data engineering concepts using Spark DataFrames.
