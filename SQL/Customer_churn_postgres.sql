CREATE TABLE customer_churn (
    customerID VARCHAR(50),
    gender VARCHAR(20),
    SeniorCitizen INT,
    Partner VARCHAR(10),
    Dependents VARCHAR(10),
    tenure INT,
    PhoneService VARCHAR(10),
    MultipleLines VARCHAR(30),
    InternetService VARCHAR(30),
    OnlineSecurity VARCHAR(30),
    OnlineBackup VARCHAR(30),
    DeviceProtection VARCHAR(30),
    TechSupport VARCHAR(30),
    StreamingTV VARCHAR(30),
    StreamingMovies VARCHAR(30),
    Contract VARCHAR(30),
    PaperlessBilling VARCHAR(10),
    PaymentMethod VARCHAR(100),
    MonthlyCharges NUMERIC(10,2),
    TotalCharges NUMERIC(10,2),
    Churn VARCHAR(10)
);

SELECT * 
FROM customer_churn
LIMIT 5;

--Type of Dataset
SELECT
	column_name,
	data_type
FROM information_schema.columns
WHERE table_name='customer_churn';

--Total CUstomers
SELECT 
	COUNT(*) 
FROM customer_churn

--Duplicates
SELECT 
	customerID,
	COUNT(*)
FROM customer_churn
GROUP BY customerID
HAVING COUNT(*)>1;

--Missing
SELECT
	COUNT(*) 
	FILTER(
		WHERE TotalCharges IS NULL
	) AS missing_totalCharges
FROM customer_churn;

--Churn
SELECT
	Churn,
	COUNT(*) AS customers
FROM customer_churn
GROUP BY Churn;

--Churn Rate
SELECT
	ROUND(
		100.0 *
		SUM(
			CASE
				WHEN Churn = 'Yes'
				THEN 1
				ELSE 0
			END
			)
			/
			COUNT(*),2
		) AS churn_rate
FROM customer_churn;

-- Churn by Contract
SELECT
	Contract,
	COUNT(*) AS customers,
	SUM(
		CASE
			WHEN 
				Churn = 'Yes'
			THEN 1
			ELSE 0
		END
	) AS churned,

	ROUND(
	100.0 *
	SUM(
	CASE
	WHEN Churn = 'Yes' THEN 1 ELSE 0
	END
	)
	/
	COUNT(*),2
	) AS churn_rate
	
FROM customer_churn
GROUP BY contract
ORDER BY churn_rate DESC;

--Churn by Tech Support
SELECT
	TechSupport,
	COUNT(*) AS customers,
	SUM(
		CASE
			WHEN
				Churn = 'Yes'
			THEN 1
			ELSE 0
		END
	) AS churned,

	ROUND(
	100.0 *
	SUM(
	CASE
	WHEN Churn = 'Yes' THEN 1 ELSE 0
	END
	)
	/
	COUNT(*),2
	) AS churn_rate
	
FROM customer_churn
GROUP BY TechSupport
ORDER BY churn_rate DESC;

--Churn by Gender
SELECT
	gender,
	COUNT(*) AS customers,
	SUM(
		CASE
			WHEN
				Churn = 'Yes'
			THEN 1
			ELSE 0
		END
	) AS churned,

	ROUND(
		100.0 *
		SUM(
			CASE
				WHEN
					Churn ='Yes'
				THEN 1
				ELSE 0
			END
		)
		/
		COUNT(*),2
	) AS churn_rate
FROM customer_churn
GROUP BY gender
ORDER BY churn_rate DESC;

--Churn by Senior Citizen
SELECT
	SeniorCitizen,
	COUNT(*) AS customers,
	SUM(
	CASE
	WHEN Churn ='Yes' THEN 1 ELSE 0
	END
	) AS churned,

	ROUND(
	100.0 *
	SUM(
	CASE 
	WHEN Churn = 'Yes' THEN 1 ELSE 0
	END
	)
	/
	COUNT(*),2
	) AS churn_rate
FROM customer_churn
GROUP BY SeniorCitizen
ORDER BY churn_rate DESC;

--Churn by Dependents
SELECT
	Dependents,
	COUNT(*) AS customers,
	SUM(
	CASE
	WHEN Churn = 'Yes' THEN 1 ELSE 0
	END
	) AS churned,

	ROUND(
	100.0 *
	SUM(
	CASE
	WHEN Churn = 'Yes' THEN 1 ELSE 0
	END
	)
	/
	COUNT(*),2
	) AS churn_rate
FROM customer_churn
GROUP BY Dependents
ORDER BY churn_rate DESC;

-- Churn by Internet Service
SELECT
	InternetService,
	COUNT(*) AS customers,
	SUM(
		CASE
		WHEN Churn = 'Yes' THEN 1 ELSE 0
		END
	) AS churned
FROM customer_churn
GROUP BY InternetService;

--Churn by Online Security
SELECT
	OnlineSecurity,
	COUNT(*) AS customers,
	SUM(
		CASE
		WHEN Churn = 'Yes' THEN 1 ELSE 0
		END
	) AS churned
FROM customer_churn
GROUP BY OnlineSecurity;


--Average Monthly Charge by Churn
SELECT 
Churn,
ROUND( AVG(MonthlyCharges),2
	)AS avg_monthly_charges
FROM customer_churn
GROUP BY Churn;

--Average Lifetime Revenue

SELECT
	Churn,
	ROUND(AVG(TotalCharges),2
		) AS avg_total_revenue
FROM customer_churn
GROUP BY Churn;
-- Churn By Tenure Buckets
SELECT
	CASE
	WHEN tenure <= 12 THEN '0-12 months'
	WHEN tenure <= 24 THEN '13- 24 months'
	WHEN tenure <= 48 THEN '25-48 months'
	ELSE '49+ months'
	END AS tenure_group,

	COUNT(*) AS customers,

	SUM(
		CASE
		WHEN Churn ='Yes' THEN 1 ELSE 0
		END
	) AS churned
FROM customer_churn
GROUP BY tenure_group;
--Churn Summary CTE

WITH churn_summary AS(
SELECT
	Contract,
	COUNT(*) AS customers,
	SUM(
		CASE
		WHEN Churn = 'Yes' THEN 1 ELSE 0
		END
	) AS churned
FROM customer_churn
GROUP BY Contract
)

SELECT *,
ROUND(
	100.0 * churned/customers,2) AS churn_rate

FROM churn_summary
ORDER BY churn_rate DESC;

-- Risk Segmentation

SELECT
	customerID,
	Contract,
	tenure,
	MonthlyCharges,
	CASE
	WHEN Contract = 'Monthly-to-month'
		AND tenure < 12
		AND MonthlyCharges >80
	THEN 'High Risk'

	WHEN tenure < 24
	THEN 'Medium Risk'

	ELSE 'Low Risk'

	END AS risk_segment
FROM customer_churn;