#!/bin/bash

service nginx start

ollama serve
ollama pull deepseek-r1:1.5b && ollama run deepseek-r1:1.5b


