# Initialize Spark Session

from pyspark.sql import SparkSession
from pyspark.sql.functions import *
from pyspark.sql.window import Window
from pyspark.ml.feature import Bucketizer

spark = SparkSession.builder.appName("Bucketing & Segmentation").getOrCreate()

# --------------------------------------------------
# Read Data
# --------------------------------------------------

customers = spark.read.format("csv") \
    .option("header", "true") \
    .load("/samples/customers.csv")

sales = spark.read.format("csv") \
    .option("header", "true") \
    .load("/samples/sales.csv")

# --------------------------------------------------
# Data Cleaning
# --------------------------------------------------

customers = customers.dropna(subset=["customer_id"])
sales = sales.dropna(subset=["customer_id"])

customers = customers.dropDuplicates()
sales = sales.dropDuplicates()

sales = sales.withColumn(
    "total_amount",
    col("total_amount").cast("double")
)

sales = sales.filter(col("total_amount") > 0)

# --------------------------------------------------
# Calculate Total Spend Per Customer
# --------------------------------------------------

customer_spend = customers.join(
    sales,
    "customer_id"
).groupBy(
    "customer_id",
    "first_name",
    "last_name",
    "city"
).agg(
    sum("total_amount").alias("total_spend")
)

customer_spend = customer_spend.withColumn(
    "customer_name",
    concat_ws(" ", col("first_name"), col("last_name"))
)

# --------------------------------------------------
# Task 1
# Gold / Silver / Bronze using when()
# --------------------------------------------------

print("Task 1")

segment_df = customer_spend.withColumn(
    "segment",
    when(col("total_spend") > 10000, "Gold")
    .when(
        (col("total_spend") >= 5000) &
        (col("total_spend") <= 10000),
        "Silver"
    )
    .otherwise("Bronze")
)

segment_df.select(
    "customer_name",
    "total_spend",
    "segment"
).show()

# --------------------------------------------------
# Task 2
# Count Customers by Segment
# --------------------------------------------------

print("Task 2")

segment_df.groupBy("segment") \
    .count() \
    .show()

# --------------------------------------------------
# Task 3
# Quantile Segmentation
# --------------------------------------------------

print("Task 3")

q1, q2 = segment_df.approxQuantile(
    "total_spend",
    [0.33, 0.66],
    0
)

quantile_df = segment_df.withColumn(
    "quantile_segment",
    when(col("total_spend") <= q1, "Low")
    .when(col("total_spend") <= q2, "Medium")
    .otherwise("High")
)

quantile_df.select(
    "customer_name",
    "total_spend",
    "quantile_segment"
).show()

# --------------------------------------------------
# Task 4
# Bucketizer
# --------------------------------------------------

print("Task 4")

splits = [-float("inf"), 5000, 10000, float("inf")]

bucketizer = Bucketizer(
    splits=splits,
    inputCol="total_spend",
    outputCol="bucket"
)

bucket_df = bucketizer.transform(segment_df)

bucket_df.select(
    "customer_name",
    "total_spend",
    "bucket"
).show()

# --------------------------------------------------
# Task 5
# Window Ranking
# --------------------------------------------------

print("Task 5")

window = Window.orderBy("total_spend")

rank_df = segment_df.withColumn(
    "percent_rank",
    percent_rank().over(window)
)

rank_df.select(
    "customer_name",
    "total_spend",
    "percent_rank"
).show()
