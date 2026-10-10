select
    contract,
    count(*) as total_customers,
    sum(is_churned) as churned_customers,

    round(
        100.0 * sum(is_churned) / count(*),
        2
    ) as churn_pct_all_customers,

    round(
        avg(monthly_charge_for_analysis),
        2
    ) as avg_valid_monthly_charge

from {{ ref('customer_churn') }}
group by contract