SELECT * FROM pizza_sales;

-- TOTAL REVENUE
SELECT
	SUM(total_price) as Total_Revenue
FROM
	pizza_sales;

-- AVERAGE ORDER VALUE
SELECT
	SUM(total_price)/COUNT(DISTINCT order_id) as Average_order_value
FROM
	pizza_sales;

-- TOTAL PIZZA'S SOLD
SELECT
	SUM(quantity) as Total_pizzas_sold
FROM
	pizza_sales;

-- TOTAL ORDERS
SELECT
	COUNT(DISTINCT order_id) as Total_orders
FROM
	pizza_sales;

--AVERAGE PIZZA'S PER ORDER
SELECT
	CAST(CAST(SUM(quantity) AS DECIMAL(10,2))/CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2)) as Average_pizzas_per_order
FROM
	pizza_sales;

-- HOURLY TREND FOR TOTAL PIZZA'S SOLD
SELECT
	DATEPART(HOUR, order_time) as Hour_trend,
		SUM(quantity) as Total_pizzas_sold
FROM
	pizza_sales
GROUP BY
	DATEPART(HOUR, order_time)
ORDER BY
	DATEPART(HOUR, order_time);

-- WEEKLY TREND FOR ORDERS
SELECT 
	DATEPART(ISO_WEEK, order_date) as Week_trend,
	YEAR(order_date) AS Year,
	COUNT(DISTINCT order_id) as Total_orders
FROM
	pizza_sales
GROUP BY
	DATEPART(ISO_WEEK, order_date),
	YEAR(order_date)
ORDER BY	
	Week_trend,Year;

-- PERCENTAGE OF SALES BY PIZZA CATEGORY
SELECT
	pizza_category,
	CAST(SUM(total_price) AS DECIMAL(10,2)) as Total_Revenue,
	CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL (10,2)) as Percentage
FROM
	pizza_sales
GROUP BY
	pizza_category
ORDER BY
	Total_Revenue DESC;

-- TOP 5 PIZZA'S BY REVENUE
SELECT
	TOP 5 pizza_name,
	SUM(total_price) as Top_Revenue
FROM
	pizza_sales
GROUP BY
	pizza_name
ORDER BY
	Top_Revenue DESC;

-- BOTTOM 5 PIZZA'S BY REVENUE
SELECT
	TOP 5 pizza_name,
	SUM(total_price) as Bottom_Revenue
FROM
	pizza_sales
GROUP BY
	pizza_name
ORDER BY
	Bottom_Revenue;

-- TOP 5 PIZZA'S BY QUANTITY
SELECT
	TOP 5 pizza_name,
	SUM(quantity) as Top_quantity
FROM
	pizza_sales
GROUP BY
	pizza_name
ORDER BY
	Top_quantity DESC;

-- BOTTOM 5 PIZZA'S BY QUANTITY
SELECT
	TOP 5 pizza_name,
	SUM(quantity) as Bottom_quantity
FROM
	pizza_sales
GROUP BY
	pizza_name
ORDER BY
	Bottom_quantity;

-- TOP 5 PIZZA'S BY ORDERS
SELECT
	TOP 5 pizza_name,
	COUNT(DISTINCT order_id) as Top_orders
FROM
	pizza_sales
GROUP BY
	pizza_name
ORDER BY
	Top_orders DESC;

-- BOTTOM 5 PIZZA'S BY ORDERS
SELECT
	TOP 5 pizza_name,
	COUNT(DISTINCT order_id) as Bottom_orders
FROM
	pizza_sales
GROUP BY
	pizza_name
ORDER BY
	Bottom_orders;

-- JUST AN EXAMPLE QUERY TO USE 'WHERE' CLAUSE
SELECT Top 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
WHERE pizza_category = 'Classic'
GROUP BY pizza_name
ORDER BY Total_Orders DESC;