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

# Show datasets
customers.show(5)
sales.show(5)

# Display DataFrames
display(customers)
display(sales)

# Print schema
customers.printSchema()
sales.printSchema()

# Data Cleaning
customers = customers.dropna(subset=["customer_id"])
sales = sales.dropna(subset=["customer_id"])

# Convert amount column to numeric
sales = sales.withColumn("amount", col("amount").cast("double"))
