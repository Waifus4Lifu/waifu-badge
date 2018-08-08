#!/bin/bash
cd /badge/images
for path in /badge/images/*.*
do
    filename=$( basename "$path" )
    echo converting "$filename"
    filename=${filename%.*}
    ffmpeg -loop 1 -t 1 -i "$path" -c:v libx264 -vf "scale=640:-2" -pix_fmt yuv420p "/badge/slideshow/$filename.mp4"
    rm $path
done

