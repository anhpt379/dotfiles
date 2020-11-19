#!/usr/bin/env python3

import os
import sys
import json
import requests

language = "en-US"
text = sys.stdin.read()

# IDs of rules to be disabled, comma-separated
disabled_rules = (
    "COMMA_PARENTHESIS_WHITESPACE," "DASH_RULE," "EN_QUOTES," "LC_AFTER_PERIOD",
    "WORD_CONTAINS_UNDERSCORE,",
)

r = requests.post(
    "https://languagetool.org/api/v2/check",
    data={"text": text, "language": language, "disabledRules": disabled_rules},
)
r.raise_for_status()

pwl_path = os.path.dirname(__file__) + "/../dictionaries/personal_word_list.txt"
personal_word_list = open(pwl_path).read().splitlines()

matches = r.json().get("matches", [])
output = []
for match in matches:
    offset = match["offset"]
    length = match["length"]
    type = match["rule"]["issueType"]
    word = text[offset : offset + length]
    if type == "misspelling" and word in personal_word_list:
        continue

    rule_id = match["rule"]["id"]
    replacements = " / ".join([i["value"] for i in match["replacements"]])
    if replacements:
        match[
            "message"
        ] = f"{rule_id}\n{match['message']}\n\nSuggestion: \"{word}\" -> {replacements}"

    # Convert from offset to line/column
    line = text[:offset].count("\n") + 1  # line number starts from 1
    column = 1
    for i in text[:offset][::-1]:
        if i == "\n":
            break
        column += 1
    match["line"] = line
    match["column"] = column

    match["level"] = "hint"
    output.append(match)

print(json.dumps(output))
