FROM ruby:2.4

MAINTAINER Vitaliy Kozlenko <vk@wumvi.com>

LABEL version="1.0.0"

WORKDIR /opt/postal/

RUN DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get --no-install-recommends -qq -y install nodejs mysql-client git -y && \
	gem install bundler && gem install procodile && \
	useradd -r -d /opt/postal -s /bin/bash postal && \

	git clone https://github.com/atech/postal /opt/postal && \
	chown -R postal:postal /opt/postal/ && \
	/opt/postal/bin/postal bundle /opt/postal/vendor/bundle && \
	mv /opt/postal/config /opt/postal/config-original && \

	apt-get autoremove -y && \
	rm -rf /var/lib/apt/lists/* && \
	echo 'end'


ADD scripts/start.sh /start.sh
EXPOSE 5000

CMD ["/start.sh"]