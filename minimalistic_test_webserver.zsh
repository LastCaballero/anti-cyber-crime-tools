#! /bin/zsh

response='HTTP/1.1 200 OK
Content-Length: 22

thank your very much!
'

while ( true ) {
	cat <<< $response | netcat -l 4000 | tee -a server_log.txt
}

