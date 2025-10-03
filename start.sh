ollama serve &

# Esperar a que arranque
until ollama status >/dev/null 2>&1; do
    echo "⏳ Esperando que Ollama arranque..."
    sleep 2
done

# Descargar modelo distillado 1.5B
ollama pull deepseek-r1:1.5b

# Iniciar Nginx
service nginx start

# Mantener contenedor vivo
wait
