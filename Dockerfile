FROM debian:bullseye

EXPOSE 80

#Install dependencies
RUN apt-get update -y && \
    apt-get install -y nginx systemd curl gnupg apt-transport-https

#Setup nginx for whatever the F it wants
RUN chown -R www-data:www-data /var/www/html
RUN chmod 777 /var/www/html
COPY ./index.html /var/www/html/
COPY ./configs/nginx.conf /etc/nginx/nginx.conf
COPY ./configs/default /etc/nginx/sites-available/default
RUN echo "PrivateNetwork=yes" >> /lib/systemd/system/nginx.service

#Stupid gpg key for the stupid tor server and put them in apt list to install the tor
RUN echo "deb [signed-by=/usr/share/keyrings/tor-archive-keyring.gpg] https://deb.torproject.org/torproject.org bullseye main" >> /etc/apt/sources.list && \
    echo "deb-src [signed-by=/usr/share/keyrings/tor-archive-keyring.gpg] https://deb.torproject.org/torproject.org bullseye main" >> /etc/apt/sources.list

RUN curl https://deb.torproject.org/torproject.org/A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89.asc | \
    gpg --dearmor -o /usr/share/keyrings/tor-archive-keyring.gpg
RUN apt-get update -y && \
    apt-get install -y tor deb.torproject.org-keyring && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

#Configure the tor because he is a cry-baby with really strict needs
COPY ./configs/torrc /etc/tor/torrc
RUN chown -R debian-tor:debian-tor /var/lib/tor
RUN mkdir -p /var/lib/tor/hidden_service
RUN chown -R debian-tor:debian-tor /var/lib/tor/hidden_service/
RUN chmod 700 /var/lib/tor/hidden_service

#script ofc
COPY ./run.sh .
RUN chmod 777 run.sh

CMD ["./run.sh"]

# docker build -t tor .
# docker run -p 80:80 tor
