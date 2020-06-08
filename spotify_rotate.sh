function rotate_string(){
	DIST=$2
	INDEX=0
	while [[ true ]]; do
		sleep 1
		[ $(($DIST+$INDEX-1)) -ge ${#1} ] && TAIL=${1:0:$(($DIST-${#1}+$INDEX))}
		[[ -n $TAIL ]] && echo "${1:$INDEX:$DIST} $TAIL" || echo ${1:$INDEX:$DIST}
		INDEX=$((INDEX + 1))
		[ $INDEX -ge ${#1} ] && INDEX=0
		unset TAIL
	done
}

function spot(){
	meta_data=$(
		dbus-send \
			--print-reply \
			--dest=org.mpris.MediaPlayer2.spotify \
			/org/mpris/MediaPlayer2 \
			org.freedesktop.DBus.Properties.Get \
			string:org.mpris.MediaPlayer2.Player \
			string:Metadata)
	song=$(
			echo $meta_data \
		| sed -n '/title/{n;p}' \
		| cut -d '"' -f 2)
	artist=$(
			echo $meta_data \
		| sed -n '/artist/{n;n;p}' \
		| cut -d '"' -f 2)
	rotate_string "$song - $artist" $1
}

