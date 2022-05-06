cmpv() {
    ytdlp_path=$(which yt-dlp)

    mpv --hwdec=vaapi --script-opts=ytdl_hook-ytdl_path="${ytdlp_path}" "$@"
}
