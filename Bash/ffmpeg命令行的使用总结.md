```bash
Hyper fast Audio and Video encoder
usage: ffmpeg [options] [[infile options] -i infile]... {[outfile options] outfile}...

Getting help:
    -h      -- print basic options
    -h long -- print more options
    -h full -- print all options (including all format and codec specific options, very long)
    -h type=name -- print all options for the named decoder/encoder/demuxer/muxer/filter/bsf/protocol
    See man ffmpeg for detailed description of the options.

Print help / information / capabilities:
-L                  show license
-h topic            show help
-? topic            show help
-help topic         show help
--help topic        show help
-version            show version
-buildconf          show build configuration
-formats            show available formats
-muxers             show available muxers
-demuxers           show available demuxers
-devices            show available devices
-codecs             show available codecs
-decoders           show available decoders
-encoders           show available encoders
-bsfs               show available bit stream filters
-protocols          show available protocols
-filters            show available filters
-pix_fmts           show available pixel formats
-layouts            show standard channel layouts
-sample_fmts        show available audio sample formats
-dispositions       show available stream dispositions
-colors             show available color names
-sources device     list sources of the input device
-sinks device       list sinks of the output device
-hwaccels           show available HW acceleration methods

Global options (affect whole program instead of just one file):
-loglevel loglevel  set logging level
-v loglevel         set logging level
-report             generate a report
-max_alloc bytes    set maximum size of a single allocated block
-y                  overwrite output files
-n                  never overwrite output files
-ignore_unknown     Ignore unknown stream types
-filter_threads     number of non-complex filter threads
-filter_complex_threads  number of threads for -filter_complex
-stats              print progress report during encoding
-max_error_rate maximum error rate  ratio of decoding errors (0.0: no errors, 1.0: 100% errors) above which ffmpeg returns an error instead of success.
-vol volume         change audio volume (256=normal)

Per-file main options:
-f fmt              force format
-c codec            codec name
-codec codec        codec name
-pre preset         preset name
-map_metadata outfile[,metadata]:infile[,metadata]  set metadata information of outfile from infile
-t duration         record or transcode "duration" seconds of audio/video
-to time_stop       record or transcode stop time
-fs limit_size      set the limit file size in bytes
-ss time_off        set the start time offset
-sseof time_off     set the start time offset relative to EOF
-seek_timestamp     enable/disable seeking by timestamp with -ss
-timestamp time     set the recording timestamp ('now' to set the current time)
-metadata string=string  add metadata
-program title=string:st=number...  add program with specified streams
-target type        specify target file type ("vcd", "svcd", "dvd", "dv" or "dv50" with optional prefixes "pal-", "ntsc-" or "film-")
-apad               audio pad
-frames number      set the number of frames to output
-filter filter_graph  set stream filtergraph
-filter_script filename  read stream filtergraph description from a file
-reinit_filter      reinit filtergraph on input parameter changes
-discard            discard
-disposition        disposition

Video options:
-vframes number     set the number of video frames to output
-r rate             set frame rate (Hz value, fraction or abbreviation)
-fpsmax rate        set max frame rate (Hz value, fraction or abbreviation)
-s size             set frame size (WxH or abbreviation)
-aspect aspect      set aspect ratio (4:3, 16:9 or 1.3333, 1.7777)
-vn                 disable video
-vcodec codec       force video codec ('copy' to copy stream)
-timecode hh:mm:ss[:;.]ff  set initial TimeCode value.
-pass n             select the pass number (1 to 3)
-vf filter_graph    set video filters
-ab bitrate         audio bitrate (please use -b:a)
-b bitrate          video bitrate (please use -b:v)
-dn                 disable data

Audio options:
-aframes number     set the number of audio frames to output
-aq quality         set audio quality (codec-specific)
-ar rate            set audio sampling rate (in Hz)
-ac channels        set number of audio channels
-an                 disable audio
-acodec codec       force audio codec ('copy' to copy stream)
-vol volume         change audio volume (256=normal)
-af filter_graph    set audio filters

Subtitle options:
-s size             set frame size (WxH or abbreviation)
-sn                 disable subtitle
-scodec codec       force subtitle codec ('copy' to copy stream)
-stag fourcc/tag    force subtitle tag/fourcc
-fix_sub_duration   fix subtitles duration
-canvas_size size   set canvas size (WxH or abbreviation)
-spre preset        set the subtitle options to the indicated preset


```





可以使用以下命令行获取flv文件每一帧的时间戳信息并输出到文本文件：

```bash
ffmpeg -i 1.flv -vf "showinfo" -f null - 2>&1 | grep pts_time > output.txt
```

其中，`-i input.flv`指定输入文件，`-vf "select=gt(scene\,0.4),showinfo"`表示使用`select`和`showinfo`过滤器，`select=gt(scene\,0.4)`表示检测场景变化，`showinfo`表示输出每一帧的时间戳信息。`-f null`表示不输出任何实际的视频数据，只输出时间戳信息。`2> output.txt`表示将标准错误输出到文本文件`output.txt`中。

运行命令后，输出的文本文件中会包含每一帧的时间戳信息，例如：

```
[Parsed_showinfo_1 @ 0x7f8d7b61c400] n:   0 pts:     0 pts_time:0       pos:       0 fmt:yuv420p sar:0/1 s:320x240 i:P iskey:1 type:I checksum:5C9D9A42 plane_checksum:[5C9D9A42 5C9D9A42 5C9D9A42] mean:[103 128 128] stdev:[26.6 1.6 1.6]
[Parsed_showinfo_1 @ 0x7f8d7b61c400] n:   1 pts:  1024 pts_time:0.0426677 pos:   25708 fmt:yuv420p sar:0/1 s:320x240 i:P iskey:0 type:P checksum:AE0D0A5E plane_checksum:[AE0D0A5E 5C9D9A42 5C9D9A42] mean:[103 128 128] stdev:[26.6 1.6 1.6]
[Parsed_showinfo_1 @ 0x7f8d7b61c400] n:   2 pts:  2048 pts_time:0.0853353 pos:   51268 fmt:yuv420p sar:0/1 s:320x240 i:P iskey:0 type:P checksum:AF0D0A5E plane_checksum:[AF0D0A5E 5C9D9A42 5C9D9A42] mean:[103 128 128] stdev:[26.6 1.6 1.6]
...
```

其中，`pts_time`表示时间戳，单位为秒。



Mov 转 mp4 

11.4MB => 697KB

```bash
ffmpeg -i  hotfix-demo.mov -vcodec libx264 -s 960x540 -preset fast -crf 22 -y -acodec copy new.mp4
```



