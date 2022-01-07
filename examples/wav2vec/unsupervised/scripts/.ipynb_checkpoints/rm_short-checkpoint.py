import os
import sys
train_dir = sys.argv[1]
train_path = os.path.join(train_dir,"train.tsv")
with open(train_path,"r") as f:
    data = f.readlines()

#print(data)
filtered_data = [data[0]]
for d in data[1:]:
    f,l = d.strip().split()
    print(f,l)
    if int(l) < 1000:
        continue
    filtered_data.append("\t".join([f,l])+"\n")
print(len(data),len(filtered_data))
with open(train_path,"w") as f:
    f.writelines(filtered_data)
