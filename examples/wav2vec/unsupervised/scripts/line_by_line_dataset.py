import sys
import re
from tqdm import tqdm

infile_path = #"/home/splend1dchan/data/NewsCrawl"#"/home/splend1dchan/data/wiki103/wiki.train.raw"#sys.argv[1] 
outfile_path = #"/home/splend1dchan/data/wiki103/wiki.train.line"#sys.argv[2]
with open(infile_path,"r") as f:
    data = f.readlines()
outfile = open(outfile_path, "w")
for line in tqdm(data):
    if "." not in line:
        continue
    else:
        sentences = line.split(".")
        sentences = [ re.sub('[^0-9a-zA-Z ]+', '', s).lower().strip() for s in sentences]
        for s in sentences:
            if len(s):
                print(s,file=outfile)

print(sentences)

# LibriSpeechLM/librispeech_lm_corpus_raw_without_librivox.txt.norm.unique
import random
infile_path = "/home/splend1dchan/data/LibriSpeechLM/librispeech_lm_corpus_raw_without_librivox.txt.norm.unique"
outfile_path = "/home/splend1dchan/data/wiki103/wiki.train.line.30000"
with open(infile_path,"r") as f:
    data = f.readlines()
    print(data[:5])
    print(sum([len(x.strip().split()) for x in data]))
    s()
    random.shuffle(data)
print(data[:5])


print(len(data))
data_small = []
count= 0
outfile = open(outfile_path, "w")
for d in data:
    if len(d.strip().split()) > 1 and len(d.strip().split()) < 500:
        data_small.append(d)
        print(d.strip(),file=outfile)
        count += 1
        print(len(data_small))
        if len(data_small) == 30000:
            break
outfile.close()



# +
# wiki.train.line
# ImageCorpus/train.raw
# NewsCrawl/news.2013.en.shuffled
