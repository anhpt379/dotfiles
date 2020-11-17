#!/usr/bin/env python3

import os
import sys
import json
import tempfile
import subprocess

text = sys.stdin.read()
fd, path = tempfile.mkstemp()
try:
    with os.fdopen(fd, "w") as tmp:
        # do stuff with temp file
        tmp.write(text)
    command = f"vale --output=JSON --no-exit {path}"
    status, output = subprocess.getstatusoutput(command)
    if status != 0:
        sys.exit(1)
    data = json.loads(output)

    errors = []
    for match in data[path]:
        error = {
            "line": match["Line"],
            "column": match["Span"][0],
            "message": match["Message"] + "\n" + match["Link"],
            "level": "suggestion",
        }
        errors.append(error)

    print(json.dumps(errors))
finally:
    os.remove(path)
