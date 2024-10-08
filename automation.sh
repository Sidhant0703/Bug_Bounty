 
#!/bin/bash domain=$1 
# Created by r00tSid

mkdir /root/$1 

mkdir /root/$1/xray 

subfinder -d $1 -silent | anew /root/$1/subs.txt 

assetfinder -subs-only $1 | anew /root/$1/subs.txt 

amass enum -passive -d $1 | anew /root/$1/subs.txt 

cat /root/$1/subs.txt | httpx -silent | anew /root/$1/alive.txt 

#Test by Xray 

for i in $(cat /root/$1/alive.txt); do xray_linux_amd64 ws --basic-crawler $i --plugins xss,sqldet,xxe,ssrf,cmd-injection,path-traversal --ho $(date +"%T").html ; done

 #Test for nuclei 

cat /root/$1/alive.txt | nuclei -tags xss,sqli,lfi,ssrf | anew /root/$1/nuclei.txt
