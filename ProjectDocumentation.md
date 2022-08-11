**Joe Dillon Estrada**

006564986

D191 Performance Assessment

- [A. Summarize one real-world business report that can be created from the attached Data Sets and Associated Dictionaries.](#a-summarize-one-real-world-business-report-that-can-be-created-from-the-attached-data-sets-and-associated-dictionaries)
  - [1. Describe the data used for the report.](#1-describe-the-data-used-for-the-report)
  - [2. Identify two or more specific tables from the given dataset that will provide the data necessary for the detailed and the summary sections of the report.](#2-identify-two-or-more-specific-tables-from-the-given-dataset-that-will-provide-the-data-necessary-for-the-detailed-and-the-summary-sections-of-the-report)
  - [3. Identify the specific fields that will be included in the detailed and the summary sections of the report.](#3-identify-the-specific-fields-that-will-be-included-in-the-detailed-and-the-summary-sections-of-the-report)
  - [4. Identify one field in the detailed section that will require a custom transformation and explain why it should be transformed. For example, you might translate a field with a value of ‘N’ to ‘No’ and ‘Y’ to ‘Yes’.](#4-identify-one-field-in-the-detailed-section-that-will-require-a-custom-transformation-and-explain-why-it-should-be-transformed-for-example-you-might-translate-a-field-with-a-value-of-n-to-no-and-y-to-yes)
  - [5. Explain the different business uses of the detailed and the summary sections of the report.](#5-explain-the-different-business-uses-of-the-detailed-and-the-summary-sections-of-the-report)
  - [6. Explain how frequently your report should be refreshed to remain relevant to stakeholders.](#6-explain-how-frequently-your-report-should-be-refreshed-to-remain-relevant-to-stakeholders)
- [B. Write a SQL code that creates the tables to hold your report sections.](#b-write-a-sql-code-that-creates-the-tables-to-hold-your-report-sections)
- [C. Write a SQL query that will extract the raw data needed for the Detailed section of your report from the source database and verify the data’s accuracy.](#c-write-a-sql-query-that-will-extract-the-raw-data-needed-for-the-detailed-section-of-your-report-from-the-source-database-and-verify-the-datas-accuracy)
- [D. Write code for function(s) that perform the transformation(s) you identified in part A4.](#d-write-code-for-functions-that-perform-the-transformations-you-identified-in-part-a4)
- [E. Write a SQL code that creates a trigger on the detailed table of the report that will continually update the summary table as data is added to the detailed table.](#e-write-a-sql-code-that-creates-a-trigger-on-the-detailed-table-of-the-report-that-will-continually-update-the-summary-table-as-data-is-added-to-the-detailed-table)
- [F. Create a stored procedure that can be used to refresh the data in both your detailed and summary tables. The procedure should clear the contents of the detailed and summary tables and perform the ETL load process from part C and include comments that identify how often the stored procedure should be executed.](#f-create-a-stored-procedure-that-can-be-used-to-refresh-the-data-in-both-your-detailed-and-summary-tables-the-procedure-should-clear-the-contents-of-the-detailed-and-summary-tables-and-perform-the-etl-load-process-from-part-c-and-include-comments-that-identify-how-often-the-stored-procedure-should-be-executed)
  - [1. Explain how the stored procedure can be run on a schedule to ensure data freshness.](#1-explain-how-the-stored-procedure-can-be-run-on-a-schedule-to-ensure-data-freshness)
- [G. Provide a Panopto video recording that includes a demonstration of the functionality of the code used for the analysis and a summary of the programming environment.](#g-provide-a-panopto-video-recording-that-includes-a-demonstration-of-the-functionality-of-the-code-used-for-the-analysis-and-a-summary-of-the-programming-environment)
- [H. Record the web sources you used to acquire data or segments of third-party code to support the application if applicable. Be sure the web sources are reliable.](#h-record-the-web-sources-you-used-to-acquire-data-or-segments-of-third-party-code-to-support-the-application-if-applicable-be-sure-the-web-sources-are-reliable)
- [I. Acknowledge sources, using in-text citations and references, for content that is quoted, paraphrased, or summarized.](#i-acknowledge-sources-using-in-text-citations-and-references-for-content-that-is-quoted-paraphrased-or-summarized)


# A. Summarize one real-world business report that can be created from the attached Data Sets and Associated Dictionaries. 

One real world business report that can be created from the attached Data Sets and Associated Dictionaries is to keep track of customer's who spend the most money at the store and when their last visit was. This will allow management to develop strategies for creating promotions that will influence top customers to return for more rentals.

## 1. Describe the data used for the report.
The data used for this report is the customer information and payment information. Customer information includes **name** and **email**. Payment information includes **payment date** and **payment amount**. This data, combined, can tell management which customers are spending the most money and the time since their last payment. 

## 2. Identify two or more specific tables from the given dataset that will provide the data necessary for the detailed and the summary sections of the report.
The two tables that will provide the data necessary for both the detailed and summary sections of the report or the **customer** table and the **payment** table.

## 3. Identify the specific fields that will be included in the detailed and the summary sections of the report. 
**Detailed**
- customer.customer_id
- customer.first_name
- customer.last_name
- customer.email
- payment.payment_id
- payment.payment_date
- payment.amount

## 4. Identify one field in the detailed section that will require a custom transformation and explain why it should be transformed. For example, you might translate a field with a value of ‘N’ to ‘No’ and ‘Y’ to ‘Yes’.
The values in the **payment.amount** field will be translated by summing all of the payments for a respective **customer_id**. This will allow for better analysis of top spending customers without having to manually add together many payments.

## 5. Explain the different business uses of the detailed and the summary sections of the report.
The detailed section can be used by stakeholders to see the individual payments for each customer and gleam insights such as frequency of payments, largest single payment, etc. From this, the stakeholders can look into implementing benefits for customers who rent more frequently or who spend more in a single transaction.

The summary section can be used by stakeholders to see top spending customers overall and when their last visit was. From this, the stakeholders can look into implementing benefits for the top customers to try to keep them returning as frequently as possible.

## 6. Explain how frequently your report should be refreshed to remain relevant to stakeholders.
This report should be refreshed at least once a month, so that monthly promotions can be established or updated based on the new data created throughout the previous month.

---
# B. Write a SQL code that creates the tables to hold your report sections. 
``` sql
DROP TABLE IF EXISTS detailed;
CREATE TABLE detailed (
	customer_id integer,
	first_name varchar(45),
	last_name varchar(45),
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
```
---
# C. Write a SQL query that will extract the raw data needed for the Detailed section of your report from the source database and verify the data’s accuracy.
``` sql
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
```
---
# D. Write code for function(s) that perform the transformation(s) you identified in part A4.
``` sql
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
```
---
# E. Write a SQL code that creates a trigger on the detailed table of the report that will continually update the summary table as data is added to the detailed table.
``` sql
CREATE OR REPLACE TRIGGER summaryRefreshTrig
AFTER INSERT ON detailed
FOR EACH STATEMENT
EXECUTE PROCEDURE summaryRefreshFun();
```

---
# F. Create a stored procedure that can be used to refresh the data in both your detailed and summary tables. The procedure should clear the contents of the detailed and summary tables and perform the ETL load process from part C and include comments that identify how often the stored procedure should be executed.
``` sql
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
```

## 1. Explain how the stored procedure can be run on a schedule to ensure data freshness.

Provided that the database is on a linux host a cron job can be set up to run at regularly scheduled intervals by editing the crontab file with a new entry:

``` bash
0 5 1 * * psql -c "CALL refreshTables();";
```

The above cron command will run and update the tables at the beginning of each month at 5 AM.

---
# G. Provide a Panopto video recording that includes a demonstration of the functionality of the code used for the analysis and a summary of the programming environment. 

---
# H. Record the web sources you used to acquire data or segments of third-party code to support the application if applicable. Be sure the web sources are reliable.

---
# I. Acknowledge sources, using in-text citations and references, for content that is quoted, paraphrased, or summarized.
No sources are quoted, paraphrased, or summarized.


