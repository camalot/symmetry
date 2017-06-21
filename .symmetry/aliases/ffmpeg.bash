
if command -v avconv > /dev/null && ! command -v ffmpeg > /dev/null; then
	alias ffmpeg=avconv;
fi
