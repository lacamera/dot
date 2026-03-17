{ ... }:
{
  xdg.configFile."mpv/mpv.conf".text = ''
    blend-subtitles=no
    sub-ass-scale-with-window=no
    sub-auto=fuzzy
    demuxer-mkv-subtitle-preroll=yes
    embeddedfonts=yes
    sub-fix-timing=no

    ao=coreaudio
    audio-stream-silence
    audio-file-auto=fuzzy
    audio-pitch-correction=yes

    alang=eng,en,enUS,en-US,de,ger
    slang=eng,en,de,ger

    profile=high-quality
    vo=gpu-next
    gpu-context=macvk
    macos-force-dedicated-gpu=yes
  '';
}
