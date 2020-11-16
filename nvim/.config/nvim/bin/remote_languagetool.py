#!/usr/bin/env python3

import os
import sys
import json
import requests

language = "en-US"
text = sys.stdin.read()

r = requests.post(
    "https://languagetool.org/api/v2/check", data={"text": text, "language": language}
)
r.raise_for_status()

pwl_path = os.path.dirname(__file__) + "/../dictionaries/personal_word_list.txt"
personal_word_list = open(pwl_path).read().splitlines()

matches = r.json().get("matches", [])
for match in matches:
    offset = match["offset"]
    length = match["length"]
    word = text[offset : offset + length]
    if word in personal_word_list:
        continue

    replacements = " / ".join([i["value"] for i in match["replacements"]])
    if replacements:
        match["message"] = f"{match['message']}\n\"{word}\" -> {replacements}"

    # Convert from offset to line/column
    line = text[:offset].count("\n") + 1  # line number starts from 1
    column = 1
    for i in text[:offset][::-1]:
        if i == "\n":
            break
        column += 1
    match["line"] = line
    match["column"] = column

    # Show as warnings in coc-diagnostic
    if match["rule"]["issueType"] == "misspelling":
        match["level"] = "error"
    else:
        match["level"] = "warning"

print(json.dumps(matches))
