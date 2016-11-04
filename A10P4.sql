--part 4
--1
SELECT  C.CUST_CITY, P.PROD_CATEGORY, SUM(L.LINE_QTY * L.LINE_PRICE) AS TOTAL_SALES
FROM CUSTOMERDIM C INNER JOIN LGINVOICE I ON C.CUST_CODE = I.CUST_CODE
INNER JOIN LGLINE L ON I.INV_NUM = L.INV_NUM 
INNER JOIN PRODUCTDIM P ON L.PROD_SKU = P.PROD_SKU
GROUP BY C.CUST_CITY, P.PROD_CATEGORY
ORDER BY C.CUST_CITY

--2
SELECT TOP 3 (T.MONTH), ROUND(SUM(L.LINE_QTY * L.LINE_PRICE),2) AS TOTAL_SALE
FROM TIMEDIM T INNER JOIN LGINVOICE I ON T.ORDER_DATE = I.INV_DATE
INNER JOIN LGLINE L ON I.INV_NUM = L.INV_NUM 
GROUP BY (T.MONTH)
ORDER BY TOTAL_SALE DESC

--3
-- SHOW ALL THE CUSTOMER NUMBER AND NAME WHO PURCHASES IN JUNE FROM DEPARTMENT 200
SELECT  C.CUST_CODE,(C.CUST_FNAME +' '+C.CUST_LNAME) AS [CUTOMER NAME], E.EMP_NUM, P.PROD_SKU,P.PROD_PRICE,
		P.PROD_TYPE, D.DEPT_NUM, T.MONTH
FROM LGINVOICE I INNER JOIN CUSTOMERDIM C ON I.CUST_CODE = C.CUST_CODE
INNER JOIN EMPLOYEEDIM E ON I.EMPLOYEE_ID= E.EMP_NUM 
INNER JOIN TIMEDIM T ON I.INV_DATE = T.ORDER_DATE
INNER JOIN LGLINE L ON I.INV_NUM = L.INV_NUM
INNER JOIN PRODUCTDIM P ON L.PROD_SKU =P.PROD_SKU
INNER JOIN DEPARTMENTDIM D ON E.EMP_NUM = D.EMP_NUM
WHERE E.DEPT_NUM =200  AND T.MONTH =6