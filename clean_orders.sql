-- czyszczenie danych zamówień 
-- źródło tabela customers_orders

SELECT order_id,
-- czysczenie nazw klientów
	CASE 
		WHEN customer_name IS NULL OR LENGTH(TRIM(customer_name)) = 0 THEN 'brak'
		ELSE INITCAP(REGEXP_REPLACE(LOWER(TRIM(customer_name)), '^(?:pan|pani)\s+', '')) END AS clean_customer_name,
-- ujednolicenie daty zamówień (do formatu YYYY-MM-DD)
	CASE 
		WHEN order_date ~ '^\d{2}/\d{2}/\d{4}$' THEN TO_CHAR(TO_DATE(order_date, 'DD/MM/YYYY'), 'YYYY-MM-DD')
		WHEN order_date ~ '^\d{4}/\d{2}/\d{2}$' THEN TO_CHAR(TO_DATE(order_date, 'YYYY/MM/DD'), 'YYYY-MM-DD')
		WHEN order_date ~ '^\d{4}.\d{2}.\d{2}$' THEN TO_CHAR(TO_DATE(order_date, 'YYYY.MM.DD'), 'YYYY-MM-DD')
		WHEN order_date ~ '^\d{4}/\d{2}/\d{2}$' THEN TO_CHAR(TO_DATE(order_date, 'YYYY/MM/DD'), 'YYYY-MM-DD')
		WHEN order_date ~ '^\d{2}-\d{2}-\d{4}$' THEN TO_CHAR(TO_DATE(order_date, 'DD-MM-YYYY'), 'YYYY-MM-DD')
		WHEN LENGTH(TRIM(order_date)) >= 11 THEN 'YYYY-MM-DD' 
		WHEN LENGTH(TRIM(order_date)) = 0 THEN 'YYYY-MM-DD' ELSE order_date END AS order_date,
--czyszczenie kolumny 'quantity' i zmiana słownych rekordów w liczbowe
	CASE
		WHEN quantity = '-1' THEN '0'
		WHEN LENGTH(TRIM(quantity)) = '0' THEN '0'
		WHEN LOWER(TRIM(quantity)) = 'three' THEN '3'
		WHEN LOWER(TRIM(quantity)) = 'two' THEN '2'
		ELSE quantity END AS quantity,
-- zmiana nazw produktów na małe litery 
	LOWER(product) AS product,
-- standaryzacja statusów w kolumnie i wypełnienie pustych pozycji
	CASE 
		WHEN LENGTH(TRIM(status)) = 0 THEN 'brak' 
		WHEN LOWER(TRIM(status)) = 'del.' THEN 'delivered'
		ELSE LOWER(TRIM(status)) END AS status,
--czyszczenie cen
	CASE 
		WHEN price IN ('zero', 'NaN') OR LENGTH(TRIM(price)) = 0 THEN '0'
		WHEN price IN ('fifteen') THEN '15,00'
		ELSE TRIM(price) END AS price
FROM customers_orders;

