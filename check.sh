#!/bin/bash
export LC_ALL=C.UTF-8

while IFS="" read -r url || [ -n "$url" ]; do
  echo "$url"
  filename_base="${url//[^A-Za-z0-9]/_}"
  csv_filepath="csv_metrics/$filename_base.csv"

  if [ ! -f "$csv_filepath" ]; then
    curl_format=$(cat curl_format.txt)
    csv_headers="timestamp;$(echo "$curl_format" | tr -d "%{" | tr -d "}")"
    echo "$csv_headers" >"$csv_filepath"
  fi

  timestamp=$(($(date +%s%N) / 1000000))
  curl_out=$(curl --write-out "@curl_format.txt" --output /dev/null --silent --max-time 30 "$url")
  echo -e "$timestamp;$curl_out" >>"$csv_filepath"
done <urls.txt
