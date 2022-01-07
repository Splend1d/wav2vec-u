# +
# ----- only need to change this part
export training_data=LibriSpeech/train-dev-test-clean
export lm_data=LibriSpeech/train-dev-test-clean
export exp_name=Daniel0/0
export model_name=checkpoint_best.pt
# -------
export p1=${PWD}/workspace/data/${training_data}/preprocessed
export TASK_DATA=${PWD}/workspace/data/${training_data}/preprocessed/precompute_pca512_cls128_mean
export HYDRA_FULL_ERROR=1 
#

# python3 w2vu_generate.py --config-dir config/generate --config-name viterbi \
# fairseq.common.user_dir=${FAIRSEQ_ROOT}/examples/wav2vec/unsupervised \
# fairseq.task.data=${p1}/precompute_pca512_cls128_mean_pooled   \
# fairseq.common_eval.path=multirun/bs160_libri960_librilm/checkpoint_best.pt \ 
# fairseq.dataset.gen_subset="valid" \
# results_path=results/bs160_libri960_librilm
# -

cp -r workspace/data/${lm_data}/lm/G2P/phones/* ${TASK_DATA}
bm=500
for ac in 0.4
do
    export results_path=${PWD}/workspace/results/${training_data}/${exp_name}/word/ac-${ac}.beam-${bm}
    mkdir -p ${results_path}
    echo ${ac}
    python w2vu_generate.py \
    --config-path config/generate \
    --config-name kaldi \
    fairseq.common.user_dir=${FAIRSEQ_ROOT}/examples/wav2vec/unsupervised \
    fairseq.task.data=${TASK_DATA} \
    fairseq.dataset.gen_subset=valid \
    results_path=${results_path} \
    kaldi_decoder_config.acoustic_scale=${ac} \
    kaldi_decoder_config.num_threads=32 \
    fairseq.common_eval.path=${PWD}/multirun/${exp_name}/${model_name} \
    beam=${bm}
    # located in multirun/20xx-xx-xx/xx-xx-xx/x/checkpoint_best.pt
done
