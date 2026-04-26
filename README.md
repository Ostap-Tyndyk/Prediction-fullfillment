## Task Description

The goal of this query is to compare actual daily revenue against predicted revenue, tracking how both accumulate over time within each month.

The report combines real transaction data with forecast figures using a `UNION ALL` approach — actual revenue is pulled from orders and products, while predictions come from a dedicated forecast table. Both datasets are aligned by month and day, then merged into a unified daily timeline.

The final output calculates running totals for both actual and predicted revenue within each month using window functions, and expresses actual performance as a percentage of the forecast. This allows stakeholders to monitor day-by-day whether the business is on track to meet its revenue targets.
