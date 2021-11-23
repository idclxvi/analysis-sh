#!/bin/sh

##
## Easiest way with shell, using jq https://stedolan.github.io/jq/
##

if [ $# -ne 1 ]; then
    echo "Usage: $0 json.bz2"
    exit
fi

echo "Count   Model"
# cat $1 | jq -cMr '.[].model' | sort | uniq -c | tee /tmp/$$.analysis.sh
bzcat $1 | jq -M --stream 'fromstream(1|truncate_stream(inputs)) | .model' -r | sort | uniq -c | tee /tmp/$$.analysis.sh
echo "Models: $(wc -l /tmp/$$.analysis.sh | cut -d/ -f1)"
rm /tmp/$$.analysis.sh

##
## time ./analysis.sh bigf.json.bz2 > analysis.output
## ./analysis.sh bigf.json.bz2 14437.82s user 184.33s system 106% cpu 3:48:07.62 total >analysis.output
