
SELECT
    [Market],
    [Product_Name],
    [Category_Name],
    [Order_Status],
   
    
    COUNT(*) AS Total_Orders,
    ROUND(SUM([Order_Profit_Per_Order]), 2) AS Total_Profit_Or_Loss,
    ROUND(SUM([Sales]), 2) AS Total_Sales_Volume,
   
    
    ROUND((SUM([Order_Profit_Per_Order]) / NULLIF(SUM([Sales]), 0)) * 100, 2) AS Profit_Margin_Percentage,
   
    
    SUM(CAST([Late_delivery_risk] AS INT)) AS Total_Late_Orders,
    ROUND((CAST(SUM(CAST([Late_delivery_risk] AS INT)) AS FLOAT) / NULLIF(COUNT(*), 0)) * 100, 2) AS Late_Delivery_Percentage,
   
    
    CASE
        WHEN (CAST(SUM(CAST([Late_delivery_risk] AS INT)) AS FLOAT) / NULLIF(COUNT(*), 0)) > 0.6 THEN '🚨 CRITICAL: Logistics Bottleneck'
        WHEN (CAST(SUM(CAST([Late_delivery_risk] AS INT)) AS FLOAT) / NULLIF(COUNT(*), 0)) BETWEEN 0.4 AND 0.6 THEN '⚠️ WARNING: High Risk'
        ELSE '✅ SAFE: Stable Route'
    END AS Route_Status

INTO Table_Final_my_Project 
FROM
    DataCoSupplyChainDataset
GROUP BY
    [Market], [Product_Name], [Category_Name], [Order_Status];