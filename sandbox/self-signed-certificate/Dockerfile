FROM nginx:latest

COPY nginx.conf /etc/nginx/nginx.conf
COPY index.html /srv/www/weekendsprints.local/index.html
COPY cert.pem /etc/ssl/certs/cert.pem
COPY cert.key /etc/ssl/private/cert.key
COPY ssl_passwords.txt /etc/ssl/private/ssl_passwords.txt
COPY rootCA.pem /usr/local/share/ca-certificates/rootCA.crt