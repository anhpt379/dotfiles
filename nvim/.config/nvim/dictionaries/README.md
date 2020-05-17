# About

The `hacker_news.txt` file contains all words which are extracted from
`bigquery-public-data:hacker_news.full` dataset using Google BigQuery.

https://bigquery.cloud.google.com/table/bigquery-public-data:hacker_news.full?pli=1&tab=details

```sql
#standardSQL
SELECT word, COUNT(*) c FROM (
  SELECT REGEXP_EXTRACT_ALL(text, r"[a-zA-Z-]+") words
  FROM `bigquery-public-data.hacker_news.full`
), UNNEST(words) word
WHERE CHAR_LENGTH(word) > 2
  AND NOT ENDS_WITH(word, "-")
  AND NOT STARTS_WITH(word, "-")
  AND CHAR_LENGTH(word) - CHAR_LENGTH(REGEXP_REPLACE(word, "-", "")) <= 1
GROUP BY word
HAVING c >= 100
ORDER BY c DESC
```
