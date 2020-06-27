function rotate_string(){
		INDEX=$2
		DIST=$3
		[ $(($DIST+$INDEX-1)) -ge ${#1} ] && TAIL=${1:0:$(($DIST-${#1}+$INDEX))}
		[[ -n $TAIL ]] && echo "${1:$INDEX:$DIST}$TAIL" || echo "${1:$INDEX:$DIST}"
}

DIST=${DISTANCE:=20}
INTERVAL=${INTERVAL:=1}
INDEX=0
while true; do
	if meta_data=$(
		dbus-send \
			--print-reply \
			--dest=org.mpris.MediaPlayer2.spotify \
			/org/mpris/MediaPlayer2 \
			org.freedesktop.DBus.Properties.Get \
			string:org.mpris.MediaPlayer2.Player \
			string:Metadata 2> /dev/null); then
		song=$(
				echo "$meta_data" \
			| sed -n '/title/{n;p}' \
			| cut -d '"' -f 2)
		artist=$(
				echo "$meta_data" \
			| sed -n '/artist/{n;n;p}' \
			| cut -d '"' -f 2)
		[ -n "$song" -a -n "$artist" ] && string="$song - $artist - "  || string=""

		echo "$(rotate_string "$string" $INDEX $DIST)"

		INDEX=$((INDEX + 1))
		[ $INDEX -ge ${#string} ] && INDEX=0
	fi

	sleep $INTERVAL &
	wait
done
