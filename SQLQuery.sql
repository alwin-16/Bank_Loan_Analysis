SELECT TOP(5)* FROM bank_loan_data

--------------------------------------- KPI 1 ---------------------------------------------
-- TOTAL LOAN APPLICATIONS
SELECT
	COUNT(id) AS Total_Loan_Applications
FROM
	bank_loan_data

-- MONTH TO DATE Total Loan Applications

SELECT
	COUNT(id) AS MTD_Total_Loan_Applications
FROM bank_loan_data
WHERE
	MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

-- MONTH TO MONTH Loan Applications

SELECT
	COUNT(id) AS PMTD_Total_Loan_Applications
FROM bank_loan_data
WHERE
	MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

--- Alterative MOM Analysis

SELECT
	MONTH(issue_date) AS Month,
	COUNT(id) AS Total_Loan_Applications,
	LAG(COUNT(id),1) OVER (ORDER BY MONTH(issue_date)) AS MoM_Total_Loan
FROM bank_loan_data 
GROUP BY MONTH(issue_date)

--------------------------------------- KPI 2 ---------------------------------------------
-- TOTAL FUNDED AMOUNT

SELECT
	SUM(loan_amount) AS Total_Funded_Amount
FROM bank_loan_data

-- MONTH TO DATE Total Loan Applications

SELECT
	SUM(loan_amount) AS MTD_Total_Funded_Amount
FROM bank_loan_data
WHERE 
	MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

-- MONTH TO MONTH Total Loan Applications

SELECT
	SUM(loan_amount) AS PMTD_Total_Funded_Amount
FROM bank_loan_data
WHERE 
	MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

--------------------------------------- KPI 3 ---------------------------------------------
-- TOTAL AMOUNT RECIEVED

SELECT
	SUM(total_payment) AS Total_Amount_Recieved
FROM bank_loan_data

-- MONTH TO DATE Total Loan Applications

SELECT
	SUM(total_payment) AS MTD_Total_Amount_Recieved
FROM bank_loan_data
WHERE 
	MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

-- MONTH TO MONTH Total Loan Applications

SELECT
	SUM(total_payment) AS PMTD_Total_Amount_Recieved
FROM bank_loan_data
WHERE 
	MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

--------------------------------------- KPI 4 ---------------------------------------------
-- AVERAGE INTEREST RATE

SELECT
	ROUND(AVG(int_rate)*100,2) AS Average_Interest_Rate
FROM bank_loan_data

-- AVERAGE MONTH TO DATE INTEREST RATE

SELECT
	ROUND(AVG(int_rate)*100,2) AS MTD_Average_Interest_Rate
FROM bank_loan_data
WHERE
	MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

-- AVERAGE MONTH TO DATE INTEREST RATE

SELECT
	ROUND(AVG(int_rate)*100,2) AS PMTD_Average_Interest_Rate
FROM bank_loan_data
WHERE
	MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

--------------------------------------- KPI 5 ---------------------------------------------
-- AVERAGE DEBT TO INCOME RATIO

SELECT
	ROUND(AVG(dti)*100,2) AS Average_DTI_ratio
FROM bank_loan_data

-- AVERAGE MONTH TO DATE DEBT TO INCOME RATIO

SELECT
	ROUND(AVG(dti)*100,2) AS MTD_Average_DTI_ratio
FROM bank_loan_data
WHERE
	MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

-- AVERAGE MONTH TO MONTH DEBT TO INCOME RATIO

SELECT
	ROUND(AVG(dti)*100,2) AS PMTD_Average_DTI_ratio
FROM bank_loan_data
WHERE
	MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

------------------------------------

SELECT
	loan_status,
	COUNT(loan_status) AS Total
FROM bank_loan_data
GROUP BY
	loan_status

----------------- GOOD LOAN --------------
-- Good loan application percentage

SELECT
	(COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END)*100.0)/ 
	COUNT(id) AS Good_loan_percent
FROM bank_loan_data

-- Good loan application

SELECT
	COUNT(id) AS Good_loan_Applications
FROM bank_loan_data
WHERE
	loan_status = 'Fully Paid' OR loan_status = 'Current'

-- Good loan Funded Amount

SELECT
	SUM(loan_amount) AS Good_loan_Funded_amount
FROM bank_loan_data
WHERE
	loan_status = 'Fully Paid' OR loan_status = 'Current'

-- Good loan Total Received Amount

SELECT
	SUM(total_payment) AS Good_loan_Received_amount
FROM bank_loan_data
WHERE
	loan_status = 'Fully Paid' OR loan_status = 'Current'


----------------- BAD LOAN --------------
-- Bad Loan Application Percentage

SELECT
	(COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END)*100.0)/ 
	COUNT(id) AS Bad_loan_percent
FROM bank_loan_data

-- Bad loan application

	SELECT
		COUNT(id) AS Bad_loan_Applications
	FROM bank_loan_data
	WHERE
		loan_status = 'Charged Off'

-- Bad loan Funded Amount

SELECT
	SUM(loan_amount) AS Bad_loan_Funded_amount
FROM bank_loan_data
WHERE
	loan_status = 'Charged Off'

-- Bad loan Total Received Amount

SELECT
	SUM(total_payment) AS Bad_loan_Received_amount
FROM bank_loan_data
WHERE
	loan_status = 'Charged Off'

--------------- OVERVIEW ------------------
---- LOAN STATUS GRID 

SELECT
	loan_status,
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Received_Amount,
	AVG(int_rate)*100 AS Avg_Int,
	AVG(dti)*100 AS Avg_DTI
FROM bank_loan_data
GROUP BY
	loan_status

-- Month To Date Loan Status Grid

SELECT
	loan_status,
	SUM(loan_amount) AS MTD_Total_Funded_Amount,
	SUM(total_payment) AS MTD_Total_Received_Amount
FROM bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021
GROUP BY
	loan_status

----- Monthly Trends By Issue Date

SELECT
	MONTH(issue_date) AS Month_Number,
	DATENAME(MONTH, issue_date) AS Month_Name,
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
GROUP BY
	MONTH(issue_date), DATENAME(MONTH, issue_date)
ORDER BY
	MONTH(issue_date), DATENAME(MONTH, issue_date)

---- Regional Analysis By State

SELECT
	address_state,
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
GROUP BY
	address_state
ORDER BY
	address_state

---- Loan Term Analysis

SELECT
	term,
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
GROUP BY
	term

---- Employee Length Analysis

SELECT
	emp_length,
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
GROUP BY
	emp_length
ORDER BY COUNT(id) DESC

---- Loan Purpose Analysis

SELECT
	purpose,
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
GROUP BY
	purpose
ORDER BY COUNT(id) DESC

---- Home Ownership Analysis

SELECT
	home_ownership,
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
GROUP BY
	home_ownership
ORDER BY COUNT(id) DESC