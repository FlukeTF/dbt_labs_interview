# Data Discussion

This document outlines the considerations in our **fct_orders** model.

---

## 1. Currency Conversions

- **Amounts in Cents**  
  - We are currently dividing `amount_*_cents` fields by 100 to convert them into dollar amounts.  
  - The raw data shows other currencies other than **USD** such as **GBP** and **EUR**. We may need a different approach on how to handle conversions for non-USD currencies.

- **Currency Consistency**  
  - The logic for `total_amount_cents` switches to `gross_total_amount_cents` if the currency is not `'USD'`. 
  - Do we need historical exchange rates for orders that are placed in different currencies?

---

## 2. Device Classification

- **Unknown or Unexpected Devices**  
  - The logic groups devices into categories like `'desktop'`, `'mobile-app'`, `'mobile-web'`, `'unknown'`, or `'ERROR'`.  
  - If new device types appear, how do we classify them?  
  - Is `'ERROR'` meant to be used for data integrity warning?

---

## 3. Address Categorization

- **Country Code**  
  - We categorize addresses into `'US'`, `'International'`, or `'Null country'`.  
  - Could there be multiple address records per order? How do we handle those?  
  - If the business expands, do we need a more detailed classification (e.g., CA, UK, EU, etc.), or perhaps by region (US, EMEA, Latin America, Asia, etc.)?

---


### Conclusion

These **data considerations** represent only a few questions that came up while working on the data models. 
Addressing these points proactively would potentially result in higher data quality data models and fewer issues in the future.
