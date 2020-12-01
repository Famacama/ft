FROM	debian:buster

LABEL	maintainer="famacama@student.s19.be"

COPY	srcs/nginx.conf ./
COPY	srcs/init.sh ./
COPY	srcs/start.sql ./
COPY	srcs/wp-config.php ./

CMD		bash init.sh && tail -f /dev/null 

