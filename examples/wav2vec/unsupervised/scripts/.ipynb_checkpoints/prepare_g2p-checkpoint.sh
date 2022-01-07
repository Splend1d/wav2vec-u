#!/usr/bin/env zsh
# Copyright (c) Facebook, Inc. and its affiliates.
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.

lg='en'

ph_lg=${lg:l}
if test "$lg" = 'fr'; then
  ph_lg='fr-fr'
elif test "$lg" = 'en'; then
  ph_lg='en-us'
elif test "$lg" = 'pt'; then
  ph_lg='pt-br'
fi

phonemizer='espeak-ng'
target_dir='/home/splend1dchan/data/wiki'

ESPEAK_PATH=''
if test "$phonemizer" = 'espeak'; then
  ESPEAK_PATH=$(which espeak)
elif test "$phonemizer" = 'espeak-ng'; then
  ESPEAK_PATH=$(which espeak-ng)
elif test "$phonemizer" = 'G2P'; then
  ESPEAK_PATH=''
else
  echo "Unknown phonemizer $phonemizer. Valid options are espeak, espean-ng and G2P"
  exit 1
fi







one=$(echo "1" | PHONEMIZER_ESPEAK_PATH=$ESPEAK_PATH phonemize -p ' ' -w '' -l $ph_lg --language-switch remove-flags)
sed 's/$/ 1/' $target_dir/words_remove_underthres.txt | PHONEMIZER_ESPEAK_PATH=$ESPEAK_PATH phonemize -o $target_dir/phones.txt -p ' ' -w '' -l $ph_lg -j 8 --language-switch remove-flags
echo "one is ${one}"
sed -i "s/${one}$//" $target_dir/phones.txt

paste $target_dir/words.txt $target_dir/phones.txt >! $target_dir/lexicon.lst












