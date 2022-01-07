# +
# create a manifest file for the set original of audio files
export GAN_SPEECH_DATA=data/TED/TEDLIUM_release-3/wav_line/train

#data/LibriSpeech/train-960

export LIBRI_ROOT=~/$GAN_SPEECH_DATA
export SAVE_ROOT=workspace/$GAN_SPEECH_DATA
#ls $LIBRI_ROOT
#python $FAIRSEQ_ROOT/examples/wav2vec/wav2vec_manifest.py $LIBRI_ROOT --ext wav --dest $SAVE_ROOT/raw  --valid-percent 0
echo "save train done"
#python scripts/vads.py -r $RVAD_ROOT < $SAVE_ROOT/raw/train.tsv > $SAVE_ROOT/raw/train.vads
python divide_and_conquer_data.py workspace/$GAN_SPEECH_DATA/raw
for i in {0..100};
do
    echo "splt ${i}"
    python scripts/vads_multiprocess.py -r $RVAD_ROOT --ori_file $SAVE_ROOT/raw/train.tsv.${i} --vad_file $SAVE_ROOT/raw/train.vads.${i};
done;
python divide_and_conquer_data.py workspace/$GAN_SPEECH_DATA/raw
# -

python scripts/remove_silence.py --tsv $SAVE_ROOT/raw/train.tsv --vads $SAVE_ROOT/raw/train.vads --out $LIBRI_ROOT-no_silence

python $FAIRSEQ_ROOT/examples/wav2vec/wav2vec_manifest.py $LIBRI_ROOT-no_silence --ext wav --dest $SAVE_ROOT/no_silence --valid-percent 0

# +
export GAN_SPEECH_DATA=data/TED/TEDLIUM_release-3/wav_line/dev
export LIBRI_ROOT=~/$GAN_SPEECH_DATA
export SAVE_ROOT=workspace/$GAN_SPEECH_DATA
# #ls $LIBRI_ROOT
# python $FAIRSEQ_ROOT/examples/wav2vec/wav2vec_manifest.py $LIBRI_ROOT --ext wav --dest $SAVE_ROOT/raw  --valid-percent 0
# echo "save dev done"

# python scripts/vads_multiprocess.py -r $RVAD_ROOT --ori_file $SAVE_ROOT/raw/train.tsv --vad_file $SAVE_ROOT/raw/train.vads;

# python scripts/remove_silence.py --tsv $SAVE_ROOT/raw/train.tsv --vads $SAVE_ROOT/raw/train.vads --out $LIBRI_ROOT-no_silence
# python $FAIRSEQ_ROOT/examples/wav2vec/wav2vec_manifest.py $LIBRI_ROOT-no_silence --ext wav --dest $SAVE_ROOT/no_silence --valid-percent 1
# rm $SAVE_ROOT/no_silence/train.tsv


# +
export GAN_SPEECH_DATA=data/TED/TEDLIUM_release-3/wav_line/test
export LIBRI_ROOT=~/$GAN_SPEECH_DATA
export SAVE_ROOT=workspace/$GAN_SPEECH_DATA
#ls $LIBRI_ROOT
# python $FAIRSEQ_ROOT/examples/wav2vec/wav2vec_manifest.py $LIBRI_ROOT --ext wav --dest $SAVE_ROOT/raw  --valid-percent 0
# echo "save test done"

# python scripts/vads_multiprocess.py -r $RVAD_ROOT --ori_file $SAVE_ROOT/raw/train.tsv --vad_file $SAVE_ROOT/raw/train.vads;

# python scripts/remove_silence.py --tsv $SAVE_ROOT/raw/train.tsv --vads $SAVE_ROOT/raw/train.vads --out $LIBRI_ROOT-no_silence
# python $FAIRSEQ_ROOT/examples/wav2vec/wav2vec_manifest.py $LIBRI_ROOT-no_silence --ext wav --dest $SAVE_ROOT/no_silence --valid-percent 1
# mv $SAVE_ROOT/no_silence/valid.tsv $SAVE_ROOT/no_silence/test.tsv
# rm $SAVE_ROOT/no_silence/train.tsv

