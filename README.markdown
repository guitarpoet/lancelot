Lacenlot, a script to launch and management multiple processes
================================================================================

Introduction & Purpose
--------------------------------------------------------------------------------

The purpose for lancelot is to help to launch and mange the worker processes for
my working project.

Lancelot is used to solve the problem I encountered in my project:

1. I need to launch many worker processes as daemon process on many slave \
	machines (say, 5 worker for each slave machine)
2. After some configuration change, I need to restart all the worker processes \
	(sure, you can use apache zookeeper to handle this, but it will make the \
	worker process more complex, since the worker process just need to do some \
	very simple work (get the data from an url and store it into hdfs for example)
3. I need to check for all the worker process's status at a period of time \
	(or maybe I want to get an alert when 50% of the processes is down)

So, lancelot is used for:

1. Launching as many worker processes as you want, and save the pid files as the \
	template you have gave it (something like /var/run/worker-1.pid), and the \
	redirect the standard output, error output to the templates you have gave it \
	(somthing like /var/log/worker-1.log /var/log/worker-1.err)
2. Launching the worker processes as daemon using nohup or daemonize, lancelot \
	prefer daemonize than nohup, anyway, the worker process won't exit until it \
	gets an error or itself should exit
3. Check the status of all the worker process you have launched, using a ps \ 
	format, you can also set the ps format, you can use grep pattern or pid \
	template to check for the status
4. Kill all the processes you want to kill by using a pid template or the pattern

And, for the ease to deploy lancelot to multiple slave machines, lancelot also has
a deploy function to deploy it to all the machines, this function is depend on 
another script tool called [taktuk](http://taktuk.gforge.inria.fr).

Installation
--------------------------------------------------------------------------------

For the installation, just unpack the package and copy lancelot to the destination
you want to put it to(/usr/local/lancelot for default).

And change the lancelot home variable in the lancelot script. Then add or ln lancelot
script to the PATH (usually /usr/local/bin/lancelot)

And you can use it.

Usage
--------------------------------------------------------------------------------

You can use lancelot script like this

`Lancelot command options`

For example:
`lancelot launch -c ~/launch_config -t 10 /bin/sh fetch_data.sh`

Lancelot Launch
--------------------------------------------------------------------------------

	Description:     
		The process launching script.    
		Example:    launch -o /tmp/a-{}.log -e /tmp/a-{}.err -w /tmp /bin/ls .
		Email to guitarpoet@gmail.com if bug found.
	Options:     
		-w|--workingdir:        The working dir for the launch
			This option requires 1 args.
		-o|--output:
			The standard output of the application
			This option requires 1 args.
		-e|--error:
			The error output of the appliaction
			This option requires 1 args.
		-p|--pid:
			The pid template for the application
			This option requires 1 args.
			Option is required.
		-c|--config:
			The configuration file location for lancelot launch
			This option requires 1 args.
		-t|--count:
			The process count that want lancelot to launch
			This option requires 1 args.

Lancelot Status
--------------------------------------------------------------------------------

	Description: 
		The process status script.
		Example:
		status -p /tmp/a-{}.pid
		Email to guitarpoet@gmail.com if bugs found.
	Options: 
		-p|--pid:
			The pid template for the application
			This option requires 1 args.
			Option is required.
		-a|--application:
			The application pattern to grep
			This option requires 1 args.
		-c|--config:
			The configuration file location for lancelot launch
			This option requires 1 args.
		-f|--format:
			The ps format for this application, 'pid args' is by default
			This option requires 1 args.

Lancelot Kill
--------------------------------------------------------------------------------

	Description: 
		The process kill script.
		Example:
		kill -p /tmp/a-{}.pid
		Email to guitarpoet@gmail.com if bugs found.
	Options: 
		-p|--pid:
			The pid template for the application
			This option requires 1 args.
			Option is required.
		-a|--application:
			The application pattern to grep
			This option requires 1 args.
		-c|--config:
			The configuration file location for lancelot launch
			This option requires 1 args.

Lancelot Broadcast
--------------------------------------------------------------------------------

	Description: 
		Broadcast exec the lancelot command to all the hosts
		Example:
		broadcast -h ~/hosts status -p /tmp/a-{}.pid
		Email to guitarpoet@gmail.com if bugs found.
	Options: 
		-c|--config:
			The configuration file location for lancelot broadcast
			This option requires 1 args.
		-h|--hosts:
			The hosts that should launch the lancelot broadcast
			This option requires 1 args.
		-l|--login:
			The login name for login using taktuk
			This option requires 1 args.

