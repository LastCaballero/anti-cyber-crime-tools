#! /bin/zsh

# your loved scamdomain :-)
url="http://idiotserver.abc.org"

# a public proxy server :-)
proxy="xxx.xxx.xxx.xxx"
[[ $url = *local* ]] && proxy_yes_or_no="no" ||
proxy_yes_or_no="yes"

function produce_password () {
	local letters=( {a..z} {A..Z} \! \# \? )
	local password
	repeat 13 {
		rand=$( shuf --input-range=1-${#letters} -n 1 )
		password+=$letters[$rand]
	}
	print $password
}


function word () {
	local count=$1
	local letter=( {a..z} )
	repeat $count { 
		rand=$( shuf --input-range=1-${#letter} -n 1 )
		back+=$letter[$rand]
	}
	print $back
}

function rnd_nb () {
	local range=$1
	shuf --input-range=$range -n 1
}

typeset -A pairs=( $( repeat 200 { print "$(word $(rnd_nb 3-7)).$(word $(rnd_nb 3-7))@$(word $(rnd_nb 3-7)).$(word $(rnd_nb 2-3))" "$(produce_password)" } ) )

function send_gifts () {
	for key value ( ${(kv)pairs} ) {
		wget -e use_proxy=$proxy_yes_or_no -e http_proxy=$proxy -O /dev/null --post-data="email=$key&password=$value" $url	
	}
	print "Following emails and passwords donated :-) to scamdomain:"
	print -c ${(kv)pairs}
}

send_gifts
