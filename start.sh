#!/bin/bash
# start.sh

ollama serve &

ollama pull deepseek-r1:1.5b

pkill ollama

tail -f /dev/null
