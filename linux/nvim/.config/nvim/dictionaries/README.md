# About

The `hacker_news.txt` file contains all words which are extracted from
[`bigquery-public-data:hacker_news.full`][1] dataset using Google BigQuery.

To generate a new file, go to [GCP BigQuery][2] and run this query:

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

After it's done, save the results to Google Cloud Drive in CSV format, then
download the file and run this command:

```bash
cat bq-results-<datetime>.csv | tail -n+2 | awk -F, '{ print $1 }' > hacker_news.txt
```

[1]: https://bigquery.cloud.google.com/table/bigquery-public-data:hacker_news.full?pli=1&tab=details
[2]: https://console.cloud.google.com/bigquery?project=coc-dictionaries&authuser=1&p=coc-dictionaries&page=project
