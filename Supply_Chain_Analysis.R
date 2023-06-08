setwd("/users/victorharvey/Documents/Work/Projects/Portfolio/Supply-Chain-Analysis")

input_df <- read.csv("supply_chain_data.csv", header=TRUE, sep=',')

head(input_df)

tail(input_df)

str(input_df)

# Copy data
data <- data.frame(input_df)
tracemem(data) == tracemem(input_df)

#MISSING VALUES
any(is.na(data)) # are there any missing values
sapply(data, function(x) sum (is.na(x)))

str(data) #Looking for all the data that has more decimal places.

# Rounding every numeric column to 2 decimal places
data <- data %>% mutate(across(where(is.numeric), ~round(., 2)))

# NAMES
#Two columns have similar names and can lead to confusion, renaming.
colnames(data)[colnames(data) == "Lead.times"] = "Product.Lead.Time"
colnames(data)[colnames(data) == "Lead.time"] = "Supplier.Lead.Time"

# FACTORS
## Certain columns can be set as factors to help in categorical classification
str(data) # Looking for which columns can be set as factors

## columns potential for being factors are Procduct types, Custoemr Demographics, Shipping Carriers, Supplier Name, Location, Inspection Results, Transportation Modes, Routes
unique(data$Product.type) # Three unique values -  "haircare"  "skincare"  "cosmetics"

unique(data$Customer.demographics) # Four Unique values - "Non-binary" "Female"     "Unknown"    "Male"   

unique(data$Shipping.carriers) # Three unique values - "Carrier B" "Carrier A" "Carrier C"

unique(data$Supplier.name) # Five unique values - "Supplier 3" "Supplier 1" "Supplier 5" "Supplier 4" "Supplier 2"

unique(data$Location) # Four unique values - "Mumbai"    "Kolkata"   "Delhi"     "Bangalore" "Chennai"  

unique(data$Inspection.results) # Three unique values - "Pending" "Fail"    "Pass" 

unique(data$Transportation.modes) # Four unique values - "Road" "Air"  "Rail" "Sea" 

unique(data$Routes) # Three unique values - "Route B" "Route C" "Route A"

## or

for(i in colnames(data)){
  if (is.character(data[,i])){
    cat("Unique values in", i, ":", unique(data[,i]), "\n")
  }
}

## Change to Factor
for(i in colnames(data)){
  if (is.character(data[,i])){
    data[,i] <- as.factor(data[,i])
  }
}

## Check
str(data)

# REGEXR
data$SKU <- gsub("([A-Z])([0-9])", "\\1 \\2", data$SKU) #Turning SKU labels into a more readable format.

#ADD NEW FEATURES
data$Gross.Margin.Per.Product <- data$Price - data$Manufacturing.costs

# EXPLORE DATA
for(i in colnames(data)){
  if (is.numeric(data[,i])){
    cat("Minimum value in", i, ":", min(data[,i]), "\n")
    cat("Maximum value in", i, ":", max(data[,i]), "\n")
  }
}

# VISUALISATIONS
## Recurring Order by Product
ggplot(data=data, aes(x=Product.type)) + geom_bar() 
### Skin Care seems to be the most recurring product

## Price v Revenue Generated
ggplot(data = data, aes(x = Price, y = Revenue.generated)) +geom_point() 
### There is no trend between price and revenue generated per product

## Product Purchase Distribution
ggplot(data = data, 
       aes(x = Product.type, y = Customer.demographics, Name)
       ) + geom_tile(aes(fill = Number.of.products.sold),
                     colour = "white") + scale_fill_gradient(low = "white", 
                                                             high = "steelblue")
### We see that men tend to buy cosmetics and skincare products. 
### Women tend to buy haircare and skincare. 
### Non-binary seem to be equally distributed. 
### There is a group on unknown gender who tend to buy more Cosmetics.
### This unknown group should be investigated further.

## Purchase Distribution Among Demographic
ggplot(data = data, 
       aes(x = Price, fill = Product.type)
       ) + geom_histogram() + facet_wrap(~Customer.demographics)
### Men buy our products across the price range with a slight preference for cheaper and expensive
### Female tend to buy across the price range but with a heavy preference for cheaper products
### Non-binary tend to buy across the price range but with a heavy preference around the median
### Unknown tend to buy across the price range but with a heavy preference for expensive products
### This raises even more questions on who are the unknown and how can we maximize their shopping

## Product Type v Price
ggplot(data = data, 
       aes(x = Product.type, y = Price, fill = Product.type)
       ) + geom_violin(width = 1.4) + geom_boxplot(width = 0.1)
### Cosmetics are the most expensive products by average and weighted on the expensive side.
### Hair care is the second most expensive product on average but evenly distributed.
### Skincare is the cheapest product on average and weighted on the cheaper side.

## Product Type v Gross Margin
ggplot(data = data, 
       aes(x = Product.type, y = Gross.Margin.Per.Product, fill = Product.type)
       ) + geom_violin(width = 1.4) + geom_boxplot(width = 0.1)
### On average we seem to make Gross Profit on Cosmetics, very little on hair care and skincare products.
### This lays more emphasis on reaching the Unknown customer segment and driving demand for cosmetics.
### It also lays the question of whether er should discontinue some products.

## Product Type v Product Lead Time
ggplot(data = data, 
       aes(x = Product.type, y = Product.Lead.Time, fill = Product.type)
       ) + geom_violin(width = 1.4) + geom_boxplot(width = 0.1)
## Cosmetics has the highest average product lead time from us to the customer. 
## Skincare has the second highest product lead time but has extreme outliers.
## Further investigation shows that even Cosmetics has the longest lead time and weighted at the extreme.
## Skincare though has extreme outliers but weighted around the median.
## Our most profitable product seems to be also our longest lead time. Resources should be used to reduce this.


## Supplier v Carrier v Route Distribution
data %>%
  ggplot(aes(x = Product.type, fill = Shipping.carriers)
         ) + geom_bar() + facet_wrap(~Transportation.modes)
### Carrier A is used across the product spectrum except for Cosmetics through Air
### Carrier B is used across the product spectrum except for Cosmtics through Sea
### Carrier C is used acrooss the product spectrum but rarely dominates
### Further investigation should be along the lines of which carrier to prioritise

## Production Volumes v Manufacturing Costs
ggplot(data = data, aes(x = Production.volumes, y = Manufacturing.costs)) +geom_point()
### There doesnt seem to be a correlation between how much we produce and its cost

##Production Volumes v Manufacturing Lead Times
ggplot(data = data, aes(x = Production.volumes, y = Manufacturing.lead.time)) +geom_point()
### Through eyeballing the graph there does seem to be a slight correlation between production volume and how long to manufacture
### There may be case for increasing demand accuracy to reduce the risk in increasing production volumes

## Production Volumes v Supplier Lead Times
ggplot(data = data, 
       aes(x = Production.volumes, y = Supplier.Lead.Time)
       ) +geom_point()
### There doesnt seem to be a correlation between how much we produce and how quickly we can get it

## Supplier v Revenu Generated
ggplot(data = data, aes(x = Supplier.name, y = Revenue.generated)) + geom_bar(stat='identity')
### Supplier 1 supplies the revenue generating products. They should be a close relationship with them.

## Lead Times by Supplier Location
ggplot(data = data, 
       aes(x = Location, y = Supplier.Lead.Time, fill = Location)
       ) + geom_violin(width = 1.4) + geom_boxplot(width = 0.1) 
### On average products coming from Chennai have longer lead times followed by Bangalore

## Correlation Matrix of the entire data
numeric_data <- select_if(data, is.numeric)
cor_data <- round(cor(numeric_data), 2)
melted_data <- melt(cor_data)
head(melted_data)
ggplot(data = melted_data, aes(x = X1, y = X2, fill = value)) + geom_tile()
### There is a strong negative correlation between Gross Profit Margin and Manufacturing Costs
### There is a Strong Positive correlation between Price and Gross Profit Margin.
### In essence we should investigate how to reduce manufacturing costs and increase prices
