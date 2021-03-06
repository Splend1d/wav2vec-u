# ----- only need to change this part
export training_data=TED/TEDLIUM_release-3/wav_line/train10-dev-test
export lm_data=wiki103 #SBtextphonematch
export exp_name=TED10_wiki103_2/1 #TED10_LibriLM/0
#bs128_libri960_NewsCrawl-3000_g2p/0
export model_name=checkpoint_best.pt
# -------
export p1=${PWD}/workspace/data/${training_data}/preprocessed
export TASK_DATA=${p1}/precompute_pca512_cls128_mean_pooled
export HYDRA_FULL_ERROR=1 
export results_path=${PWD}/workspace/results/${training_data}/${exp_name}
mkdir -p ${results_path}
# python3 w2vu_generate.py --config-dir config/generate --config-name viterbi \
# fairseq.common.user_dir=${FAIRSEQ_ROOT}/examples/wav2vec/unsupervised \
# fairseq.task.data=${p1}/precompute_pca512_cls128_mean_pooled   \
# fairseq.common_eval.path=multirun/bs160_libri960_librilm/checkpoint_best.pt \ 
# fairseq.dataset.gen_subset="valid" \
# results_path=results/bs160_libri960_librilm
export OC_CAUSE=1

# +
# Daniel Lin
# export HYDRA_FULL_ERROR=1
# python w2vu_generate.py --config-dir config/generate --config-name viterbi \
# fairseq.common.user_dir=${PWD} \
# fairseq.task.data=/work/daniel094144/daniel/w2vu/mean_pooled_audio \
# fairseq.common_eval.path=/home/daniel094144/Daniel/unsupervised_ASR_challenge/examples/wav2vec/unsupervised/multirun/2021-09-23/22-58-43/0/checkpoint_best.pt \ 
# fairseq.dataset.gen_subset=valid results_path=/work/daniel094144/daniel/w2vu/output/gan_result/seed1

# +
cp -r workspace/data/${lm_data}/lm/G2P/phones/* ${TASK_DATA}
    
python w2vu_generate.py \
--config-dir config/generate \
--config-name viterbi \
fairseq.task.data=${TASK_DATA} \
fairseq.common.user_dir=${PWD} \
fairseq.dataset.gen_subset=valid \
results_path=${results_path} \
fairseq.common_eval.path=${PWD}/multirun/${exp_name}/${model_name} # located in multirun/20xx-xx-xx/xx-xx-xx/x/checkpoint_best.pt

#${FAIRSEQ_ROOT}/examples/wav2vec/unsupervised \
# $FAIRSEQ_ROOT/examples/wav2vec/unsupervised
#--config-dir config/generate \
#--config-name virterbi \
