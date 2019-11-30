#!/bin/bash

# auto compile on file changed
echo "Start auto-compile" &
python ./scripts/autoreload.py python ./scripts/compiler.py &
echo "Start browser auto-refresh" &
# browser refresh on file changed
python ./scripts/refreshbrowser.py
