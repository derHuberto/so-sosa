#!/bin/bash

ollama serve &

sleep 5

ollama pull deepseek-r1:1.5b

service nginx start

wait


