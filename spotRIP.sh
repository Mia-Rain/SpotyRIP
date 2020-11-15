#!/bin/sh
has() {
	case "$(command -v $1 2>/dev/null)" in
		alias*|"") return 1
	esac
}
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

