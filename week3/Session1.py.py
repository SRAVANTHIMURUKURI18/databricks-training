# Databricks notebook source
# MAGIC %md
# MAGIC ##Reading and displaying a file

# COMMAND ----------

dff=spark.read.format("csv").option("header","true").option("inferSchema","true").load("/Volumes/workspace/default/databricks/Big Sales.csv")
dff.display()

# COMMAND ----------

df=spark.read.format("csv").option("header","true").option("inferSchema","true").load("/Volumes/workspace/default/databricks/empData.csv")
df.display()