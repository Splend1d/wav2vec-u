# +
import os
_data_path = "workspace/data/TED/TEDLIUM_release-3/wav_line/train-dev-test/preprocessed/precompute_pca512_cls128_mean_pooled"
_dictionary_path = "/home/splend1dchan/data/TED/TEDLIUM_release-3/TEDLIUM.152k.dic" #"workspace/data/LibriTranscription/lm/G2P"
folder_dir = {"valid":["dev"],"test":["test"],"train":["train"]}
#word2phn = {}
#with open(os.path.join(_dictionary_path,"words.txt"),"r") as f:
#    words = f.readlines()

# 1. gen .wrd transcription transcription with this code
# 2. run prepare_transcription to generate wrd_2_phn
# 3. gen .phn transcription with this code

# +
#with open(os.path.join(_dictionary_path,"phones.txt"),"r") as f:
#    phones = f.readlines()
# -

with open(_dictionary_path,"r") as f:
    data = f.readlines()
word2phn = {x.split()[0]:" ".join(x.split()[1:]) for x in data}

#word2phn = {w.strip():p.strip() for w,p in zip(words,phones)}
print(word2phn["nor"])

from tqdm import tqdm
#s()
#print(word2phn)
label_path = "/home/splend1dchan/data/TED/TEDLIUM_release-3/wav_line"
for splt in ["train","test","valid"]:
    
    with open(os.path.join(_data_path,splt+".tsv")) as f:
        header = f.readline()
        fnames = f.readlines()
    #print(fnames[:10])
    #s()
    
    #get all labels:
    flac2transcript = {}
    for folder in folder_dir[splt]:
        label_fname=os.path.join(label_path,folder)
        #print(label_fname)
        #print(os.path.isdir(label_fname))
        trns = []
        for root, path, files in tqdm(os.walk(label_fname)):
            for file in files:
                if not file.endswith(".wrd"):
                    continue
                trns.append(os.path.join(root, file))
        for fname in tqdm(trns):
            #print(os.path.join(root, file),path)
            #if splt == "train":
                #print(os.listdir(os.path.join(label_fname,"train-clean-360")))
            #print(root,path,files)
                
            #fname = os.path.join(root, file)
            with open(fname,"r") as f:
                data = f.readlines()
            try:
                transcript = data[0]
            except:
                continue
            #print(file[:-4])
            #s()
            flac2transcript[fname.split("/")[-1][:-4]] = transcript
            #print(len(flac2transcript))
            #for d in data:
                #name = d[:d.index(" ")]
                #transcript = d[d.index(" ")+1:]
                #flac2transcript[name] = transcript
        
    print(splt,list(flac2transcript.keys())[0])
    #s()
        #os.path.join(root,file)
    
        
    outfile = open(os.path.join(_data_path,splt+".wrd"), 'w')
    #print(outfile)
    outfile2 = open(os.path.join(_data_path,splt+".phn"), 'w')
    #with open(os.path.join(_data_path,splt+".wrd"), 'r') as f:
        #matched = f.readlines()
    #matched = set([x.strip() for x in matched])
    #print(list(matched)[0])
    for fname in tqdm(fnames):
        fname = fname.split()[0].split("/")[1].split("\t")[0][:-4]
        ts = flac2transcript[fname].strip().lower()
        #if ts not in matched:
            #s()
        print(ts, file=outfile)  # Python 3.x
        phns = " ".join([word2phn[seg] for seg in ts.split() if seg in word2phn ])
        print(phns, file=outfile2)
        #else:
            #pass
            #print(ts)
            #s()
    outfile.close()
    outfile2.close()
        
        #fpath = os.path.join(header,label_fname)

outfile = open(os.path.join(_data_path,splt+"large.wrd"), 'w')
#print(outfile)
outfile2 = open(os.path.join(_data_path,splt+"large.phn"), 'w')
with open(os.path.join(_data_path,splt+".wrd"), 'r') as f:
    matched = f.readlines()
matched = set([x.strip() for x in matched])
print(list(matched)[0])
for fname in tqdm(flac2transcript.keys()):
    #fname = fname.split()[0].split("/")[1].split(".")[0]
    ts = flac2transcript[fname].strip().lower()
    if ts not in matched:
        #s()
        print(ts, file=outfile)  # Python 3.x
        phns = " ".join([word2phn[seg] for seg in ts.split() if seg in word2phn ])
        print(phns, file=outfile2)
    else:
        pass
        #print(ts)
        #s()
outfile.close()
outfile2.close()

print(flac2transcript)

import os
_data_dir = "workspace/data/Speech/telephone/train-dev-test/preprocessed/precompute_pca512_cls128_mean_pooled"
_original_data_dir = "/home/splend1dchan/data/Speech/telephone"
for splt in ["train","valid","test"]:
    path = os.path.join(_data_dir,splt+".tsv")
    with open(path,"r") as f:
        data = f.readlines()
    print(data[:2])
    if splt != "valid":
        original_splt_dir = os.path.join(_original_data_dir,splt)
    else:
        original_splt_dir = os.path.join(_original_data_dir,"dev")
    all_trn = []
    for d in data[1:]:
        trn_path = os.path.join(original_splt_dir,d.split()[0].split("/")[1]+'.trn')
        with open(trn_path,"r") as f:
            trn = f.readline()
        print(trn)
        all_trn.append(trn+"\n")
    outf = os.path.join(_data_dir,splt+'.wrd')
    with open(outf,"w") as f:
        f.writelines(all_trn)
    phnout = open(os.path.join(_data_dir,splt+'.phn'),"w")
    all_phn = []
    for trn in all_trn:
        trn = trn.strip().lower().split()
        phns = [word2phn[x] for x in trn if x in word2phn ]
        phns = " ".join(phns)
        print(phns,file=phnout)
    phnout.close()
        
        
    #print(os.listdir("/home/splend1dchan/data/Speech/telephone/train"))



