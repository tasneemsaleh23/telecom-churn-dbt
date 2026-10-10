select
    trim("Zip Code") as zip_code,
    cast("Population" as integer) as population

from {{ ref('telecom_zipcode_population') }}