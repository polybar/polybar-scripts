#!/bin/sh

# USAGE:
# No arguments: prints the job running/queued job count of the default tsp server
# Arguments: name,sock_name - one or more arguments, e.g. tsp yt,youtube p,podcasts
# sock_name is optional, will default to default tsp socket
# custom socket names will be generated as /tmp/ts-socket.SOCK_NAME, your TS_SOCKET will need to match

get_tsp_count() {
	sock=/tmp/socket-ts.${1:-$(id -u)}

	tsp_count=$(TS_SOCKET=$sock tsp|grep -E -c 'running|queued')
	echo "${tsp_count:-0}"
}

# without argument, just show count of default socket
if [ $# -lt 1 ]; then
	get_tsp_count
else
	for t in "$@"; do
		IFS=, read -r name sock_name <<- EOF
		${t}
		EOF

		echo "${name} $(get_tsp_count "${sock_name}")"
	done|sed 'N;s/\n/  /'
fi
