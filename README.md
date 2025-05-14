🚗 SQL Data Cleaning & Analysis: Car Orders
This was my first self-initiated SQL project, completed without the help of any online courses or tutorials.

I created and cleaned a dataset to simulate a car sales scenario. Although the dataset is fictional and not based on real-world data, the goal was to demonstrate my ability to clean, transform, and analyze data using SQL.

📁 Project Structure
car_orders – raw data with product names, quantities, prices, and customer IDs

customers – raw customer information including names, country, and gender

car_orders_cleaned – cleaned version of car_orders

customers_cleaned – cleaned version of customers

🔧 Key Cleaning Steps
Removed extra characters from text fields (REPLACE, TRIM)

Standardized formatting (e.g., uppercased last names)

Dropped unnecessary columns (like customer_address)

Removed rows with missing country values

Replaced empty gender values with "no data"

💡 Skills Demonstrated
Creating and duplicating SQL tables

Data cleaning using string and null-handling functions

Joining tables

Aggregating data using SUM, GROUP BY

Using window functions for rolling totals
