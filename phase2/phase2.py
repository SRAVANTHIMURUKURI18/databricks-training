# Initialize Spark session
from pyspark.sql import SparkSession
from pyspark.sql.functions import *

spark = SparkSession.builder.appName("Spark Playground").getOrCreate()

# Load the customers.csv dataset
customers = spark.read.format("csv") \
    .option("header", "true") \
    .load("/samples/customers.csv")

# Load the orders.csv dataset
orders = spark.read.format("csv") \
    .option("header", "true") \
    .load("/samples/orders.csv")

# Show datasets
customers.show(5)
orders.show(5)

# Display DataFrames
display(customers)
display(orders)

# Display schema
customers.printSchema()
orders.printSchema()

# ---------------------------
# Data Cleaning
# ---------------------------

customers = customers.dropna(subset=["customer_id"])
orders = orders.dropna(subset=["customer_id"])

# Convert amount column to numeric
orders = orders.withColumn("amount", col("amount").cast("double"))

# ---------------------------
# 1. Total order amount for each customer
# ---------------------------

print("1. Total Order Amount for Each Customer")

orders.groupBy("customer_id") \
    .agg(sum("amount").alias("total_amount")) \
    .show()

# ---------------------------
# 2. Top 3 customers by total spend
# ---------------------------

print("2. Top 3 Customers by Total Spend")

orders.groupBy("customer_id") \
    .agg(sum("amount").alias("total_spend")) \
    .orderBy(desc("total_spend")) \
    .limit(3) \
    .show()

# ---------------------------
# 3. Customers with no orders
# ---------------------------

print("3. Customers with No Orders")

customers.join(
    orders,
    "customer_id",
    "left_anti"
).show()

# ---------------------------
# 4. City-wise total revenue
# ---------------------------

print("4. City-wise Total Revenue")

customers.join(
    orders,
    "customer_id",
    "inner"
).groupBy("city") \
 .agg(sum("amount").alias("revenue")) \
 .show()

# ---------------------------
# 5. Average order amount per customer
# ---------------------------

print("5. Average Order Amount per Customer")

orders.groupBy("customer_id") \
    .agg(avg("amount").alias("average_amount")) \
    .show()

# ---------------------------
# 6. Customers with more than one order
# ---------------------------

print("6. Customers with More Than One Order")

orders.groupBy("customer_id") \
    .agg(count("*").alias("total_orders")) \
    .filter(col("total_orders") > 1) \
    .show()

# ---------------------------
# 7. Sort customers by total spend descending
# ---------------------------

print("7. Customers Sorted by Total Spend")

orders.groupBy("customer_id") \
    .agg(sum("amount").alias("total_spend")) \
    .orderBy(desc("total_spend")) \
    .show()
