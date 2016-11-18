#!/bin/bash

#Write things to do on start up here
echo 'docker-entrypoint.sh in the Jira container has been started.';
HELP_TEXT="To set the RAM size for the JVM, type:
--min-memory <RAM-in-MB> --max-memory <RAM-in-MB>
other arguments are currently notsupported."
base_command="python change_JVM_in_Jira_bin_setenv_sh.py"
opt1=""
opt2=""
to_run=""
while [ $# -gt 0 ]
do
        if [ $1 == "--min-memory" ]
                then
                        shift
                        opt1="--min-memory ${1}"
                elif [ $1 == "--max-memory" ]
                then
                        shift
                        opt2="--max-memory ${1}"
                else
                        exec echo "$HELP_TEXT"
        fi
        shift
done

to_run="${base_command} ${opt1} ${opt2}"
exec $to_run

#Start actual process
exec /opt/atlassian/jira/bin/start-jira.sh -fg jirauser

#Run the parameters passed
exec "$@"
