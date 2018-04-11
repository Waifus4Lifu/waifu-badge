#!/bin/bash
# Shamelessly stolen and modified from apaul on StackExchange:
# https://unix.stackexchange.com/a/192021

FILE=$1
OUT=$2
TMP="/tmp/$$_tmp.mp4"

if [ $# -eq 0 ] || [ -z "$1" ] || [ -z "$2" ]
then
  echo "$0 input_file output_file"
  exit 1
fi

if [ ! -e "$FILE" ]
then
  echo "Input file does not exist"
  exit 1
fi

OUT_WIDTH=640
OUT_HEIGHT=480

# Get the size of input video:
eval $(ffprobe -v error -of flat=s=_ -select_streams v:0 -show_entries stream=height,width ${FILE})
IN_WIDTH=${streams_stream_0_width}
IN_HEIGHT=${streams_stream_0_height}

# Get the difference between actual and desired size
W_DIFF=$[ ${OUT_WIDTH} - ${IN_WIDTH} ]
H_DIFF=$[ ${OUT_HEIGHT} - ${IN_HEIGHT} ]

# Let's take the shorter side, so the video will be at least as big
# as the desired size:
CROP_SIDE="n"
if [ ${W_DIFF} -lt ${H_DIFF} ] ; then
  SCALE="-2:${OUT_HEIGHT}"
  CROP_SIDE="w"
else
  SCALE="${OUT_WIDTH}:-2"
  CROP_SIDE="h"
fi

# Then perform a first resizing
ffmpeg -i ${FILE} -movflags faststart -pix_fmt yuv420p -vf scale=${SCALE} ${TMP}

# Now get the temporary video size
eval $(ffprobe -v error -of flat=s=_ -select_streams v:0 -show_entries stream=height,width ${TMP})
IN_WIDTH=${streams_stream_0_width}
IN_HEIGHT=${streams_stream_0_height}

# Calculate how much we should crop
if [ "z${CROP_SIDE}" = "zh" ] ; then
  DIFF=$[ ${IN_HEIGHT} - ${OUT_HEIGHT} ]
  CROP="in_w:in_h-${DIFF}"
elif [ "z${CROP_SIDE}" = "zw" ] ; then
  DIFF=$[ ${IN_WIDTH} - ${OUT_WIDTH} ]
  CROP="in_w-${DIFF}:in_h"
fi

# Then crop...
ffmpeg -i ${TMP} -movflags faststart -pix_fmt yuv420p -filter:v "crop=${CROP}" ${OUT}
# Remove tmp file
rm ${TMP}
