FROM debian:12
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y curl python3 python3-pip && apt clean

RUN curl -fsSL https://ollama.com/install.sh | sh

COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 11434

CMD ["/start.sh"]
