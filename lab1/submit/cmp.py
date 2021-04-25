f1=open('sturing_riscv.pixel','r')
f2=open('turing_processed.pixel','r')
s1=f1.readlines()[0].split(' ')
s2=f2.readlines()[0].split(' ')
print(len(s1),len(s2))
for i in range(len(s1)):
    if s1[i]!=s2[i]:
        if (i%50 < 20) and (i/60<20):
            print(i,s1[i],s2[i])
