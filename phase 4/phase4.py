# Initialize Spark Session

from pyspark.sql import SparkSession
from pyspark.sql.functions import *

spark = SparkSession.builder.appName("Business Pipeline & Analytics").getOrCreate()

# --------------------------------------------------
# Extract
# --------------------------------------------------

customers = spark.read.format("csv") \
    .option("header", "true") \
    .load("/samples/customers.csv")

sales = spark.read.format("csv") \
    .option("header", "true") \
    .load("/samples/sales.csv")

# --------------------------------------------------
# Inspect Data
# --------------------------------------------------

customers.show(5)
sales.show(5)

customers.printSchema()
sales.printSchema()

# --------------------------------------------------
# Data Cleaning
# --------------------------------------------------

customers = customers.dropna(subset=["customer_id"])
sales = sales.dropna(subset=["customer_id"])

customers = customers.dropDuplicates()
sales = sales.dropDuplicates()

sales = sales.withColumn("total_amount", col("total_amount").cast("double"))
sales = sales.withColumn("quantity", col("quantity").cast("int"))

sales = sales.filter(col("total_amount") > 0)
sales = sales.filter(col("quantity") > 0)

# --------------------------------------------------
# Join Data
# --------------------------------------------------

customer_sales = customers.join(sales, "customer_id", "inner")

# --------------------------------------------------
# Task 1 - Daily Sales
# --------------------------------------------------

print("Task 1 - Daily Sales")

daily_sales = customer_sales.groupBy("sale_date") \
    .agg(sum("total_amount").alias("total_sales")) \
    .orderBy("sale_date")

daily_sales.show()

# --------------------------------------------------
# Task 2 - City-wise Revenue
# --------------------------------------------------

print("Task 2 - City-wise Revenue")

city_revenue = customer_sales.groupBy("city") \
    .agg(sum("total_amount").alias("total_revenue")) \
    .orderBy(desc("total_revenue"))

city_revenue.show()

# --------------------------------------------------
# Task 3 - Top 5 Customers
# --------------------------------------------------

print("Task 3 - Top 5 Customers")

top_customers = customer_sales.groupBy(
    "customer_id",
    "first_name",
    "last_name"
).agg(
    sum("total_amount").alias("total_spend")
).withColumn(
    "customer_name",
    concat_ws(" ", col("first_name"), col("last_name"))
).select(
    "customer_name",
    "total_spend"
).orderBy(
    desc("total_spend")
).limit(5)

top_customers.show()

# --------------------------------------------------
# Task 4 - Repeat Customers
# --------------------------------------------------

print("Task 4 - Repeat Customers")

repeat_customers = customer_sales.groupBy("customer_id") \
    .agg(count("sale_id").alias("order_count")) \
    .filter(col("order_count") > 1)

repeat_customers.show()

# --------------------------------------------------
# Task 5 - Customer Segmentation
# --------------------------------------------------

print("Task 5 - Customer Segmentation")

customer_segment = customer_sales.groupBy(
    "customer_id",
    "first_name",
    "last_name",
    "city"
).agg(
    sum("total_amount").alias("total_spend"),
    count("sale_id").alias("order_count")
)

customer_segment = customer_segment.withColumn(
    "customer_name",
    concat_ws(" ", col("first_name"), col("last_name"))
)

customer_segment = customer_segment.withColumn(
    "segment",
    when(col("total_spend") > 10000, "Gold")
    .when((col("total_spend") >= 5000) & (col("total_spend") <= 10000), "Silver")
    .otherwise("Bronze")
)

customer_segment.select(
    "customer_name",
    "total_spend",
    "segment"
).show()

# --------------------------------------------------
# Task 6 - Final Reporting Table
# --------------------------------------------------

print("Task 6 - Final Reporting Table")

final_df = customer_segment.select(
    "customer_name",
    "city",
    "total_spend",
    "order_count",
    "segment"
).orderBy(
    desc("total_spend")
)

final_df.show()

display(final_df)

# --------------------------------------------------
# Task 7 - Save Output
# --------------------------------------------------

final_df.write.mode("overwrite").option("header", "true").csv("/samples/output/report")

print("Report saved successfully.")
