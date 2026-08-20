SELECT * FROM [DATA SET FROM FEB TO JULY ]

--checking null value in the data
SELECT
 SUM(CASE WHEN Main_distributer_code is NULL THEN 1 ELSE 0 END) AS NULL_MAIN_DISTRIBUTER_CODE,
 SUM(CASE WHEN main_distibuter_name is NULL THEN 1 ELSE 0 END) AS NULL_MAIN_DISTRIBUTER_NAME,
 SUM(CASE WHEN sub_distributer_code is NULL THEN 1 ELSE 0 END) AS NULL_sub_distributer_code,
 SUM(CASE WHEN sub_distributer_name is NULL THEN 1 ELSE 0 END) AS NULL_sub_distributer_name,
 SUM(CASE WHEN Region_Name is NULL THEN 1 ELSE 0 END) AS NULL_Region_Name,
 SUM(CASE WHEN Seller_Code is NULL THEN 1 ELSE 0 END) AS NULL_Seller_Code,
 SUM(CASE WHEN Seller_Name is NULL THEN 1 ELSE 0 END) AS NULL_Seller_Name,
 SUM(CASE WHEN Seller_OrderReason is NULL THEN 1 ELSE 0 END) AS NULL_Seller_OrderReason,
 SUM(CASE WHEN Seller_Type is NULL THEN 1 ELSE 0 END) AS NULL_Seller_Type,
 SUM(CASE WHEN Buyer_Code is NULL THEN 1 ELSE 0 END) AS NULL_Buyer_Code,
 SUM(CASE WHEN Buyer_Name is NULL THEN 1 ELSE 0 END) AS NULL_Buyer_Name,
 SUM(CASE WHEN Buyer_Type is NULL THEN 1 ELSE 0 END) AS NULL_Buyer_Type,
 SUM(CASE WHEN BASIC_Model is NULL THEN 1 ELSE 0 END) AS NULL_BASIC_Model,
 SUM(CASE WHEN QTY is NULL THEN 1 ELSE 0 END) AS NULL_QTY,
 SUM(CASE WHEN VALUE is NULL THEN 1 ELSE 0 END) AS NULL_VALUE
 FROM [DATA SET FROM FEB TO JULY ]


--another code to check null value in every column
SELECT *
FROM [DATA SET FROM FEB TO JULY ]
WHERE Main_distributer_code IS NULL
   OR main_distibuter_name  IS NULL
   OR sub_distributer_code IS NULL
   OR sub_distributer_name IS NULL
   OR Region_Name IS NULL
   OR Seller_Code IS NULL
   OR Seller_Name IS NULL
   OR Seller_OrderReason IS NULL
   OR Seller_Type IS NULL
   OR Buyer_Code IS NULL
   OR Buyer_Name IS NULL
   OR Buyer_Type IS NULL
   OR BASIC_Model IS NULL
   OR QTY IS NULL
   OR VALUE IS NULL;


--deleting the null values
DELETE FROM [DATA SET FROM FEB TO JULY ]
WHERE sub_distributer_code IS NULL
   OR sub_distributer_name IS NULL;

--FINDING DUPLICATE VALUES
SELECT
    Main_distributer_code,
    main_distibuter_name,
    sub_distributer_code,
    sub_distributer_name,
    Region_Name,
    Seller_Code,
    Seller_Name,
    Seller_OrderReason,
    Seller_Type,
    Buyer_Code,
    Buyer_Name,
    Buyer_Type,
    BASIC_Model,
    QTY,
    VALUE,
    COUNT (*) AS Duplicate_Count
FROM [DATA SET FROM FEB TO JULY ]
GROUP BY
    Main_distributer_code,
    main_distibuter_name,
    sub_distributer_code,
    sub_distributer_name,
    Region_Name,
    Seller_Code,
    Seller_Name,
    Seller_OrderReason,
    Seller_Type,
    Buyer_Code,
    Buyer_Name,
    Buyer_Type,
    BASIC_Model,
    QTY,
    VALUE
HAVING COUNT(*) > 1;

--DELETING UNWANTED COLUMNS ( did everything on by one)
ALTER TABLE [DATA SET FROM FEB TO JULY]
DROP COLUMN Seller_Type
DROP COLUMN Region_Name,
DROP COLUMN sub_distributer_Code,
DROP COLUMN sub_distributer_name,
DROP COLUMN Seller_OrderReason,

--total sellout value
SELECT SUM (VALUE) AS TOTAL_SELLOUT_VALUE FROM [DATA SET FROM FEB TO JULY ]

-- TOTAL QTY SOLD
SELECT SUM (QTY) AS TOTAL_QTY_SOLD FROM [DATA SET FROM FEB TO JULY ]

--AVERAGE SELLOUT PER DEALER
SELECT AVG (VALUE) AS AVERAGE_SELLOUT FROM [DATA SET FROM FEB TO JULY ]

--AVERAGE QTY SOLD PER DEALER
SELECT AVG (QTY) AS AVERAGE_QTY_SOLD FROM [DATA SET FROM FEB TO JULY ]

--TOTAL SALES DONE BY ONE DEALER (VALUE,QTY)
SELECT 
    [Buyer_Name],
    SUM(QTY) AS Total_Quantity,
    SUM(VALUE) AS Total_Sales_Value
FROM [DATA SET FROM FEB TO JULY ]
GROUP BY [Buyer_Name]
ORDER BY Total_Sales_Value DESC;

--TOTAL SALES DONE BY ONE DEALER (VALUE,QTY & DEALER CODE)
SELECT
    [Buyer_Code],
    [Buyer_Name],
    SUM([QTY]) AS Total_Quantity,
    SUM([VALUE]) AS Total_Sales_Value
FROM [DATA SET FROM FEB TO JULY ]
GROUP BY
    [Buyer_Code],
    [Buyer_Name]
ORDER BY Total_Sales_Value DESC;

--TOTAL SALES DONE BY ONE DEALER (VALUE,QTY,DEALER CODE & Seller name)
SELECT
    [Seller_Name],
    [Buyer_Code],
    [Buyer_Name],
    SUM([QTY]) AS Total_Quantity,
    SUM([VALUE]) AS Total_Sales_Value
FROM [DATA SET FROM FEB TO JULY ]
GROUP BY
    [Seller_Name],
    [Buyer_Code],
    [Buyer_Name]
ORDER BY Total_Sales_Value DESC;

--TOTAL SALES BY PRODUCT NAME (ORDER BY TOTAL SALES)
SELECT
    [BASIC_Model],
    SUM([QTY]) AS Total_Qty,
    SUM([VALUE]) AS Total_Sales
FROM [DATA SET FROM FEB TO JULY ]
GROUP BY [BASIC_Model]
ORDER BY Total_Sales DESC;

--TOTAL SALES BY PRODUCT NAME (ORDER BY TOTAL QTY)
SELECT
    [BASIC_Model],
    SUM([QTY]) AS Total_Qty,
    SUM([VALUE]) AS Total_Sales
FROM [DATA SET FROM FEB TO JULY ]
GROUP BY [BASIC_Model]
ORDER BY Total_Qty DESC;

-- top 10 best sold phone
SELECT TOP 10
    [BASIC_Model],
    SUM([QTY]) AS Total_Qty,
    SUM([VALUE]) AS Total_Sales
FROM [DATA SET FROM FEB TO JULY ]
GROUP BY [BASIC_Model]
ORDER BY Total_Qty DESC;

-- TOP 10 LEAST sold phone
SELECT TOP 10
    [BASIC_Model],
    SUM([QTY]) AS Total_Qty,
    SUM([VALUE]) AS Total_Sales
FROM [DATA SET FROM FEB TO JULY ]
GROUP BY [BASIC_Model]
ORDER BY Total_Qty ASC;

--AVERAGE SALE VALUE BY PRODUCT
SELECT
    BASIC_Model,
    AVG(VALUE) AS Avg_Sale_Value
FROM [DATA SET FROM FEB TO JULY ]
GROUP BY BASIC_Model
ORDER BY Avg_Sale_Value DESC;

--PRODUCT CONTRIBUTION TO TOTAL REVENUE
SELECT
    BASIC_Model,
    SUM(VALUE) AS Total_Sales,
    CAST(
        ROUND(
            SUM(VALUE) * 100.0 /
            (SELECT SUM(VALUE) FROM [DATA SET FROM FEB TO JULY ]),
            2
        ) AS DECIMAL(10,2)
    ) AS Percentage_Contribution
FROM [DATA SET FROM FEB TO JULY ]
GROUP BY BASIC_Model
ORDER BY Total_Sales DESC;

--Ranking Products Using Window Functions
SELECT
    BASIC_Model,
    SUM(VALUE) AS Total_Sales,
    RANK() OVER(ORDER BY SUM(VALUE) DESC) AS Sales_Rank
FROM [DATA SET FROM FEB TO JULY ]
GROUP BY BASIC_Model;

--DENSE RANK 
SELECT
    BASIC_Model,
    SUM(VALUE) AS Total_Sales,
    DENSE_RANK() OVER(ORDER BY SUM(VALUE) DESC) AS Sales_Rank
FROM [DATA SET FROM FEB TO JULY ]
GROUP BY BASIC_Model;

--RUNNING TOTAL SALES
WITH ProductSales AS
(
    SELECT
        BASIC_Model,
        SUM(VALUE) AS Total_Sales
    FROM [DATA SET FROM FEB TO JULY ]
    GROUP BY BASIC_Model
)

SELECT
    BASIC_Model,
    Total_Sales,
    SUM(Total_Sales) OVER
    (
        ORDER BY Total_Sales DESC
    ) AS Running_Total
FROM ProductSales;

--DEALER ABOVE AVERAGE SALES
SELECT
    Buyer_Name,
    SUM(VALUE) AS Total_Sales
FROM [DATA SET FROM FEB TO JULY ]
GROUP BY Buyer_Name
HAVING SUM(VALUE) >
(
    SELECT AVG(VALUE)
    FROM [DATA SET FROM FEB TO JULY ]
);

--HIGHEST VALUE SALES
SELECT TOP 1 *
FROM [DATA SET FROM FEB TO JULY ]
ORDER BY VALUE DESC;

--LOWEST VALUE SALES
SELECT TOP 1 *
FROM [DATA SET FROM FEB TO JULY ]
ORDER BY VALUE ASC;

--TOTAL NUMBER OF DEALER
SELECT COUNT(DISTINCT Buyer_Code) AS Total_Dealers
FROM [DATA SET FROM FEB TO JULY ];

--TOTAL NUMBER OF PRODUCT
SELECT COUNT(DISTINCT BASIC_Model) AS Total_Products
FROM [DATA SET FROM FEB TO JULY ];

--HIGH-MEDIUM-LOW SELLING PRODUCT
SELECT
    BASIC_Model,
    SUM(VALUE) AS Total_Sales,
    CASE
        WHEN SUM(VALUE) >= 2500000 THEN 'High'
        WHEN SUM(VALUE) >= 500000 THEN 'Medium'
        ELSE 'Low'
    END AS Sales_Performance
FROM [DATA SET FROM FEB TO JULY ]
GROUP BY BASIC_Model
ORDER BY Total_Sales DESC;