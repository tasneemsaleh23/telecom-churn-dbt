{% set segments = [
    'age_group',
    'tenure_group',
    'internet_type',
    'population_group'
] %}

{% for segment in segments %}

select
    '{{ segment }}' as segment_type,
    coalesce({{ segment }}, 'Unknown') as segment_value,
    count(*) as total_customers,
    sum(is_churned) as churned_customers,
    round(
        100.0 * sum(is_churned) / count(*),
        2
    ) as churn_pct_all_customers

from {{ ref('customer_churn') }}
group by {{ segment }}

{% if not loop.last %}
union all
{% endif %}

{% endfor %}