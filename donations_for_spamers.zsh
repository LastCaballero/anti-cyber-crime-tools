#! /bin/zsh

# your loved spamdomain :-)
url="http://xxxxxxxx.xxxxxxxx.org/"

# a public proxy server :-)
proxy="194.5.193.183"

function word () {
	count=$1
	letter=( {a..z} )
	repeat $count { 
		rand=$( shuf --input-range=1-26 -n 1 )
		back+=$letter[$rand]
	}
	print $back
}

function rnd_nb () {
	local range=$1
	shuf --input-range=$range -n 1
}

emails=( $( repeat 200 { print "$(word $(rnd_nb 3-7)).$(word $(rnd_nb 3-7))@$(word $(rnd_nb 3-7)).$(word $(rnd_nb 2-3))" } ) )

for em ( $emails ) {
	wget -e use_proxy=yes -e http_proxy=$proxy -O /dev/null --post-data="email=$em" $url	
}

print -c "Following emails donated :-) to spamdomain: " $emails
