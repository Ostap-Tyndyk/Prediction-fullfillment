WITH union_data AS
(
SELECT DISTINCT EXTRACT(MONTH FROM date) as month,
EXTRACT(DAY FROM date) as day,
SUM(price) as revenue,
0 as predict
FROM `data-analytics-mate.DA.product` p
INNER JOIN `data-analytics-mate.DA.order` o
ON p.item_id = o.item_id
INNER JOIN `data-analytics-mate.DA.session` s
ON o.ga_session_id = s.ga_session_id
GROUP BY 1, 2
UNION ALL

SELECT DISTINCT EXTRACT(MONTH FROM date) as month,
EXTRACT(DAY FROM date) as day,
0 as revenue,
SUM(predict) as predict
FROM `data-analytics-mate.DA.revenue_predict`
GROUP BY 1, 2
),
union_table AS
(
  SELECT month, day, SUM(revenue) as revenue, SUM(predict) as predict
  FROM union_data
  GROUP BY month, day
)

SELECT month, day,
SUM(revenue) OVER (PARTITION BY month ORDER BY day) as accumulation_revenue,
SUM(predict) OVER (PARTITION BY month ORDER BY day) as accumulation_predict,

SUM(revenue) OVER (PARTITION BY month ORDER BY day) /
SUM(predict) OVER (PARTITION BY month ORDER BY day) * 100
AS accumulation_revenue_percent_from_accumulation_predict
FROM union_table
