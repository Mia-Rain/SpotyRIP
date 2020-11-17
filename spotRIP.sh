#!/bin/sh
has() {
	case "$(command -v $1 2>/dev/null)" in
		alias*|"") return 1
	esac
}
usage(){
cat << 'EOF'
Spot(y)RIP ~ Spotify Playlist ripper using ytdl
~ Interacts with Spotbash ~ Also by: That(Geeky)Weeb (Mia)
***
Usage: spotRIP.sh [-h] [ -i <PLAYLIST_ID> ] <YTDL OPTIONS>
***
Warning! All Songs on Spotify are copyrighted, rip at your own risk!
EOF
# SpotyRIP is a proof of concept, using it voilates copyright!
}
depch(){
deps="spotbash youtube-dl jq paste"
for i in $deps; do
    if ! has $i; then
        case $i in
            spotbash)
                echo "$i is missing please install it from github.com/ThatGeekyWeeb/Spotbash" && exit 1;;
            youtube-dl)
                echo "$i is missing, please install it using 'pip install $i'" && exit 1;;
            jq)
                echo "$i is missing pleaes install it from github.com/stedolan/$i or your local PM" && exit 1;;
            paste)
                echo "$i is part of GNU coreutils, please install it; POSIX imps of '$i' may cause issues with SpotyRIP" && exit 1;;
        esac
    fi
done
}
rip() {
        while read p; do
            	youtube-dl $@ "$(youtube-dl -j ytsearch1:"$p" | jq .webpage_url -r)" -o '%(title)s.%(ext)s' --restrict-filenames # File names get 'weird' without this
        done <<< $(spotbash songs "$ID" | paste -d ' ' - - | sed "/${ID}/d" ) # This prevents errors with the ID being used
        ## $ID will still be moved with $@, these errors would take much work to fix, -FIXME-
}
main(){
        case $1 in
            -h)
                usage && exit 1
                ;;
            -i|--ID|--playlist)
                ID=$2
                shift 1
                ;;
            "")
               echo "";;
            *)
                usage && exit 1
                ;;
        esac
    shift 1
}
main "${@}"
rip "${@}"
if [ -f list ]; then
        rm ./list
fi
