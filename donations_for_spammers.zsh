#! /bin/zsh

# your loved spamdomain :-)
url="http://xxxxxxxx.xxxxxxxx.org/"

# a public proxy server :-)
proxy="xxx.xxx.xxx.xxx"

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

emails=( $( repeat 200 { print "$(word $(rnd_nb 3-7)).$(word $(rnd_nb 3-7))@$(word $(rnd_nb 3-7)).$(word $(rnd_nb 2-3))" } ) )

function send_gifts () {
	for em ( $emails ) {
		wget -e use_proxy=yes -e http_proxy=$proxy -O /dev/null --post-data="email=$em" $url	
	}
	print -c "Following emails donated :-) to spamdomain: " $emails
}

send_gifts
