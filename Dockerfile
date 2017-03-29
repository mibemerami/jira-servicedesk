# Basic image
FROM centos:7

# Configuration variables
ENV JIRA_SERVICEDESK_VERSION 	3.2.4
ENV JIRA_INSTALL		/opt/atlassian
ENV JIRA_HOME			/var/atlassian/application-data/jira/

# Add configuration files and scripts
ADD 	install-jira/ /root/install-jira/
ADD 	docker-scripts/ /root/docker-scripts/

# Run commands
	# General preparation
RUN 	yum update -y && \
 	adduser jirauser && \
	yum install -y python-setuptools && \
	easy_install supervisor && \
	# Get the Jira binary
 	yum install -y wget && \
 	cd /root/install-jira && \
	wget  "https://www.atlassian.com/software/jira/downloads/binary/atlassian-servicedesk-${JIRA_SERVICEDESK_VERSION}-x64.bin" && \
	# Install Jira
 	cd /root/install-jira && \
	chmod 755 atlassian-servicedesk-${JIRA_SERVICEDESK_VERSION}-x64.bin && \
	./atlassian-servicedesk-${JIRA_SERVICEDESK_VERSION}-x64.bin -q -varfile response.varfile && \
	# Do configuration
 	chmod 777 /root/docker-scripts/docker-entrypoint.sh && \
	chown -R jira:jira $JIRA_INSTALL && \
	chown -R jira:jira $JIRA_HOME && \
	# Do some clean up
 	rm -rf /root/install-jira && \
 	yum clean all -y

# Do some configuration
COPY	conf.d/supervisord.conf /etc/supervisord.conf
VOLUME 	["$JIRA_INSTALL", "$JIRA_HOME"]
EXPOSE 	8080
ENTRYPOINT ["/root/docker-scripts/docker-entrypoint.sh"]
CMD	["/bin/bash"]

