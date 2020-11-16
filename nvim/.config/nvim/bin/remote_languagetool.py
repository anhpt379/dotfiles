#!/usr/bin/env python3

import sys
import json
import requests

language = "en-US"
text = sys.stdin.read()

r = requests.post(
    "https://languagetool.org/api/v2/check", data={"text": text, "language": language}
)

matches = r.json().get("matches", [])
for match in matches:
    replacements = ", ".join([i["value"] for i in match["replacements"]])
    if replacements:
        match["message"] = match["message"] + "\nReplacements: " + replacements

    # Convert from offset to line/column
    offset = match["offset"]
    line = text[:offset].count("\n") + 1  # line number starts from 1
    column = 1
    for i in text[:offset][::-1]:
        if i == "\n":
            break
        column += 1
    match["line"] = line
    match["column"] = column

    # Show as warnings in coc-diagnostic
    match["level"] = "warning"

print(json.dumps(matches))
