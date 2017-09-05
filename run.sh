#!/bin/bash

ARRAY=(
    "phalcon:cphalcon"
    "phalcon:zephir"
    "phalcon:phalcon-devtools"
    "phalcon:incubator"
    "phalcon:docs-app"
)

touch combined.txt

for item in "${ARRAY[@]}" ; do
  ORG=${item%%:*}
  REPO=${item#*:}
  URL="https://github.com/$ORG/$REPO"
  git clone $URL
  cd $REPO && git fetch --all && git rebase && cd ..
  gource --output-custom-log ./output.txt ./$REPO
  sed -i -r "s#\(.*\)\|#\1|/$ORG/$REPO#" ./output.txt
  cat combined.txt output.txt > temp.txt && cat temp.txt > combined.txt
  rm -f temp.txt output.txt
done

cat combined.txt | sort -n > output.txt
rm -f combined.txt

gource \
  -1920x1080 \
  --stop-at-end \
  --multi-sampling \
  --highlight-users \
  --highlight-dirs \
  --auto-skip-seconds 1 \
  --file-filter \.png \
  --dir-colour 8b91a2 \
  --highlight-colour ffffff \
  --key \
  --bloom-multiplier 0.2 \
  --bloom-intensity 0.5 \
  --hide mouse,filenames \
  --seconds-per-day .01 \
  --dir-name-depth 1 \
  -r 25 \
  -o - output.txt | \
  avconv -y -r 25 -f image2pipe -vcodec ppm -i - -b 65536K phalcon-output-with-dirs.mp4
