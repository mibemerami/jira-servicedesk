# Basic image
FROM centos

# General preparation
RUN 	yum update && \
 	adduser jirauser 

# Get the Jira binary
ADD 	./install-jira/ /root/install-jira/
RUN 	yum install -y wget
RUN 	cd /root/install-jira && \
	wget  https://www.atlassian.com/software/jira/downloads/binary/atlassian-servicedesk-3.2.4-x64.bin

# Install Jira
RUN 	cd /root/install-jira && \
	chmod 755 atlassian-servicedesk-3.2.4-x64.bin && \
	./atlassian-servicedesk-3.2.4-x64.bin -q -varfile response.varfile

# Do some clean up
RUN 	rm -rf /root/install-jira && \
 	yum clean all 

# Do some configuration
ADD 	docker-scripts/ /root/docker-scripts/
RUN 	chmod 777 /root/docker-scripts/docker-entrypoint.sh
VOLUME 	["/opt/atlassian/jira/", "/var/atlassian/application-data/jira/"]
EXPOSE 	8080
ENTRYPOINT ["/root/docker-scripts/docker-entrypoint.sh"]
CMD	["/bin/bash"]

