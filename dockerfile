FROM debian:12

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt upgrade -y && \
    apt install -y curl nginx python3 python3-pip && \
    apt clean

RUN mkdir -p /usr/share/nginx/html

COPY index.html /usr/share/nginx/html/index.html

RUN curl -fsSL https://ollama.com/install.sh | sh

EXPOSE 80

COPY start.sh /start.sh
RUN chmod +x /start.sh

CMD ["/start.sh"]
