FROM debian:stable-slim

RUN set -eux; apt-get update; apt-get install -y --no-install-recommends python3 python3-pip pipx postgresql-client

RUN pipx install awscli

RUN pipx ensurepath

COPY backup_script.sh /root

CMD ["/root/backup_script.sh"]
