# Create a new directory and enter it
function md() {
	mkdir -p "$@" && cd "$@"
}

# Copy w/ progress
cp_p () {
  rsync -WavP --human-readable --progress $1 $2
}

# All the dig info
function digga() {
        dig +nocmd "$1" any +multiline +noall +answer
}

# Escape UTF-8 characters into their 3-byte format
function escape() {
        printf "\\\x%s" $(printf "$@" | xxd -p -c1 -u)
        echo # newline
}

# Decode \x{ABCD}-style Unicode escape sequences
function unidecode() {
        perl -e "binmode(STDOUT, ':utf8'); print \"$@\""
        echo # newline
}

function wikidi-pre() {
	dir=$(basename $(pwd))
	p=${dir##*.}
	git branch -f pre $1
	git push -f origin pre:pre
	ssh $p@$p.pre.brzy.cz
	echo "Chech results at: http://$p.pre.brzy.cz:8088/logviewer/view/200/tail/single/normal?log=%2Fvar%2Fwww%2F$p%2Flogs%2Fdeploy%2Ftests.log"
}

function wikidi-release() {
	d="release/"$(date +"%Y%m%d")
	r=$(($(git tag -l --sort "-v:refname" "$d*" | head -1 | sed -n "s@^$d\.@@p" || echo 0)+1))
	git tag -s -m "honza releasuje :)" $d.$r $1
	git push origin $d.$r
}

# animated gifs from any video
# from alex sexton   gist.github.com/SlexAxton/4989674
gifify() {
  if [[ -n "$1" ]]; then
    if [[ $2 == '--good' ]]; then
      ffmpeg -i $1 -r 10 -vcodec png out-static-%05d.png
      time convert -verbose +dither -layers Optimize -resize 600x600\> out-static*.png  GIF:- | gifsicle --colors 128 --delay=5 --loop --optimize=3 --multifile - > $1.gif
      rm out-static*.png
    else
      ffmpeg -i $1 -s 600x400 -pix_fmt rgb24 -r 10 -f gif - | gifsicle --optimize=3 --delay=3 > $1.gif
    fi
  else
    echo "proper usage: gifify <input_movie.mov>. You DO need to include extension."
  fi
}

dec2ip() {
    local ip dec=$@
    for e in {3..0}
    do
        ((octet = dec / (256 ** e) ))
        ((dec -= octet * 256 ** e))
        ip=$octet$delim$ip
        delim=.
    done
    printf '%s\n' "$ip"
}

