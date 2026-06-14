# Customer Churn Analysis | PostgreSQL + Power BI

##  Project Overview

Customer retention is a critical business challenge for subscription-based organizations. This project analyzes telecom customer data to identify factors influencing customer churn and uncover opportunities to improve customer retention.

Using **PostgreSQL** for data analysis and **Power BI** for visualization, the project explores customer behavior across contract types, tenure groups, internet services, payment methods, and support services to generate actionable business insights.

---

##  Business Objective

The primary objectives of this project were to:

- Identify key drivers of customer churn
- Analyze customer behavior patterns
- Segment customers based on churn risk
- Discover retention opportunities
- Build an interactive dashboard for executive decision-making

---

##  Tools & Technologies

### Database
- PostgreSQL

### Data Visualization
- Power BI

### Skills Demonstrated
- SQL Queries
- Data Cleaning
- Data Analysis
- Customer Segmentation
- CASE Statements
- Common Table Expressions (CTEs)
- KPI Development
- Business Intelligence
- Dashboard Design
- Business Insights Generation

---

##  Dataset Information

**Dataset:** Telecom Customer Churn Dataset

**Records Analyzed:** 5,880 Customers

### Key Attributes

- Customer ID
- Gender
- Senior Citizen
- Partner
- Dependents
- Tenure
- Phone Service
- Internet Service
- Online Security
- Tech Support
- Contract Type
- Payment Method
- Monthly Charges
- Total Charges
- Churn Status

---

##  Project Workflow

### 1. Data Preparation

- Imported customer churn dataset into PostgreSQL
- Validated data types and schema structure
- Checked for missing values and duplicates
- Performed data quality verification

### 2. SQL Analysis

Conducted analysis on:

- Overall churn distribution
- Churn by contract type
- Churn by internet service
- Churn by payment method
- Churn by tenure group
- Churn by support services
- Customer risk segmentation

### 3. Power BI Dashboard Development

Created an interactive dashboard featuring:

- Total Customers
- Churned Customers
- Churn Rate
- Average Monthly Charges
- Average Customer Tenure
- Churn by Contract Type
- Churn by Internet Service
- Churn by Payment Method
- Customer Risk Segmentation
- Tenure-Based Churn Analysis
- Tech Support Impact Analysis

---

##  Key SQL Queries

### Overall Churn Distribution

```sql
SELECT
    churn,
    COUNT(*) AS customer_count
FROM customer_churn
GROUP BY churn;
```

### Churn by Contract Type

```sql
SELECT
    contract,
    COUNT(*) AS customers,
    SUM(
        CASE
            WHEN churn = 'Yes' THEN 1
            ELSE 0
        END
    ) AS churned_customers
FROM customer_churn
GROUP BY contract;
```

### Customer Tenure Segmentation

```sql
SELECT
    CASE
        WHEN tenure <= 12 THEN '0-12 Months'
        WHEN tenure <= 24 THEN '13-24 Months'
        WHEN tenure <= 48 THEN '25-48 Months'
        ELSE '49+ Months'
    END AS tenure_group,
    COUNT(*) AS customers
FROM customer_churn
GROUP BY tenure_group;
```

### Churn by Internet Service

```sql
SELECT
    internetservice,
    COUNT(*) AS customers,
    SUM(
        CASE
            WHEN churn = 'Yes' THEN 1
            ELSE 0
        END
    ) AS churned_customers
FROM customer_churn
GROUP BY internetservice;
```

---

##  Dashboard Features

### Executive Summary

- Total Customers
- Churned Customers
- Churn Rate
- Average Monthly Charges
- Average Customer Tenure

### Churn Analysis

- Contract Type Analysis
- Internet Service Analysis
- Payment Method Analysis
- Tenure Analysis
- Tech Support Impact Analysis
- Customer Risk Segmentation

---

## 💡 Key Findings

### Contract Type Impact

Customers on month-to-month contracts exhibited higher churn behavior compared to customers with long-term contracts.

### Customer Tenure

Customers with shorter tenure demonstrated a higher likelihood of churn, highlighting the importance of early customer engagement.

### Technical Support

Customers without technical support services showed increased churn tendencies compared to those receiving support services.

### Customer Risk Segmentation

High-risk customers were identified based on:

- Contract Type
- Customer Tenure
- Monthly Charges

### Retention Opportunities

Potential retention strategies include:

- Promoting long-term contracts
- Enhancing customer onboarding experiences
- Providing targeted retention campaigns
- Encouraging adoption of support services

---

##  Dashboard Preview

### Executive Dashboard

![Executive Dashboard](screenshots/executive_dashboard.png)

### Churn Analysis Dashboard

![Churn Analysis Dashboard](screenshots/churn_analysis_dashboard.png)

---

##  Project Structure

```text
customer-churn-analysis-sql-powerbi/
│
├── dataset/
│   └── telecom_customer_churn.csv
│
├── sql/
│   └── customer_churn_analysis.sql
│
├── powerbi/
│   └── Customer_Churn_Dashboard.pbix
│
├── screenshots/
│   ├── executive_dashboard.png
│   └── churn_analysis_dashboard.png
│
└── README.md
```

---

##  Business Impact

This project demonstrates how data analytics can be leveraged to:

- Understand customer churn behavior
- Identify high-risk customer segments
- Improve retention strategies
- Support data-driven decision making
- Enhance customer lifetime value

---
⭐ If you found this project useful, consider giving the repository a star.
