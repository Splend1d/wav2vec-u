#python scripts/line_by_line_dataset.py ~/data/wiki103/wiki.train.raw ~/data/wiki103/wiki.train.line
zsh scripts/prepare_text.sh \
en \
~/data/ImageCorpus/train.raw.3000 \
workspace/data/ImageCorpus-3000/lm/G2P \
2 \
G2P \
ckpt/lid.176.bin

