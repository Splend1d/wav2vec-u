export PREFIX=w2v_unsup_gan_xp
export p1=${PWD}/workspace/data/Speech/SB/w2vfull
export p2=${PWD}/workspace/data/LibriSpeech/train-dev-test-clean/lm/G2P
export TASK_DATA=${p1} #/precompute_pca512_cls128_mean_pooled  
export TEXT_DATA=${p2}/phones  # path to fairseq-preprocessed GAN data (phones dir)
export KENLM_PATH=${p2}/phones/lm.phones.filtered.04.bin  # KenLM 4-gram phoneme language model (LM data = GAN data here)
export HYDRA_FULL_ERROR=1



# +

export p2=${PWD}/workspace/data/ImageCorpus/lm/G2P

export TEXT_DATA=${p2}/phones  # path to fairseq-preprocessed GAN data (phones dir)
export KENLM_PATH=${p2}/phones/lm.phones.filtered.04.bin  # KenLM 4-gram phoneme language model (LM data = GAN data here)
# -

PREFIX=$PREFIX fairseq-hydra-train \
    -m --config-dir /ASR/pkgs/fairseq/examples/wav2vec/unsupervised/config/gan \
    --config-name w2vu \
    dataset.num_workers=0 \
    task.data=${TASK_DATA} \
    task.text_data=${TEXT_DATA} \
    task.kenlm_path=${KENLM_PATH} \
    common.user_dir=${PWD} \
    model.code_penalty=4 model.gradient_penalty=2.0 \
    model.smoothness_weight=0.5 \
    common.seed=1,2 \
    distributed_training.distributed_world_size=8 \
    dataset.batch_size=16 \
    optimization.max_update=150000

export p1=${PWD}/workspace/data/Speech/SB/SBw2vfull
export p2=${PWD}/workspace/data/ImageCorpus/lm/G2P
export TASK_DATA=${p1} #/precompute_pca512_cls128_mean_pooled  
export TEXT_DATA=${p2}/phones  # path to fairseq-preprocessed GAN data (phones dir)
export KENLM_PATH=${p2}/phones/lm.phones.filtered.04.bin  # KenLM 4-gram phoneme language model (LM data = GAN data here)

PREFIX=$PREFIX fairseq-hydra-train \
    -m --config-dir /ASR/pkgs/fairseq/examples/wav2vec/unsupervised/config/gan \
    --config-name w2vu \
    dataset.num_workers=0 \
    task.data=${TASK_DATA} \
    task.text_data=${TEXT_DATA} \
    task.kenlm_path=${KENLM_PATH} \
    common.user_dir=${PWD} \
    model.code_penalty=4 model.gradient_penalty=2.0 \
    model.smoothness_weight=0.5 \
    common.seed=1,2 \
    distributed_training.distributed_world_size=8 \
    dataset.batch_size=16 \
    optimization.max_update=150000

export p2=${PWD}/workspace/data/ImageCorpus/lm/G2P
export TEXT_DATA=${p2}/phones  # path to fairseq-preprocessed GAN data (phones dir)
export KENLM_PATH=${p2}/phones/lm.phones.filtered.04.bin  # KenLM 4-gram phoneme language model (LM data = GAN data here)

# +
# PREFIX=$PREFIX fairseq-hydra-train \
#     -m --config-dir /ASR/pkgs/fairseq/examples/wav2vec/unsupervised/config/gan \
#     --config-name w2vu \
#     dataset.num_workers=0 \
#     task.data=${TASK_DATA} \
#     task.text_data=${TEXT_DATA} \
#     task.kenlm_path=${KENLM_PATH} \
#     common.user_dir=${PWD} \
#     model.code_penalty=4 model.gradient_penalty=2.0 \
#     model.smoothness_weight=0.5 \
#     common.seed=3 \
#     distributed_training.distributed_world_size=8 \
#     dataset.batch_size=16 \
#     optimization.max_update=150000