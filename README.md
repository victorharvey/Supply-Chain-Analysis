# Supply Chain Analysis using R
*Receiving Raw Data Cleaning and preparing it for analysis for strategy setting*

## Raw Data
The raw data is supply chain data with the following column names:
- Product type
- SKU
- Price
- Availability
- Number of products sold
- Revenue generated
- Customer demographics
- Stock levels
- Lead times
- Order quantities
- Shipping times
- Shipping carriers
- Shipping costs
- Supplier name
- Location
- Lead time
- Production volumes
- Manufacturing lead time
- Manufacturing costs
- Inspection results
- Defect rates
- Transportation modes
- Routes
- Costs

## Copy Data
First I copy the data to make sure the original file is left intact throughout the analysis.

## Missing Values
I Then proceeed to chekc for missing values.

## Round Down numerics
THe numeric values are 4 digits long. Most account and finance metrics go to 2 digits. Roudning off to become more understandable.

## Column Names
Two Column names in the data appear similar but show different things
- Lead Times: Which is meant to show lead times from us to the customer.
- Lead time: Which is meant to show lead times from supplier to us.

Renaming for clarity and less confusion.

## Factors
Some coloumn names are characters and can be easily be used to be set as factors to aid in the analysis.

This section shows two ways on how to do that.

## Feature Engineering
There is a need to engineer a new feature from Price and Manufacturing Costs. 

Gross Profit Margin will let us know the profitability of each SKU.

## Visualisation
This section is the first stage of exploratory analysis. Eye balling the dat to seek patterns before running any algorithms. 

### Recurring Order by Product.
![alt text](img/mRecurring Order by Product.png "Title Text")

Skincare products seem to be the most recurring sales.

### Price v Revenue Generated.
![alt text](img/Price v Revenue Generated.png "Plot Chart of the Price and Revenue Distribution")

There is no trend between price and revenue generated per product.

### Purchase Distribution Among Customer Demographic.
![alt text](img/Purchase_Distribution_Among_Customer_Demographic.png "Purchase Distribution Among Customer Demographic")

Males buy products across the price range with a slight preference for both cheap and expensive (outliers). Females tend to buy across the price range but with a heavy preference for cheaper range of products. Non-binaries tend to buy across the price range but with a heavy preference around the median. The Unknowns tend to buy across the price range but with a heavy preference for expensive products. 

Conclusion: This raises even more questions on who are the unknown and how can we increase their purchases?

### Product Type v Price
![alt text](img/Product_Type_v_Price.png "Product Type v Price")

Men buy our products across the price range with a slight preference for cheaper and expensive
Cosmetics are the most expensive products on average but weighted on the expensive side. Haircare is the second most expensive product on average but evenly distributed. Skincare is the cheapest product on average and weighted on the cheaper side.

### Product Type v Gross Margin
![alt text](img/Product_Type_v_Gross_Margin.png "Product Type v Gross Margin")

On average we seem to make Gross Profit on Cosmetics, very little on haircare and skincare products. This lays more emphasis on reaching the Unknown customer segment and increasing their purchases for cosmetics products. It also lays the question of whether the company should discontinue some products.

Conclusion: How to increase the Unknown segments purchases? Is there a need for product discontinuity?

### Product Type v Product Lead Time
![alt text](img/Product_Type_v_Product_Lead_Time.png "Product Type v Product Lead Time")

Cosmetics has the highest average product lead time from us to the customer and weighted at the extreme.. Skincare though has extreme outliers but weighted around the mean. Our most profitable products, Cosmetics, seem to be also have the longest lead time. 

Conclusion: Should resources be used to reduce this?

### Supplier v Carrier v Route Distribution
![alt text](img/Supplier_v_Carrier_Route_Distribution.png "Supplier v Carrier v Route Distribution")

Carrier A is used across the product spectrum except for Cosmetics through Air. Carrier B is used across the product spectrum except for Cosmtics through Sea. Carrier C is used acrooss the product spectrum but rarely dominates.

Conclusion: Which Carrier to prioritise and Why do certain carrier not offer certain routes for seect products?

### Shipping Carrier v Shipping Costs
![alt text](img/Supplier_Carrier_v_Shipping_Costs.png "Shipping Carrier v Shipping Costs")

Carrier A is the cheapest on average and weighted around the mean. Carrier C is the second cheapest but weighted on the expensive end. Carriers B is the most expensive but evenly distributed.

Conclusion: Is there a way to prioritise Carrier A and reduce Carrier C?

### Production Volumes v Manufacturing Costs
![alt text](img/Production_Volumes_v_Manufacturing_Cost.png "Production Volumes v Manufacturing Costs")

There doesnt seem to be a correlation between how much we produce and its cost.

### Production Volumes v Manufacturing Lead Times
![alt text](img/Production_Volumes_v_Manufacturing_Lead_Times.png "Production Volumes v Manufacturing Lead Times")

Through eyeballing the graph there does seem to be a slight correlation between production volume and how long to manufacture. There may be a case for increasing demand accuracy to reduce the risk of increasing production volumes.

Conclusion: Look at whether we can increase demand accuracy forecasting?

### Supplier v Revenue Generated
![alt text](img/Supplier_v_Revenue_Generated.png "Supplier v Revenue Generated")

Supplier 1 supplies the highest amount of revenue generating products. They should be a close relationship with them. There most revenue generating product is skincare which happens to be our most recurring sales. Most of the top 4 suppliers supply significant amounts of skincare products. Most of the top 4 suppliers supply significant amount of cosmetic products. Supplier 2 supplies a significant supply of haircare.

Conclusion: How can we incentivies suppliers to reduce their costs? Maybe a Carrot for Supplier 4 and Stick for the rest.

### Supplier v Shipping Location
![alt text](img/Supplier_v_Shipping_Location.png "Supplier v Shipping Location")

Suppliers seem to be equally distributed across locations.

### Lead Times by Supplier Location
![alt text](img/Lead_Times_by_Supplier_Location.png "Lead Times by Supplier Location")

On average products coming from Chennai and Bangalore have longer lead times followed by Bangalore.

Conclusion: How does this breakdown by product type?

### Correlation Matrix of the entire data
![alt text](img/Correlation_Matrix.png "Correlation Matrix")

There is a strong negative correlation between Gross Margin and Manufacturing Costs. There is a Strong Positive correlation between Price and Gross Margin.

Conclusion: Investigate how to reduce manufacturing costs and increase prices.