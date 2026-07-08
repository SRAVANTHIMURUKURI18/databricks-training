# Initialize Spark session
from pyspark.sql import SparkSession
from pyspark.sql.functions import *

spark = SparkSession.builder.appName("Spark Playground").getOrCreate()

# Load datasets
customers = spark.read.format("csv") \
    .option("header", "true") \
    .load("/samples/customers.csv")

sales = spark.read.format("csv") \
    .option("header", "true") \
    .load("/samples/sales.csv")

# Display datasets
customers.show(5)
sales.show(5)

display(customers)
display(sales)

# Print schema
customers.printSchema()
sales.printSchema()

# --------------------------------------------------
# Data Cleaning
# --------------------------------------------------

customers = customers.dropna(subset=["customer_id"])
sales = sales.dropna(subset=["customer_id"])

# Convert columns to appropriate data types
sales = sales.withColumn("total_amount", col("total_amount").cast("double"))
sales = sales.withColumn("quantity", col("quantity").cast("int"))

# --------------------------------------------------
# 1. Total order amount for each customer
# --------------------------------------------------

print("1. Total Order Amount for Each Customer")

sales.groupBy("customer_id") \
    .agg(sum("total_amount").alias("total_order_amount")) \
    .show()

# --------------------------------------------------
# 2. Top 3 customers by total spend
# --------------------------------------------------

print("2. Top 3 Customers by Total Spend")

sales.groupBy("customer_id") \
    .agg(sum("total_amount").alias("total_spend")) \
    .orderBy(desc("total_spend")) \
    .limit(3) \
    .show()

# --------------------------------------------------
# 3. Customers with no orders
# --------------------------------------------------

print("3. Customers with No Orders")

customers.join(
    sales,
    "customer_id",
    "left_anti"
).show()

# --------------------------------------------------
# 4. City-wise Total Revenue
# --------------------------------------------------

print("4. City-wise Total Revenue")

customers.join(
    sales,
    "customer_id",
    "inner"
).groupBy("city") \
 .agg(sum("total_amount").alias("revenue")) \
 .orderBy(desc("revenue")) \
 .show()

# --------------------------------------------------
# 5. Average order amount per customer
# --------------------------------------------------

print("5. Average Order Amount per Customer")

sales.groupBy("customer_id") \
    .agg(avg("total_amount").alias("average_order_amount")) \
    .show()

# --------------------------------------------------
# 6. Customers with more than one order
# --------------------------------------------------

print("6. Customers with More Than One Order")

sales.groupBy("customer_id") \
    .agg(count("sale_id").alias("total_orders")) \
    .filter(col("total_orders") > 1) \
    .show()

# --------------------------------------------------
# 7. Sort customers by total spend descending
# --------------------------------------------------

print("7. Customers Sorted by Total Spend")

sales.groupBy("customer_id") \
    .agg(sum("total_amount").alias("total_spend")) \
    .orderBy(desc("total_spend")) \
    .show()
