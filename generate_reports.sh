#!/bin/bash
export LC_ALL=C.UTF-8

for csv_filepath in csv_metrics/*.csv; do
  csv_filename=$(basename "$csv_filepath")
  echo "$csv_filename"

  csv=$(tr "\n" "," <"$csv_filepath")

  template=$(cat report_template.html)
  echo "${template/csv_file_contents/$csv}" >"html_reports/$csv_filename.html"
done
