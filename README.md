# DBT Interview Project

Welcome to the **DBT Interview Project**! This repository demonstrates a refactoring of a SQL query into modular, maintainable dbt models following modern **best practices** for analytics engineering.

---

## Project Overview

This project transforms order data from a variety of source tables (`orders`, `payments`, `addresses`, `devices`) into a final **fact table** called `fct_orders` that can be used for reporting and analysis.

**Key Goals:**
1. Demonstrate dbt models that separate staging, intermediate, and marts layers.
2. Incorporate tests and documentation in YAML files.
3. Provide discussion points about data assumptions, quality checks, and model design decisions.
