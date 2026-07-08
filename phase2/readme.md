# SQL to PySpark Phase 2 – Bridge Pack

## Objective

Bridge the gap between SQL and PySpark by implementing joins, aggregations, sorting, and filtering using the Spark Playground sample datasets.

---

## Dataset Used

Located in the `/samples` folder.

- customers.csv
- sales.csv

### customers.csv

| Column |
|---------|
| customer_id |
| first_name |
| last_name |
| email |
| phone_number |
| address |
| city |
| state |
| zip_code |

### sales.csv

| Column |
|---------|
| sale_id |
| customer_id |
| product_id |
| sale_date |
| quantity |
| total_amount |

---

## Data Cleaning

Before performing the analysis:

- Removed rows with missing `customer_id`
- Converted `total_amount` from String to Double
- Converted `quantity` from String to Integer

---

## Exercises Completed

### 1. Total order amount for each customer

- SQL
- PySpark

### 2. Top 3 customers by total spend

- SQL
- PySpark

### 3. Customers with no orders

- SQL
- PySpark

### 4. City-wise total revenue

- SQL
- PySpark

### 5. Average order amount per customer

- SQL
- PySpark

### 6. Customers with more than one order

- SQL
- PySpark

### 7. Sort customers by total spend descending

- SQL
- PySpark

---

## Project Structure

```
SQL-to-PySpark-Phase2/
│
├── SQL/
│   └── phase2.sql
│
├── PySpark/
│   └── phase2.py
│
├── Screenshots/
│   ├── exercise1.png
│   ├── exercise2.png
│   ├── exercise3.png
│   ├── exercise4.png
│   ├── exercise5.png
│   ├── exercise6.png
│   └── exercise7.png
│
└── README.md
```

---

## Technologies Used

- Apache Spark
- PySpark
- SQL
- Spark Playground

---

## Learning Outcomes

- SQL to PySpark conversion
- Data cleaning
- Group By and Aggregations
- Sorting and Ranking
- Inner Join
- Left Anti Join
- Aggregate functions (SUM, AVG, COUNT)
- Data type conversion using `cast()`

---

## Repository Contents

- SQL queries
- PySpark implementations
- Output screenshots
- README documentation
