#!/bin/bash
# start.sh

ollama serve &

until ollama status >/dev/null 2>&1; do
    sleep 2
done

ollama pull deepseek-r1:1.5b

pkill ollama

tail -f /dev/null
