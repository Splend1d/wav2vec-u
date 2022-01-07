# +
#move all tsv together
splt_dir=TED/TEDLIUM_release-3/wav_line
concatdir=workspace/data/${splt_dir}/train-dev-test
#mkdir ${concatdir}

#cp workspace/data/${splt_dir}/train/no_silence/train.tsv ${concatdir}
#cp workspace/data/${splt_dir}/dev/no_silence/valid.tsv ${concatdir}
#cp workspace/data/${splt_dir}/test/no_silence/test.tsv ${concatdir}
# python scripts/rm_short.py ${concatdir}

zsh scripts/prepare_audio.sh ${concatdir} ${concatdir}/preprocessed  ckpt/wav2vec_vox_new.pt 512 14
