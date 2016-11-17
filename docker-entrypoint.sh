#! /bin/bash

#Write things to do on start up here
echo 'docker-entrypoint.sh in the Jira container has been started.';

#Start actual process
exec /opt/atlassian/jira/bin/start-jira.sh -fg jirauser

#Run the parameters passed
exec "$@"
