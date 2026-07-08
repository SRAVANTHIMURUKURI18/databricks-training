# Initialize Spark Session

from pyspark.sql import SparkSession
from pyspark.sql.functions import *

spark = SparkSession.builder.appName("Spark Playground").getOrCreate()

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

display(customers)
display(sales)

customers.printSchema()
sales.printSchema()

# --------------------------------------------------
# Clean Data
# --------------------------------------------------

customers = customers.dropna(subset=["customer_id"])

sales = sales.dropna(subset=["customer_id"])

sales = sales.withColumn(
    "total_amount",
    col("total_amount").cast("double")
)

sales = sales.withColumn(
    "quantity",
    col("quantity").cast("int")
)

# Remove invalid records

sales = sales.filter(col("total_amount") > 0)

sales = sales.filter(col("quantity") > 0)

# --------------------------------------------------
# 1. Daily Sales
# --------------------------------------------------

print("1. Daily Sales")

daily_sales = sales.groupBy("sale_date") \
    .agg(sum("total_amount").alias("daily_sales")) \
    .orderBy("sale_date")

daily_sales.show()

# --------------------------------------------------
# 2. City-wise Revenue
# --------------------------------------------------

print("2. City-wise Revenue")

city_revenue = customers.join(
    sales,
    "customer_id"
).groupBy(
    "city"
).agg(
    sum("total_amount").alias("revenue")
).orderBy(desc("revenue"))

city_revenue.show()

# --------------------------------------------------
# 3. Repeat Customers (>2 Orders)
# --------------------------------------------------

print("3. Repeat Customers")

repeat_customers = sales.groupBy("customer_id") \
    .agg(count("sale_id").alias("order_count")) \
    .filter(col("order_count") > 2)

repeat_customers.show()

# --------------------------------------------------
# 4. Highest Spending Customer in Each City
# --------------------------------------------------

print("4. Highest Spending Customer in Each City")

city_spend = customers.join(
    sales,
    "customer_id"
).groupBy(
    "city",
    "customer_id",
    "first_name",
    "last_name"
).agg(
    sum("total_amount").alias("total_spend")
).orderBy(
    "city",
    desc("total_spend")
)

city_spend.show()

# --------------------------------------------------
# 5. Final Reporting Table
# --------------------------------------------------

print("5. Final Reporting Table")

report = customers.join(
    sales,
    "customer_id"
).groupBy(
    "customer_id",
    "first_name",
    "last_name",
    "city"
).agg(
    sum("total_amount").alias("total_spend"),
    count("sale_id").alias("order_count")
).orderBy(
    desc("total_spend")
)

report.show()

display(report)

# --------------------------------------------------
# Load (Optional)
# --------------------------------------------------

# report.write.mode("overwrite").csv("/tmp/final_report")
