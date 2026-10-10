# Telecom Churn Reporting with dbt

A dbt Core + DuckDB project for cleaning telecom customer data
and reporting customer churn patterns.

## Data
- Customer data: 7,043 customers.
- ZIP code population: 1,671 ZIP codes.

## Models
- stg_telecom_customers: standardizes names, types and service labels.
- stg_zipcode_population: prepares ZIP codes and population.
- customer_churn: joins customers to population and adds segments.
- churn_by_contract: reports churn by contract type.
- churn_by_segment: reports churn by age, tenure, internet and population.

## Metric
Churn percentage = Churned customers / all customers in the group * 100.
The denominator includes Stayed, Churned and Joined customers.
This describes the supplied snapshot, rather than a longitudinal churn rate.

## Cleaning
ZIP codes are stored as text.
Customers without internet receive appropriate service labels.
Negative monthly charges are retained and flagged, but excluded
from monthly-charge averages through a separate analysis column.

## Key Findings
- Month-to-month contracts: 45.84% churn, versus 2.55% for two-year contracts.
- Customers with 0-12 months of tenure: 47.44%, versus 9.51% for 49+ months.
- Customers aged 65+: 41.68%.
- Fiber optic customers: 40.72%.

These associations suggest groups for further retention analysis;
they do not establish causes of churn.

## Run
Dependencies are listed in requirements.txt at the repository root.

    pip install -r requirements.txt
    cd telecom_churn

Configure a dbt profile named telecom_churn using the duckdb adapter,
path dev.duckdb and schema main. Then run:

    dbt debug
    dbt build
    dbt docs generate

## Validation
All 12 data tests passed, including unique keys, non-null fields,
accepted customer statuses and ZIP code relationships.
The build completed successfully: 2 seeds and 5 models.
