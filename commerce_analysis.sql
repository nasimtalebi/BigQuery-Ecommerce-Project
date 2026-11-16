-- 1. بررسی چند تراکنش اول از یک جدول نمونه
SELECT
  visitId,
  date,
  totals.transactions AS total_transactions,
  totals.totalTransactionRevenue AS revenue
FROM
  `bigquery-public-data.google_analytics_sample.ga_sessions_*`
WHERE
  _TABLE_SUFFIX BETWEEN '20170801' AND '20170807'
  AND totals.transactions > 0
LIMIT 10;

-- 2. محاسبه مجموع درآمد و تعداد کل تراکنش‌ها به تفکیک تاریخ
SELECT
  date,
  COUNT(visitId) AS total_visits,
  SUM(totals.transactions) AS total_transactions,
  SUM(totals.totalTransactionRevenue) AS total_revenue
FROM
  `bigquery-public-data.google_analytics_sample.ga_sessions_*`
WHERE
  _TABLE_SUFFIX BETWEEN '20170801' AND '20170807'
  AND totals.transactions > 0
GROUP BY
  date
ORDER BY
  date ASC;

-- 3. بررسی تعداد کل بازدیدها به تفکیک کشور برای یک روز مشخص
SELECT
  geoNetwork.country AS country,
  COUNT(visitId) AS total_visits
FROM
  `bigquery-public-data.google_analytics_sample.ga_sessions_20170801`
GROUP BY
  country
ORDER BY
  total_visits DESC
LIMIT 10;