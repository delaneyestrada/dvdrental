DROP TABLE IF EXISTS detailed;
CREATE TABLE detailed (
	customer_id integer,
	first_name varchar (45),
	last_name varchar (45),
	email varchar(90),
	payment_id integer,
	payment_date timestamp,
	amount numeric(5,2)
);

DROP TABLE IF EXISTS summary;
CREATE TABLE summary (
	customer_name varchar (100),
	email varchar(90),
	last_payment_date date,
	total_payments numeric(5,2)
);

TRUNCATE TABLE detailed;

INSERT INTO detailed(
	customer_id,
	first_name, 
	last_name,
	email,
	payment_id,
	payment_date,
	amount
)
SELECT 
	c.customer_id, c.first_name, c.last_name, c.email,
	p.payment_id, p.payment_date, p.amount
FROM payment AS p 
INNER JOIN customer AS c ON c.customer_id = p.customer_id;

SELECT * FROM detailed;

CREATE OR REPLACE FUNCTION summaryRefreshFun()
RETURNS TRIGGER
LANGUAGE plpgsql    
AS $$
BEGIN
	TRUNCATE TABLE summary;
	
    INSERT INTO summary (
		SELECT
		concat_ws (', ', last_name, first_name) AS customer_name,
		email,
		MAX(DATE(payment_date)) AS last_payment_date,
		SUM(amount) AS total_payments
		FROM detailed
		GROUP BY customer_id, customer_name, email
		ORDER BY total_payments DESC, last_payment_date DESC
	);
	
	RETURN NEW;
END;$$;

CREATE OR REPLACE TRIGGER summaryRefreshTrig
AFTER INSERT ON detailed
FOR EACH STATEMENT
EXECUTE PROCEDURE summaryRefreshFun();

CREATE OR REPLACE PROCEDURE refreshTables()
LANGUAGE plpgsql
AS $$ 
BEGIN
	TRUNCATE TABLE detailed;

	INSERT INTO detailed(
		customer_id,
		first_name, 
		last_name,
		email,
		payment_id,
		payment_date,
		amount
	)
	SELECT 
		c.customer_id, c.first_name, c.last_name, c.email,
		p.payment_id, p.payment_date, p.amount
	FROM payment AS p 
	INNER JOIN customer AS c ON c.customer_id = p.customer_id;
END;$$;

CALL refreshTables();

SELECT * FROM detailed;

SELECT * FROM summary;