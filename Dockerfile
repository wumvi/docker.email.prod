FROM wumvi/nginx.prod
MAINTAINER Vitaliy Kozlenko <vk@wumvi.com>

ADD exim4.conf /root/
ADD cmd/  /

ENV LOG_FILES /var/log/exim4/mainlog /var/log/exim4/paniclog /var/log/exim4/rejectlog

RUN DEBIAN_FRONTEND=noninteractive && \
	mkdir -p /etc/exim4/dkim/ && \
	apt-get -qq update && \
	apt-get --no-install-recommends -qq -y install exim4-daemon-light libperl4-corelibs-perl procps && \
	#
	cat /root/exim4.conf /etc/exim4/exim4.conf.template > /tmp/config.txt && \
	mv /tmp/config.txt /etc/exim4/exim4.conf.template && \
    #
	mkdir -p /var/log/exim/ && \
	mkfifo --mode 0666 $LOG_FILES && \
	touch /var/mail/mail && \
	chown mail:mail /var/mail/mail && \
	chown Debian-exim:adm $LOG_FILES && \
	#
	chmod +x /*.sh && \
	#
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /soft/ && \
    #
	echo 'End'

ADD conf/ /etc/exim4/

EXPOSE 25

CMD [ "/start.sh" ]
