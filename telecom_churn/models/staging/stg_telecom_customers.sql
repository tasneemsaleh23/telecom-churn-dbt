with raw_customers as (

    select *
    from {{ ref('telecom_customer_churn') }}

),

cleaned as (

    select
        trim("Customer ID") as customer_id,
        trim("Gender") as gender,
        cast("Age" as integer) as age,
        trim("Married") as married,
        cast("Number of Dependents" as integer) as number_of_dependents,

        trim("City") as city,
        trim("Zip Code") as zip_code,

        cast("Tenure in Months" as integer) as tenure_months,
        trim("Contract") as contract,
        trim("Payment Method") as payment_method,
        trim("Paperless Billing") as paperless_billing,
        trim("Offer") as offer,

        trim("Phone Service") as phone_service,
        trim("Internet Service") as internet_service,

        case
            when "Internet Service" = 'No' then 'No Internet'
            else nullif(trim("Internet Type"), '')
        end as internet_type,

        case
            when "Internet Service" = 'No' then 'Not Applicable'
            else nullif(trim("Online Security"), '')
        end as online_security,

        case
            when "Internet Service" = 'No' then 'Not Applicable'
            else nullif(trim("Premium Tech Support"), '')
        end as premium_tech_support,

        cast("Monthly Charge" as decimal(12, 2)) as monthly_charge,
        cast("Total Charges" as decimal(12, 2)) as total_charges,
        cast("Total Revenue" as decimal(12, 2)) as total_revenue,

        case
            when "Monthly Charge" < 0 then true
            else false
        end as has_negative_monthly_charge,

        trim("Customer Status") as customer_status,
        nullif(trim("Churn Category"), '') as churn_category,
        nullif(trim("Churn Reason"), '') as churn_reason,

        case
            when "Customer Status" = 'Churned' then 1
            else 0
        end as is_churned

    from raw_customers

)

select *
from cleaned