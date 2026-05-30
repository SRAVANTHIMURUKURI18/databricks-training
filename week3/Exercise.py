# Databricks notebook source


# COMMAND ----------

from pyspark.sql import SparkSession
from pyspark.sql.functions import *

# Create Spark Session
spark = SparkSession.builder.appName("PySparkPractice").getOrCreate()

# Employee Dataset
employee_data = [
    (101, "Sravan", "Data Engineer", "IT", 75000, "Hyderabad", 28, "2021-05-10", "Male"),
    (102, "Ravi", "Software Engineer", "IT", 68000, "Bangalore", 30, "2020-03-15", "Male"),
    (103, "Priya", "Data Analyst", "Analytics", 62000, "Chennai", 26, "2022-01-12", "Female"),
    (104, "Kiran", "Manager", "HR", 90000, "Mumbai", 35, "2018-07-19", "Male"),
    (105, "Anjali", "HR Executive", "HR", 45000, "Pune", 24, "2023-02-20", "Female"),
    (106, "Vikram", "Data Scientist", "Analytics", 98000, "Delhi", 32, "2019-11-25", "Male"),
    (107, "Sneha", "Developer", "IT", 71000, "Hyderabad", 27, "2021-08-17", "Female"),
    (108, "Rahul", "Tester", "QA", 55000, "Chennai", 29, "2020-06-10", "Male"),
    (109, "Meena", "QA Lead", "QA", 83000, "Bangalore", 33, "2017-09-14", "Female"),
    (110, "Arjun", "Support Engineer", "Support", 50000, "Pune", 31, "2022-04-11", "Male")
]

columns = [
    "emp_id",
    "name",
    "designation",
    "department",
    "salary",
    "city",
    "age",
    "joining_date",
    "gender"
]

# Create DataFrame
emp_df = spark.createDataFrame(employee_data, columns)

# Display Data
emp_df.show()

# COMMAND ----------

# MAGIC %md
# MAGIC ##select()
# MAGIC

# COMMAND ----------

# 1. Select only employee name and salary columns.
emp_df.select(col("name"), col("salary")).display()

# 2. Select emp_id, department and city columns.
emp_df.select(col("emp_id"), col("department"), col("city")).display()

# 3. Select all employees with only name and age.
emp_df.select(col("name"), col("age")).display()

# 4. Select designation and salary columns.
emp_df.select(col("designation"), col("salary")).display()

# 5. Select emp_id, name and joining_date columns.
emp_df.select(col("emp_id"), col("name"), col("joining_date")).display()

# COMMAND ----------

# MAGIC %md
# MAGIC ##filter()/where()

# COMMAND ----------

# 1. Find employees whose salary is greater than 70000.
emp_df.filter(col("salary") > 70000).display()

# 2. Find employees working in IT department.
emp_df.filter(col("department") == "IT").display()

# 3. Find employees whose age is less than 30.
emp_df.filter(col("age") < 30).display()

# 4. Find female employees.
emp_df.filter(col("gender") == "Female").display()

# 5. Find employees from Hyderabad city.
emp_df.filter(col("city") == "Hyderabad").display()

# COMMAND ----------

# MAGIC %md
# MAGIC ##withColumn()

# COMMAND ----------

# 1. Add a new column bonus with 10% of salary.
emp_df.withColumn("bonus", col("salary") * 0.10).display()

# 2. Add a new column tax with 5% deduction.
emp_df.withColumn("tax", col("salary") * 0.05).display()

# 3. Add a new column salary_increment with salary + 5000.
emp_df.withColumn("salary_increment", col("salary") + 5000).display()

# 4. Create a new column age_group based on age.
emp_df.withColumn(
    "age_group",
    when(col("age") < 30, "Young").otherwise("Adult")
).display()

# 5. Add a column yearly_salary = salary * 12.
emp_df.withColumn("yearly_salary", col("salary") * 12).display()

# COMMAND ----------

# MAGIC %md
# MAGIC ##withColumnRenamed()

# COMMAND ----------

# 1. Rename emp_id to employee_id.
emp_df.withColumnRenamed("emp_id", "employee_id").display()

# 2. Rename designation to role.
emp_df.withColumnRenamed("designation", "role").display()

# 3. Rename salary to monthly_salary.
emp_df.withColumnRenamed("salary", "monthly_salary").display()

# 4. Rename city to work_location.
emp_df.withColumnRenamed("city", "work_location").display()

# 5. Rename joining_date to doj.
emp_df.withColumnRenamed("joining_date", "doj").display()

# COMMAND ----------



# COMMAND ----------

# MAGIC %md
# MAGIC ##drop()

# COMMAND ----------

# 1. Drop age column.
emp_df.drop("age").display()

# 2. Drop gender column.
emp_df.drop("gender").display()

# 3. Drop joining_date column.
emp_df.drop("joining_date").display()

# 4. Drop city and age columns.
emp_df.drop("city", "age").display()

# 5. Drop designation column.
emp_df.drop("designation").display()

# COMMAND ----------

# MAGIC %md
# MAGIC ##distinct()

# COMMAND ----------

# 1. Find distinct departments.
emp_df.select(col("department")).distinct().display()

# 2. Find distinct cities.
emp_df.select(col("city")).distinct().display()

# 3. Find distinct designations.
emp_df.select(col("designation")).distinct().display()

# 4. Find distinct genders.
emp_df.select(col("gender")).distinct().display()

# 5. Find unique department and city combinations.
emp_df.select(col("department"), col("city")).distinct().display()

# COMMAND ----------

# MAGIC %md
# MAGIC ##dropDuplicates()

# COMMAND ----------

# 1. Remove duplicate rows based on emp_id.
emp_df.dropDuplicates(["emp_id"]).display()

# 2. Remove duplicates based on department.
emp_df.dropDuplicates(["department"]).display()

# 3. Remove duplicates based on city.
emp_df.dropDuplicates(["city"]).display()

# 4. Remove duplicates based on department and city.
emp_df.dropDuplicates(["department", "city"]).display()

# 5. Remove duplicate employees based on name.
emp_df.dropDuplicates(["name"]).display()

# COMMAND ----------

# MAGIC %md
# MAGIC ##sort() / orderBy()

# COMMAND ----------

# 1. Sort employees by salary ascending.
emp_df.sort(col("salary").asc()).display()

# 2. Sort employees by age descending.
emp_df.sort(col("age").desc()).display()

# 3. Sort employees by department and salary.
emp_df.sort(col("department"), col("salary")).display()

# 4. Sort employees by city.
emp_df.orderBy(col("city")).display()

# 5. Sort employees by joining_date descending.
emp_df.orderBy(col("joining_date").desc()).display()

# COMMAND ----------

# MAGIC %md
# MAGIC ##groupBy()

# COMMAND ----------

# 1. Find average salary by department.
emp_df.groupBy("department") \
      .avg("salary") \
      .display()

# 2. Find maximum salary in each department.
emp_df.groupBy("department") \
      .max("salary") \
      .display()

# 3. Find minimum age in each department.
emp_df.groupBy("department") \
      .min("age") \
      .display()

# 4. Count employees in each city.
emp_df.groupBy("city") \
      .count() \
      .display()

# 5. Find total salary by gender.
emp_df.groupBy("gender") \
      .sum("salary") \
      .display()

# COMMAND ----------

# MAGIC %md
# MAGIC ##agg()

# COMMAND ----------

# 1. Find total salary of all employees.
emp_df.agg(sum("salary")).display()

# 2. Find average employee age.
emp_df.agg(avg("age")).display()

# 3. Find max and min salary together.
emp_df.agg(
    max("salary"),
    min("salary")
).display()

# 4. Find count of employees.
emp_df.agg(count("emp_id")).display()

# 5. Find average salary and average age department-wise.
emp_df.groupBy("department") \
      .agg(
          avg("salary").alias("avg_salary"),
          avg("age").alias("avg_age")
      ) \
      .display()

# COMMAND ----------

# MAGIC %md
# MAGIC ##join()

# COMMAND ----------

# Department Dataset
department_data = [
    ("IT", "John"),
    ("HR", "Smith"),
    ("QA", "David"),
    ("Analytics", "Kevin"),
    ("Support", "Robert")
]

dept_columns = ["department", "manager"]

dept_df = spark.createDataFrame(department_data, dept_columns)

# 1. Perform inner join between emp_df and dept_df.
emp_df.join(dept_df, on="department", how="inner").display()

# 2. Perform left join.
emp_df.join(dept_df, on="department", how="left").display()

# 3. Perform right join.
emp_df.join(dept_df, on="department", how="right").display()

# 4. Perform full outer join.
emp_df.join(dept_df, on="department", how="outer").display()

# 5. Find employees along with manager names.
emp_df.join(dept_df, on="department", how="inner") \
      .select(
          col("name"),
          col("department"),
          col("manager")
      ) \
      .display()

# COMMAND ----------

# MAGIC %md
# MAGIC ##union()

# COMMAND ----------

# Additional Dataset
new_emp_data = [
    (111, "Teja", "Developer", "IT", 72000, "Hyderabad", 26, "2023-01-10", "Male"),
    (112, "Divya", "Analyst", "Analytics", 65000, "Bangalore", 25, "2022-11-05", "Female")
]

new_emp_df = spark.createDataFrame(new_emp_data, columns)

# 1. Union emp_df with new_emp_df.
emp_union_df = emp_df.union(new_emp_df)
emp_union_df.display()

# 2. Count total rows after union.
emp_union_df.agg(count("emp_id").alias("count")).display()

# 3. Remove duplicates after union.
emp_df.union(new_emp_df) \
      .distinct() \
      .display()

# 4. Find all IT employees after union.
emp_df.union(new_emp_df) \
      .filter(col("department") == "IT") \
      .display()

# 5. Sort unioned dataframe by salary.
emp_df.union(new_emp_df) \
      .orderBy(col("salary").desc()) \
      .display()

# COMMAND ----------

# MAGIC %md
# MAGIC ##unionByName()

# COMMAND ----------

# Create another dataframe with shuffled columns
shuffled_columns = [
    "name",
    "emp_id",
    "department",
    "designation",
    "salary",
    "city",
    "age",
    "joining_date",
    "gender"
]

shuffled_data = [
    ("Karthik", 113, "IT", "Developer", 70000, "Hyderabad", 27, "2023-03-15", "Male"),
    ("Lavanya", 114, "HR", "HR Executive", 48000, "Pune", 25, "2022-09-10", "Female")
]

shuffled_df = spark.createDataFrame(shuffled_data, shuffled_columns)

# 1. Perform unionByName with shuffled columns.
emp_df.unionByName(shuffled_df).display()

# 2. Use allowMissingColumns=True.
extra_data = [
    (115, "Ramesh", "Tester", "QA", 60000, "Chennai", 29, "2023-05-12", "Male", "Night Shift")
]

extra_columns = columns + ["shift"]

extra_df = spark.createDataFrame(extra_data, extra_columns)

emp_df.unionByName(extra_df, allowMissingColumns=True).display()

# 3. Add extra column and perform unionByName.
new_df = emp_df.withColumn("bonus", lit(5000))

new_df.unionByName(
    emp_df,
    allowMissingColumns=True
).display()

# 4. Compare union vs unionByName.

# union()
# emp_df.union(shuffled_df).display()

# unionByName()
emp_df.unionByName(shuffled_df).display()

# 5. Merge employee datasets with different schemas.
emp_df.unionByName(
    extra_df,
    allowMissingColumns=True
).display()

# COMMAND ----------

# MAGIC %md
# MAGIC ##limit()

# COMMAND ----------

# 1. Show first 3 records.
emp_df.limit(3).display()

# 2. Show first 5 employees.
emp_df.limit(5).display()

# 3. Get top 2 highest salary employees.
emp_df.orderBy(col("salary").desc()) \
      .limit(2) \
      .display()

# 4. Get first 4 IT employees.
emp_df.filter(col("department") == "IT") \
      .limit(4) \
      .display()

# 5. Show first employee record.
emp_df.limit(1).display()

# COMMAND ----------

# MAGIC %md
# MAGIC ##sample()

# COMMAND ----------

# 1. Take 50% sample of data.
emp_df.sample(0.5).display()

# 2. Take 30% sample with seed.
emp_df.sample(0.3, seed=10).display()

# 3. Take sample from IT employees.
emp_df.filter(col("department") == "IT") \
      .sample(0.5) \
      .display()

# 4. Compare full data vs sampled data.
print("Full Data Count:", emp_df.count())

sample_df = emp_df.sample(0.4)

print("Sample Data Count:", sample_df.count())

sample_df.display()

# 5. Take random sample of 5 rows.
emp_df.orderBy(rand()) \
      .limit(5) \
      .display()

# COMMAND ----------

# MAGIC %md
# MAGIC ##explode()

# COMMAND ----------

# Skills Dataset
skills_data = [
    (101, ["Python", "Spark", "Azure"]),
    (102, ["Java", "SQL"]),
    (103, ["Power BI", "SQL"])
]

skills_columns = ["emp_id", "skills"]

skills_df = spark.createDataFrame(skills_data, skills_columns)

# 1. Explode skills array into multiple rows.
skills_df.withColumn(
    "skill",
    explode(col("skills"))
).display()

# 2. Count total skills.
skills_df.withColumn(
    "skill",
    explode(col("skills"))
).agg(count("skills")).display()

# 3. Find employees with Python skill.
skills_df.withColumn(
    "skill",
    explode(col("skills"))
).filter(
    col("skill") == "Python"
).display()

# 4. Find distinct skills.
skills_df.withColumn(
    "skill",
    explode(col("skills"))
).select(
    col("skill")
).distinct().display()

# 5. Group employees by skill.
skills_df.withColumn(
    "skill",
    explode(col("skills"))
).groupBy(
    col("skill")
).count().display()

# COMMAND ----------

# MAGIC %md
# MAGIC #3split()

# COMMAND ----------

# 1. Split joining_date into year, month and day.
emp_df.withColumn(
    "year",
    split(col("joining_date"), "-")[0]
).withColumn(
    "month",
    split(col("joining_date"), "-")[1]
).withColumn(
    "day",
    split(col("joining_date"), "-")[2]
).display()

# 2. Split designation into words.
emp_df.withColumn(
    "designation_words",
    split(col("designation"), " ")
).display()

# 3. Split city names.
emp_df.withColumn(
    "city_split",
    split(col("city"), "")
).display()

# 4. Extract year from joining_date.
emp_df.withColumn(
    "joining_year",
    split(col("joining_date"), "-")[0]
).display()

# 5. Create separate columns using split.
emp_df.withColumn(
    "year",
    split(col("joining_date"), "-")[0]
).withColumn(
    "month",
    split(col("joining_date"), "-")[1]
).withColumn(
    "day",
    split(col("joining_date"), "-")[2]
).select(
    col("name"),
    col("joining_date"),
    col("year"),
    col("month"),
    col("day")
).display()

# COMMAND ----------

# MAGIC %md
# MAGIC ##concat() / concat_ws()

# COMMAND ----------

# 1. Concatenate name and department.
emp_df.withColumn(
    "name_department",
    concat(col("name"), col("department"))
).display()

# 2. Create full employee details column.
emp_df.withColumn(
    "employee_details",
    concat_ws(
        " | ",
        col("name"),
        col("designation"),
        col("department"),
        col("city")
    )
).display()

# 3. Concatenate city and department with hyphen.
emp_df.withColumn(
    "city_department",
    concat_ws("-", col("city"), col("department"))
).display()

# 4. Create employee label using concat_ws.
emp_df.withColumn(
    "employee_label",
    concat_ws(
        "_",
        col("emp_id"),
        col("name"),
        col("department")
    )
).display()

# 5. Combine name and designation.
emp_df.withColumn(
    "name_designation",
    concat_ws(" - ", col("name"), col("designation"))
).display()

# COMMAND ----------

# MAGIC %md
# MAGIC ##cast()

# COMMAND ----------

# 1. Cast salary to double.
emp_df.withColumn(
    "salary_double",
    col("salary").cast("double")
).display()

# 2. Cast age to string.
emp_df.withColumn(
    "age_string",
    col("age").cast("string")
).display()

# 3. Convert joining_date to date type.
emp_df.withColumn(
    "joining_date_type",
    col("joining_date").cast("date")
).display()

# 4. Cast emp_id to string.
emp_df.withColumn(
    "emp_id_string",
    col("emp_id").cast("string")
).display()

# 5. Create numeric bonus column.
emp_df.withColumn(
    "bonus",
    (col("salary") * 0.10).cast("integer")
).display()

# COMMAND ----------

# MAGIC %md
# MAGIC ##alias()

# COMMAND ----------

# 1. Display salary as monthly_salary.
emp_df.select(
    col("salary").alias("monthly_salary")
).display()

# 2. Display department as dept_name.
emp_df.select(
    col("department").alias("dept_name")
).display()

# 3. Use alias in aggregation.
emp_df.groupBy("department") \
      .agg(
          avg("salary").alias("average_salary")
      ) \
      .display()

# 4. Rename average salary column using alias.
emp_df.agg(
    avg("salary").alias("avg_salary")
).display()

# 5. Use alias in joins.
e = emp_df.alias("e")
d = dept_df.alias("d")
e.join(d, on="department", how="inner") \
 .select(
     col("e.emp_id"),
     col("e.department"),
     col("d.manager")
 ) \
 .display()

# COMMAND ----------

# MAGIC %md
# MAGIC ##lit()

# COMMAND ----------

# 1. Add company_name column.
emp_df.withColumn(
    "company_name",
    lit("TCS")
).display()

# 2. Add country column with value India.
emp_df.withColumn(
    "country",
    lit("India")
).display()

# 3. Add constant bonus column.
emp_df.withColumn(
    "bonus",
    lit(5000)
).display()

# 4. Add status column as Active.
emp_df.withColumn(
    "status",
    lit("Active")
).display()

# 5. Add training column with Yes.
emp_df.withColumn(
    "training",
    lit("Yes")
).display()

# COMMAND ----------

# MAGIC %md
# MAGIC ##when() / otherwise()

# COMMAND ----------

# 1. Categorize salary as High and Low.
emp_df.withColumn(
    "salary_category",
    when(col("salary") > 70000, "High")
    .otherwise("Low")
).display()

# 2. Categorize employees based on age.
emp_df.withColumn(
    "age_category",
    when(col("age") < 30, "Young")
    .otherwise("Senior")
).display()

# 3. Create experience level column.
emp_df.withColumn(
    "experience_level",
    when(col("age") < 25, "Fresher")
    .when(col("age") < 32, "Mid-Level")
    .otherwise("Experienced")
).display()

# 4. Mark employees eligible for bonus.
emp_df.withColumn(
    "bonus_eligible",
    when(col("salary") >= 70000, "Yes")
    .otherwise("No")
).display()

# 5. Create department category column.
emp_df.withColumn(
    "department_category",
    when(col("department") == "IT", "Technical")
    .when(col("department") == "Analytics", "Technical")
    .otherwise("Non-Technical")
).display()

# COMMAND ----------

# MAGIC %md
# MAGIC ##substring()

# COMMAND ----------

# 1. Extract first 3 characters from name.
emp_df.withColumn(
    "short_name",
    substring(col("name"), 1, 3)
).display()

# 2. Extract year from joining_date.
emp_df.withColumn(
    "joining_year",
    substring(col("joining_date"), 1, 4)
).display()

# 3. Extract first 2 letters of department.
emp_df.withColumn(
    "dept_code",
    substring(col("department"), 1, 2)
).display()

# 4. Extract last 3 characters from designation.
emp_df.withColumn(
    "designation_last3",
    substring(
        col("designation"),
        length(col("designation")) - 2,
        3
    )
).display()

# 5. Create short employee code.
emp_df.withColumn(
    "employee_code",
    concat(
        substring(col("name"), 1, 3),
        lit("_"),
        substring(col("department"), 1, 2)
    )
).display()

# COMMAND ----------

# MAGIC %md
# MAGIC ##regexp_replace()

# COMMAND ----------

# 1. Replace spaces in designation with underscore.
emp_df.withColumn(
    "designation_updated",
    regexp_replace(col("designation"), " ", "_")
).display()

# 2. Remove vowels from names.
emp_df.withColumn(
    "name_no_vowels",
    regexp_replace(col("name"), "[AEIOUaeiou]", "")
).display()

# 3. Replace Hyderabad with HYD.
emp_df.withColumn(
    "city_updated",
    regexp_replace(col("city"), "Hyderabad", "HYD")
).display()

# 4. Remove special characters.
emp_df.withColumn(
    "clean_designation",
    regexp_replace(col("designation"), "[^a-zA-Z0-9 ]", "")
).display()

# 5. Standardize department names.
emp_df.withColumn(
    "department_updated",
    regexp_replace(col("department"), "IT", "Information Technology")
).display()

# COMMAND ----------

# MAGIC %md
# MAGIC ##like()

# COMMAND ----------

# 1. Find names starting with S.
emp_df.filter(
    col("name").like("S%")
).display()

# 2. Find designations ending with Engineer.
emp_df.filter(
    col("designation").like("%Engineer")
).display()

# 3. Find cities containing 'a'.
emp_df.filter(
    col("city").like("%a%")
).display()

# 4. Find departments starting with A.
emp_df.filter(
    col("department").like("A%")
).display()

# 5. Find employees whose name contains 'ra'.
emp_df.filter(
    col("name").like("%ra%")
).display()

# COMMAND ----------

# MAGIC %md
# MAGIC ##isin()

# COMMAND ----------

# 1. Find employees from Hyderabad and Bangalore.
emp_df.filter(
    col("city").isin("Hyderabad", "Bangalore")
).display()

# 2. Find employees in IT and QA departments.
emp_df.filter(
    col("department").isin("IT", "QA")
).display()

# 3. Find employees with age 28, 30 and 35.
emp_df.filter(
    col("age").isin(28, 30, 35)
).display()

# 4. Filter female employees from Pune and Chennai.
emp_df.filter(
    (col("gender") == "Female") &
    (col("city").isin("Pune", "Chennai"))
).display()

# 5. Find employees with specific emp_ids.
emp_df.filter(
    col("emp_id").isin(101, 105, 109)
).display()

# COMMAND ----------

# MAGIC %md
# MAGIC ##between()

# COMMAND ----------

# 1. Find employees with salary between 50000 and 80000.
emp_df.filter(
    col("salary").between(50000, 80000)
).display()

# 2. Find employees aged between 25 and 30.
emp_df.filter(
    col("age").between(25, 30)
).display()

# 3. Find salaries between 60000 and 90000.
emp_df.filter(
    col("salary").between(60000, 90000)
).display()

# 4. Find employees joined between years.
emp_df.filter(
    substring(col("joining_date"), 1, 4).between("2020", "2022")
).display()

# 5. Find employees with emp_id between 102 and 108.
emp_df.filter(
    col("emp_id").between(102, 108)
).display()

# COMMAND ----------

# MAGIC %md
# MAGIC ##pivot()

# COMMAND ----------

# 1. Pivot department with average salary.
emp_df.groupBy("gender") \
      .pivot("department") \
      .avg("salary") \
      .display()

# 2. Pivot city with employee count.
emp_df.groupBy("department") \
      .pivot("city") \
      .count() \
      .display()

# 3. Pivot gender with total salary.
emp_df.groupBy("department") \
      .pivot("gender") \
      .sum("salary") \
      .display()

# 4. Pivot department with maximum age.
emp_df.groupBy("city") \
      .pivot("department") \
      .max("age") \
      .display()

# 5. Create department-wise summary table.
emp_df.groupBy("gender") \
      .pivot("department") \
      .agg(
          avg("salary")
      ) \
      .display()

# COMMAND ----------

# MAGIC %md
# MAGIC ##unpivot()

# COMMAND ----------

# Sample Pivoted Data
pivot_data = [
    ("IT", 75000, 71000),
    ("HR", 90000, 45000),
    ("QA", 55000, 83000)
]

pivot_columns = ["department", "Male", "Female"]

pivot_df = spark.createDataFrame(pivot_data, pivot_columns)

pivot_df.display()

# 1. Convert pivoted salary table back to rows.
pivot_df.select(
    "department",
    expr("""
        stack(
            2,
            'Male', Male,
            'Female', Female
        ) as (gender, salary)
    """)
).display()

# 2. Unpivot city data.
city_data = [
    ("IT", 2, 1),
    ("HR", 0, 1)
]

city_columns = ["department", "Hyderabad", "Bangalore"]

city_df = spark.createDataFrame(city_data, city_columns)

city_df.select(
    "department",
    expr("""
        stack(
            2,
            'Hyderabad', Hyderabad,
            'Bangalore', Bangalore
        ) as (city, employee_count)
    """)
).display()

# 3. Convert department columns into rows.
pivot_df.select(
    expr("""
        stack(
            2,
            'Male', Male,
            'Female', Female
        ) as (gender, salary)
    """)
).display()

# 4. Practice stack function.
pivot_df.select(
    "department",
    expr("""
        stack(
            2,
            'Male', Male,
            'Female', Female
        ) as (category, amount)
    """)
).display()

# 5. Create normalized dataframe.
pivot_df.select(
    "department",
    expr("""
        stack(
            2,
            'Male', Male,
            'Female', Female
        ) as (gender, salary)
    """)
).display()

# COMMAND ----------

# MAGIC %md
# MAGIC ##Window Functions Questions

# COMMAND ----------

from pyspark.sql.window import Window
from pyspark.sql.functions import *

# 1. Find rank of employees based on salary.
salary_window = Window.orderBy(col("salary").desc())

emp_df.withColumn(
    "rank",
    rank().over(salary_window)
).display()

# 2. Find dense_rank department-wise.
dept_window = Window.partitionBy("department") \
                    .orderBy(col("salary").desc())

emp_df.withColumn(
    "dense_rank",
    dense_rank().over(dept_window)
).display()

# 3. Find row_number for employees.
emp_df.withColumn(
    "row_number",
    row_number().over(salary_window)
).display()

# 4. Find lead salary.
emp_df.withColumn(
    "next_salary",
    lead("salary").over(salary_window)
).display()

# 5. Find lag salary.
emp_df.withColumn(
    "previous_salary",
    lag("salary").over(salary_window)
).display()

# COMMAND ----------

# MAGIC %md
# MAGIC ##Window Functions Questions

# COMMAND ----------

from pyspark.sql.window import Window
from pyspark.sql.functions import *

# 1. Find rank of employees based on salary.
salary_window = Window.orderBy(col("salary").desc())

emp_df.withColumn(
    "rank",
    rank().over(salary_window)
).display()

# 2. Find dense_rank department-wise.
dept_window = Window.partitionBy("department") \
                    .orderBy(col("salary").desc())

emp_df.withColumn(
    "dense_rank",
    dense_rank().over(dept_window)
).display()

# 3. Find row_number for employees.
emp_df.withColumn(
    "row_number",
    row_number().over(salary_window)
).display()

# 4. Find lead salary.
emp_df.withColumn(
    "next_salary",
    lead("salary").over(salary_window)
).display()

# 5. Find lag salary.
emp_df.withColumn(
    "previous_salary",
    lag("salary").over(salary_window)
).display()

# COMMAND ----------

# MAGIC %md
# MAGIC ##repartition()

# COMMAND ----------

from pyspark.sql.functions import spark_partition_id

# 1. Repartition dataframe into 4 partitions.
repartition_df = emp_df.repartition(4)

repartition_df.withColumn(
    "partition_id",
    spark_partition_id()
).display()

# 2. Repartition by department.
dept_repartition_df = emp_df.repartition(3, col("department"))

dept_repartition_df.withColumn(
    "partition_id",
    spark_partition_id()
).display()

# 3. Check partition count.
emp_df.select(
    spark_partition_id()
).distinct().count()

# 4. Compare repartition and coalesce.

# Repartition
repartition_df = emp_df.repartition(4)

repartition_df.withColumn(
    "partition_id",
    spark_partition_id()
).display()

# Coalesce
coalesce_df = emp_df.coalesce(2)

coalesce_df.withColumn(
    "partition_id",
    spark_partition_id()
).display()

# 5. Repartition large datasets.
large_df = emp_df.repartition(5)

large_df.withColumn(
    "partition_id",
    spark_partition_id()
).display()

# COMMAND ----------

# MAGIC %md
# MAGIC ##coalesce()

# COMMAND ----------

# MAGIC %md
# MAGIC

# COMMAND ----------

from pyspark.sql.functions import spark_partition_id

# 1. Reduce partitions to 2.
coalesce_df = emp_df.coalesce(2)

coalesce_df.withColumn(
    "partition_id",
    spark_partition_id()
).display()

# 2. Check performance difference.

# Repartition
repartition_df = emp_df.repartition(4)

# Coalesce
coalesce_df = emp_df.coalesce(2)

print("Repartition Partitions:",
      repartition_df.select(
          spark_partition_id()
      ).distinct().count())

print("Coalesce Partitions:",
      coalesce_df.select(
          spark_partition_id()
      ).distinct().count())

# 3. Use coalesce before writing files.
output_df = emp_df.coalesce(1)

output_df.withColumn(
    "partition_id",
    spark_partition_id()
).display()

# 4. Compare shuffle behavior.

# Repartition causes shuffle
repartition_df = emp_df.repartition(4)

# Coalesce minimizes shuffle
coalesce_df = emp_df.coalesce(2)

repartition_df.withColumn(
    "partition_id",
    spark_partition_id()
).display()

coalesce_df.withColumn(
    "partition_id",
    spark_partition_id()
).display()

# 5. Optimize output files.
optimized_df = emp_df.coalesce(1)

optimized_df.withColumn(
    "partition_id",
    spark_partition_id()
).display()

# COMMAND ----------

# MAGIC %md
# MAGIC ##cache()

# COMMAND ----------

# MAGIC %md
# MAGIC # 1. Cache employee dataframe.
# MAGIC cached_df = emp_df.cache()
# MAGIC
# MAGIC cached_df.display()
# MAGIC
# MAGIC # 2. Perform multiple actions after cache.
# MAGIC cached_df.count()
# MAGIC
# MAGIC cached_df.filter(
# MAGIC     col("salary") > 70000
# MAGIC ).display()
# MAGIC
# MAGIC cached_df.groupBy(
# MAGIC     "department"
# MAGIC ).avg("salary").display()
# MAGIC
# MAGIC # 3. Compare execution time.
# MAGIC
# MAGIC import time
# MAGIC
# MAGIC # Without cache
# MAGIC start = time.time()
# MAGIC
# MAGIC emp_df.groupBy(
# MAGIC     "department"
# MAGIC ).count().display()
# MAGIC
# MAGIC print("Without Cache:",
# MAGIC       time.time() - start)
# MAGIC
# MAGIC # With cache
# MAGIC cached_df = emp_df.cache()
# MAGIC
# MAGIC start = time.time()
# MAGIC
# MAGIC cached_df.groupBy(
# MAGIC     "department"
# MAGIC ).count().display()
# MAGIC
# MAGIC print("With Cache:",
# MAGIC       time.time() - start)
# MAGIC
# MAGIC # 4. Use cache with aggregation.
# MAGIC cached_df.groupBy(
# MAGIC     "gender"
# MAGIC ).sum("salary").display()
# MAGIC
# MAGIC # 5. Unpersist cached dataframe.
# MAGIC cached_df.unpersist()
# MAGIC
# MAGIC print("Cache Cleared")

# COMMAND ----------

# MAGIC %md
# MAGIC ##fillna()

# COMMAND ----------

# Create sample dataframe with null values
null_data = [
    (101, "Sravan", 75000, "Hyderabad", 28),
    (102, "Ravi", None, "Bangalore", 30),
    (103, "Priya", 62000, None, 26),
    (104, "Kiran", None, "Mumbai", None)
]

null_columns = ["emp_id", "name", "salary", "city", "age"]

null_df = spark.createDataFrame(null_data, null_columns)

null_df.display()

# 1. Fill null salaries with 0.
null_df.fillna({
    "salary": 0
}).display()

# 2. Fill null city with Unknown.
null_df.fillna({
    "city": "Unknown"
}).display()

# 3. Fill multiple columns.
null_df.fillna({
    "salary": 0,
    "city": "Unknown",
    "age": 25
}).display()

# 4. Fill null ages with average age.
avg_age = null_df.select(
    avg("age")
).collect()[0][0]

null_df.fillna({
    "age": int(avg_age)
}).display()

# 5. Replace null strings.
null_df.fillna("Not Available").display()

# COMMAND ----------

# MAGIC %md
# MAGIC ##replace()

# COMMAND ----------

# 1. Replace "Hyderabad" with "HYD"
emp_df.withColumn(
    "city_replaced",
    regexp_replace(col("city"), "Hyderabad", "HYD")
).display()

# 2. Replace "IT" with "Information Technology"
emp_df.withColumn(
    "dept_replaced",
    regexp_replace(col("department"), "IT", "Information Technology")
).display()

# 3. Replace "Male" with "M" and "Female" with "F"
emp_df.withColumn(
    "gender_short",
    regexp_replace(
        regexp_replace(col("gender"), "Male", "M"),
        "Female", "F"
    )
).display()

# 4. Replace "QA" with "Testing"
emp_df.withColumn(
    "dept_cleaned",
    regexp_replace(col("department"), "QA", "Testing")
).display()

# 5. Replace multiple values (IT -> Tech, HR -> Human Resources)
emp_df.withColumn(
    "dept_updated",
    regexp_replace(
        regexp_replace(col("department"), "IT", "Tech"),
        "HR", "Human Resources"
    )
).display()

# COMMAND ----------

# MAGIC %md
# MAGIC ##na.drop()

# COMMAND ----------


# 1. Drop rows with null salary.
emp_df.na.drop(subset=["salary"]).display()

# 2. Drop rows with any null value.
emp_df.na.drop(how="any").display()

# 3. Drop rows where all values are null.
emp_df.na.drop(how="all").display()

# 4. Drop rows with less than 8 non-null values (threshold).
emp_df.na.drop(thresh=8).display()

# 5. Drop rows with null city.
emp_df.na.drop(subset=["city"]).display()

# COMMAND ----------

# MAGIC %md
# MAGIC ##na.fill()

# COMMAND ----------

from pyspark.sql import SparkSession

spark = SparkSession.builder.appName("NAFillPractice").getOrCreate()

data = [
    (101, "Sravan", "IT", 75000, 28),
    (102, "Ravi", None, None, 30),
    (103, "Priya", "Analytics", 62000, None),
    (104, "Kiran", None, None, None),
    (105, "Anjali", "HR", 45000, 24)
]

columns = ["emp_id", "name", "department", "salary", "age"]

df = spark.createDataFrame(data, columns)

df.show()

# COMMAND ----------

# 1. Fill null age with 25.
emp_df.na.fill(25, subset=["age"]).display()

# 2. Fill null department with "Unknown".
emp_df.na.fill("Unknown", subset=["department"]).display()

# 3. Fill null salary with 50000.
emp_df.na.fill(50000, subset=["salary"]).display()

# 4. Fill multiple columns together.
emp_df.na.fill({
    "department": "Unknown",
    "salary": 50000,
    "age": 25
}).display()

# 5. Fill all string null values with "N/A".
emp_df.na.fill("N/A").display()

# COMMAND ----------

# MAGIC %md
# MAGIC ##map()

# COMMAND ----------

# MAGIC %md
# MAGIC # Convert DataFrame to RDD
# MAGIC emp_rdd = emp_df.rdd
# MAGIC
# MAGIC # 1. Convert names to uppercase.
# MAGIC emp_rdd.map(lambda x: x["name"].upper()).collect()
# MAGIC
# MAGIC # 2. Increase salary by 10%.
# MAGIC emp_rdd.map(lambda x: (x["name"], x["salary"] * 1.10)).collect()
# MAGIC
# MAGIC # 3. Extract employee names.
# MAGIC emp_rdd.map(lambda x: x["name"]).collect()
# MAGIC
# MAGIC # 4. Convert department names to lowercase.
# MAGIC emp_rdd.map(lambda x: x["department"].lower()).collect()
# MAGIC
# MAGIC # 5. Create employee summary strings.
# MAGIC emp_rdd.map(
# MAGIC     lambda x: f"{x['name']} works in {x['department']} with salary {x['salary']}"
# MAGIC ).collect()

# COMMAND ----------

# MAGIC %md
# MAGIC ##flatMap()
# MAGIC # Sample RDD
# MAGIC emp_rdd = emp_df.rdd
# MAGIC
# MAGIC # 1. Split names into characters.
# MAGIC emp_rdd.flatMap(lambda x: list(x["name"])).collect()
# MAGIC
# MAGIC # 2. Split designation words.
# MAGIC emp_rdd.flatMap(lambda x: x["designation"].split(" ")).collect()
# MAGIC
# MAGIC # 3. Extract all skills.
# MAGIC skills_data = [
# MAGIC     (101, ["Python", "Spark", "Azure"]),
# MAGIC     (102, ["Java", "SQL"]),
# MAGIC     (103, ["Power BI", "SQL"])
# MAGIC ]
# MAGIC
# MAGIC skills_rdd = spark.createDataFrame(
# MAGIC     skills_data,
# MAGIC     ["emp_id", "skills"]
# MAGIC ).rdd
# MAGIC
# MAGIC skills_rdd.flatMap(lambda x: x["skills"]).collect()
# MAGIC
# MAGIC # 4. Flatten nested lists.
# MAGIC nested_rdd = sc.parallelize([[1, 2], [3, 4], [5, 6]])
# MAGIC nested_rdd.flatMap(lambda x: x).collect()
# MAGIC
# MAGIC # 5. Generate words from sentences.
# MAGIC sentence_rdd = sc.parallelize([
# MAGIC     "PySpark is easy",
# MAGIC     "RDD transformations are powerful"
# MAGIC ])
# MAGIC
# MAGIC sentence_rdd.flatMap(lambda x: x.split(" ")).collect()

# COMMAND ----------

# MAGIC %md
# MAGIC ##reduceByKey()
# MAGIC # Convert DataFrame to RDD
# MAGIC emp_rdd = emp_df.rdd
# MAGIC
# MAGIC # 1. Count employees by department.
# MAGIC emp_rdd.map(lambda x: (x["department"], 1)) \
# MAGIC        .reduceByKey(lambda x, y: x + y) \
# MAGIC        .collect()
# MAGIC
# MAGIC # 2. Sum salaries department-wise.
# MAGIC emp_rdd.map(lambda x: (x["department"], x["salary"])) \
# MAGIC        .reduceByKey(lambda x, y: x + y) \
# MAGIC        .collect()
# MAGIC
# MAGIC # 3. Count city-wise employees.
# MAGIC emp_rdd.map(lambda x: (x["city"], 1)) \
# MAGIC        .reduceByKey(lambda x, y: x + y) \
# MAGIC        .collect()
# MAGIC
# MAGIC # 4. Aggregate ages by department.
# MAGIC emp_rdd.map(lambda x: (x["department"], x["age"])) \
# MAGIC        .reduceByKey(lambda x, y: x + y) \
# MAGIC        .collect()
# MAGIC
# MAGIC # 5. Find maximum salary by city.
# MAGIC emp_rdd.map(lambda x: (x["city"], x["salary"])) \
# MAGIC        .reduceByKey(lambda x, y: max(x, y)) \
# MAGIC        .collect()

# COMMAND ----------

# MAGIC %md
# MAGIC ##mapPartitions()
# MAGIC # Convert DataFrame to RDD
# MAGIC emp_rdd = emp_df.rdd
# MAGIC
# MAGIC # 1. Process data partition-wise.
# MAGIC emp_rdd.mapPartitions(
# MAGIC     lambda partition: [row["name"] for row in partition]
# MAGIC ).collect()
# MAGIC
# MAGIC # 2. Count rows per partition.
# MAGIC emp_rdd.mapPartitions(
# MAGIC     lambda partition: [sum(1 for _ in partition)]
# MAGIC ).collect()
# MAGIC
# MAGIC # 3. Convert names to uppercase partition-wise.
# MAGIC emp_rdd.mapPartitions(
# MAGIC     lambda partition: [row["name"].upper() for row in partition]
# MAGIC ).collect()
# MAGIC
# MAGIC # 4. Optimize heavy computations.
# MAGIC emp_rdd.mapPartitions(
# MAGIC     lambda partition: [
# MAGIC         (row["name"], row["salary"] * 1.10)
# MAGIC         for row in partition
# MAGIC     ]
# MAGIC ).collect()
# MAGIC
# MAGIC # 5. Compare map() vs mapPartitions().
# MAGIC emp_rdd.mapPartitions(
# MAGIC     lambda partition: [
# MAGIC         f"{row['name']} - {row['department']}"
# MAGIC         for row in partition
# MAGIC     ]
# MAGIC ).collect()

# COMMAND ----------

# MAGIC %md
# MAGIC ##zipWithIndex()
# MAGIC # Convert DataFrame to RDD
# MAGIC emp_rdd = emp_df.rdd
# MAGIC
# MAGIC # 1. Add index to each employee.
# MAGIC emp_rdd.zipWithIndex().collect()
# MAGIC
# MAGIC # 2. Generate sequence numbers.
# MAGIC emp_rdd.map(lambda x: x["name"]) \
# MAGIC        .zipWithIndex() \
# MAGIC        .collect()
# MAGIC
# MAGIC # 3. Create row IDs.
# MAGIC emp_rdd.zipWithIndex() \
# MAGIC        .map(lambda x: (x[1] + 1, x[0]["name"])) \
# MAGIC        .collect()
# MAGIC
# MAGIC # 4. Compare zipWithIndex() and monotonically_increasing_id().
# MAGIC emp_rdd.zipWithIndex().collect()
# MAGIC
# MAGIC # DataFrame version
# MAGIC from pyspark.sql.functions import monotonically_increasing_id
# MAGIC
# MAGIC emp_df.withColumn(
# MAGIC     "row_id",
# MAGIC     monotonically_increasing_id()
# MAGIC ).display()
# MAGIC
# MAGIC # 5. Generate indexed employee list.
# MAGIC emp_rdd.map(
# MAGIC     lambda x: (x["emp_id"], x["name"])
# MAGIC ).zipWithIndex().collect()

# COMMAND ----------

# MAGIC %md
# MAGIC ##crossJoin()

# COMMAND ----------

department_data = [
    ("IT", "John"),
    ("HR", "Smith"),
    ("QA", "David"),
    ("Analytics", "Kevin"),
    ("Support", "Robert")
]

dept_columns = ["department", "manager"]

dept_df = spark.createDataFrame(department_data, dept_columns)

# COMMAND ----------

# 1. Cross join employees with departments.
emp_df.crossJoin(dept_df).display()

# 2. Generate all employee-department combinations.
emp_df.select("name").crossJoin(
    dept_df.select("department")
).display()

# 3. Find total combinations count.
emp_df.crossJoin(dept_df).count()

# 4. Cross join city and department data.
emp_df.select("city").distinct() \
      .crossJoin(
          dept_df.select("department")
      ).display()

# 5. Understand Cartesian product.
emp_df.limit(3).crossJoin(
    dept_df.limit(2)
).display()

# COMMAND ----------

# MAGIC %md
# MAGIC ##except()

# COMMAND ----------

new_emp_data = [
    (101, "Sravan", "Data Engineer", "IT", 75000, "Hyderabad", 28, "2021-05-10", "Male"),
    (102, "Ravi", "Software Engineer", "IT", 68000, "Bangalore", 30, "2020-03-15", "Male")
]
columns = [
    "emp_id",
    "name",
    "designation",
    "department",
    "salary",
    "city",
    "age",
    "joining_date",
    "gender"
]
new_emp_df = spark.createDataFrame(new_emp_data, columns)

# COMMAND ----------

# 1. Find employees not in new_emp_df.
emp_df.exceptAll(new_emp_df).display()

# 2. Compare two DataFrames.
new_emp_df.exceptAll(emp_df).display()

# 3. Remove matching rows.
emp_df.exceptAll(new_emp_df).display()

# 4. Find difference between datasets.
emp_df.select("emp_id", "name") \
      .exceptAll(
          new_emp_df.select("emp_id", "name")
      ).display()

# 5. Validate missing employees.
emp_df.exceptAll(new_emp_df).count()

# COMMAND ----------

# MAGIC %md
# MAGIC ##intersect()

# COMMAND ----------

# 1. Find common employees.
emp_df.intersect(new_emp_df).display()

# 2. Compare datasets.
new_emp_df.intersect(emp_df).display()

# 3. Find common departments.
emp_df.select("department") \
      .intersect(
          new_emp_df.select("department")
      ).display()

# 4. Find common cities.
emp_df.select("city") \
      .intersect(
          new_emp_df.select("city")
      ).display()

# 5. Validate matching records.
emp_df.intersect(new_emp_df).count()

# COMMAND ----------

# MAGIC %md
# MAGIC ##cube()

# COMMAND ----------

from pyspark.sql.functions import sum, avg, count, max

# 1. Perform cube on department and city.
emp_df.cube("department", "city") \
      .agg(sum("salary").alias("total_salary")) \
      .display()

# 2. Find multi-dimensional aggregates.
emp_df.cube("department", "city") \
      .agg(
          avg("salary").alias("avg_salary"),
          count("*").alias("emp_count")
      ) \
      .display()

# 3. Analyze salary combinations.
emp_df.cube("department", "city") \
      .sum("salary") \
      .display()

# 4. Find total salary cube.
emp_df.cube("department", "city") \
      .agg(sum("salary").alias("total_salary")) \
      .display()

# 5. Compare rollup and cube.
emp_df.cube("department", "city") \
      .agg(sum("salary").alias("cube_salary")) \
      .display()

# COMMAND ----------

# MAGIC %md
# MAGIC ##rollup()

# COMMAND ----------

from pyspark.sql.functions import sum, avg, count

# 1. Rollup department and city.
emp_df.rollup("department", "city") \
      .agg(sum("salary").alias("total_salary")) \
      .display()

# 2. Create hierarchical summaries.
emp_df.rollup("department", "city") \
      .agg(
          avg("salary").alias("avg_salary"),
          count("*").alias("emp_count")
      ) \
      .display()

# 3. Find total salaries.
emp_df.rollup("department", "city") \
      .sum("salary") \
      .display()

# 4. Analyze rollup output.
emp_df.rollup("department", "city") \
      .agg(sum("salary").alias("salary_total")) \
      .display()

# 5. Compare cube and rollup.
emp_df.rollup("department", "city") \
      .agg(sum("salary").alias("rollup_salary")) \
      .display()

# COMMAND ----------

# MAGIC %md
# MAGIC ##broadcast()

# COMMAND ----------

from pyspark.sql.functions import broadcast

# 1. Broadcast join small department table.
emp_df.join(
    broadcast(dept_df),
    "department",
    "inner"
).display()

# 2. Compare join performance.
emp_df.join(
    dept_df,
    "department",
    "inner"
).display()

# 3. Optimize joins.
emp_df.join(
    broadcast(dept_df),
    "department",
    "left"
).display()

# 4. Use broadcast with lookup table.
emp_df.join(
    broadcast(dept_df.select("department", "manager")),
    "department"
).display()

# 5. Analyze execution plan.
emp_df.join(
    broadcast(dept_df),
    "department"
).explain(True)

# COMMAND ----------

# MAGIC %md
# MAGIC ##explode_outer()

# COMMAND ----------

from pyspark.sql.functions import explode, explode_outer

skills_data = [
    (101, ["Python", "Spark", "Azure"]),
    (102, ["Java", "SQL"]),
    (103, None),
    (104, []),
    (105, ["Power BI"])
]

skills_columns = ["emp_id", "skills"]

skills_df = spark.createDataFrame(skills_data, skills_columns)

skills_df.display()

# COMMAND ----------

from pyspark.sql.functions import explode_outer

# 1. Explode arrays with null values.
skills_df.select(
    "emp_id",
    explode_outer("skills").alias("skill")
).display()

# 2. Compare explode and explode_outer.
skills_df.select(
    "emp_id",
    explode("skills").alias("skill")
).display()

# 3. Handle empty arrays.
skills_df.select(
    "emp_id",
    explode_outer("skills").alias("skill")
).display()

# 4. Preserve null rows.
skills_df.select(
    "emp_id",
    explode_outer("skills").alias("skill")
).display()

# 5. Analyze output differences.
skills_df.select(
    "emp_id",
    explode_outer("skills").alias("skill")
).display()

# COMMAND ----------

# MAGIC %md
# MAGIC ##arrayContains()

# COMMAND ----------

from pyspark.sql.functions import array_contains

# 1. Find employees with Spark skill.
skills_df.filter(
    array_contains("skills", "Spark")
).display()

# 2. Filter Python developers.
skills_df.filter(
    array_contains("skills", "Python")
).display()

# 3. Search arrays.
skills_df.filter(
    array_contains("skills", "Java")
).display()

# 4. Find employees with SQL skill.
skills_df.filter(
    array_contains("skills", "SQL")
).display()

# 5. Check Azure skill availability.
skills_df.filter(
    array_contains("skills", "Azure")
).display()

# COMMAND ----------

