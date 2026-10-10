select
    c.*,
    p.population,
    case
        when c.age < 30 then 'Under 30'
        when c.age < 50 then '30-49'
        when c.age < 65 then '50-64'
        else '65+'
    end as age_group,
    case
        when c.tenure_months <= 12 then '0-12 months'
        when c.tenure_months <= 24 then '13-24 months'
        when c.tenure_months <= 48 then '25-48 months'
        else '49+ months'
    end as tenure_group,
    case
        when p.population is null then 'Unknown'
        when p.population < 10000 then 'Under 10,000'
        when p.population < 50000 then '10,000-49,999'
        else '50,000+'
    end as population_group,
    case
        when c.monthly_charge >= 0 then c.monthly_charge
        else null
    end as monthly_charge_for_analysis
from {{ ref('stg_telecom_customers') }} c
left join {{ ref('stg_zipcode_population') }} p
    on c.zip_code = p.zip_code