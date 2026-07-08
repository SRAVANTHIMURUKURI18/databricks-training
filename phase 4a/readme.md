# SQL to PySpark Phase 4A – Bucketing & Segmentation

## Objective

Learn different techniques for converting continuous numerical values into meaningful business categories using PySpark.

---

## Dataset Used

* customers.csv
* sales.csv

---

## Workflow

1. Read customer and sales datasets.
2. Clean null and duplicate records.
3. Convert `total_amount` to a numeric type.
4. Calculate total spending for each customer.
5. Apply different segmentation techniques.
6. Compare the segmentation results.

---

## Tasks Completed

### Task 1 – Business Segmentation

Created Gold, Silver, and Bronze customer segments using conditional logic (`when()`).

### Task 2 – Customer Count by Segment

Grouped customers based on their segment and counted the number of customers in each category.

### Task 3 – Quantile-Based Segmentation

Used `approxQuantile()` to divide customers into Low, Medium, and High spending groups based on the data distribution.

### Task 4 – Bucketizer

Applied MLlib `Bucketizer` to categorize customer spending using predefined bucket ranges.

### Task 5 – Window-Based Ranking

Calculated the percentile rank of each customer using window functions and `percent_rank()`.

---

## Segmentation Methods Practiced

* Conditional Logic (`when`)
* Quantile-Based Segmentation
* MLlib Bucketizer
* Window Functions (`percent_rank`)

---

## Technologies Used

* Apache Spark
* PySpark
* Spark SQL
* MLlib

---

## Learning Outcomes

* Understood business segmentation.
* Learned multiple bucketing techniques.
* Compared fixed thresholds with data-driven segmentation.
* Used window functions for ranking customers.
* Applied MLlib Bucketizer for numerical categorization.
