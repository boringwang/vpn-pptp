FROM ubuntu:latest
MAINTAINER hiproz <hiproz@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y ppp pptp-setup pptpd iptables

COPY ./etc/pptpd.conf /etc/pptpd.conf
COPY ./etc/ppp/pptpd-options /etc/ppp/pptpd-options

COPY entrypoint.sh /entrypoint.sh
RUN chmod 0700 /entrypoint.sh

RUN modprobe ip_nat_pptp

ENTRYPOINT ["/entrypoint.sh"]
CMD ["pptpd", "--fg"]
