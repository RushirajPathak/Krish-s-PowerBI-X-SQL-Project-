-- Creating a Common Table Expression (CTE) to combine data from two bike share tables
WITH cte AS (
    SELECT * FROM bike_share_yr_0 -- Selecting all records from the first year bike share data
    UNION ALL
    SELECT * FROM bike_share_yr_1 -- Appending all records from the second year bike share data
)

-- Selecting relevant columns along with calculated revenue and profit
SELECT
    dteday,                     -- Date of the bike ride
    season,                     -- Season during which the ride occurred
    a.yr,                       -- Year of the ride (from the CTE alias 'a')
    weekday,                    -- Day of the week
    hr,                         -- Hour of the day
    rider_type,                 -- Type of rider (e.g., casual, registered)
    riders,                     -- Number of riders
    price,                      -- Price per rider
    COGS,                       -- Cost of Goods Sold (from the cost_table)
    riders * price AS revenue,  -- Calculated revenue: riders multiplied by price
    riders * price - COGS AS profit -- Calculated profit: revenue minus COGS
FROM cte a
LEFT JOIN cost_table b          -- Performing a LEFT JOIN to include all records from the CTE even if there's no matching cost data
    ON a.yr = b.yr              -- Joining on the 'yr' column to match year-specific cost data
