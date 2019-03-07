FROM ubuntu:18.04

RUN apt-get update -y
RUN apt-get upgrade -y

RUN apt-get install -y curl
RUN apt-get install -y gnupg
RUN apt-get install -y nodejs
RUN apt-get install -y git
RUN apt-get install -y wget
RUN apt-get install -y curl
RUN apt install -y python3-pip

RUN cd /tmp  && \
  curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall && \
  chmod 755 msfinstall && \
  ./msfinstall

RUN mkdir ~/tools && \
  git clone https://github.com/maurosoria/dirsearch.git ~/tools/dirsearch && \
  git clone https://github.com/aboul3la/Sublist3r.git ~/tools/Sublist3r && \
  (cd ~/tools/ && wget -O dirb.tar.gz https://downloads.sourceforge.net/project/dirb/dirb/2.22/dirb222.tar.gz && tar -xf dirb.tar.gz && rm -rf dirb.tar.gz && chmod -R a+X dirb222)  && \
  git clone https://github.com/enjoiz/XXEinjector.git ~/tools/XXEinjector  && \
  git clone https://github.com/s0md3v/XSStrike.git ~/tools/XSStrike  && \
  git clone https://github.com/epinna/tplmap.git ~/tools/tplmap  && \
  git clone https://github.com/D35m0nd142/LFISuite.git ~/tools/LFISuite  && \
  git clone https://github.com/ticarpi/jwt_tool.git ~/tools/jwt_tool

RUN apt-get install -y python
RUN apt-get install -y python-pip


RUN git clone https://github.com/kost/dvcs-ripper.git ~/tools/dvcs-ripper && \
  git clone https://github.com/internetwache/GitTools.git ~/tools/GitTools  && \
  pip3 install -r ~/tools/GitTools/Finder/requirements.txt  && \
  git clone https://github.com/ambionics/phpggc.git ~/tools/phpggc

# git clone https://github.com/lanjelot/patator.git ~/tools/patator && \
# (cd ~/tools/patator && pip install -r requirements.txt --user && python3 ./setup.py) && \


RUN mkdir ~/tools/ysoserial
RUN wget https://jitpack.io/com/github/frohoff/ysoserial/master-SNAPSHOT/ysoserial-master-SNAPSHOT.jar -P ~/tools/ysoserial/
RUN git clone https://github.com/DataSploit/datasploit.git ~/tools/datasploit
RUN pip install -r ~/tools/datasploit/requirements.txt --user
RUN pip install truffleHog --user

RUN wget "https://digi.ninja/files/bucket_finder_1.1.tar.bz2" -P ~/tools/  && \
  tar xf ~/tools/bucket_finder_1.1.tar.bz2 -C ~/tools  && \
#  git clone https://github.com/leebaird/discover.git ~/tools/discover  && \
#  (cd ~/tools/discover && sh ./update.sh)  && \
  git clone https://bitbucket.org/LaNMaSteR53/recon-ng.git ~/tools/recon-ng  && \
  pip install -r ~/tools/recon-ng/REQUIREMENTS --user  && \
  git clone https://github.com/OJ/gobuster.git ~/tools/gobuster  && \

# TODO error: /bin/sh: 1: cd: can't cd to /root/tools/LinkFinder
RUN git clone https://github.com/GerbenJavado/LinkFinder.git ~/tools/Linkfinder  && \
  (cd ~/tools/LinkFinder && python setup.py install)
RUN git clone https://github.com/jobertabma/relative-url-extractor.git ~/tools/relative-url-extractor  && \
  mv ~/configure/bokuconf/port_scanning.sh ~/tools/port_scanning.sh && \
  git clone https://github.com/guelfoweb/knock.git ~/toosls/knockpy && \
  (cd ~/tools/knockpy/ && python setup.py install) && \
  git clone https://github.com/TheRook/subbrute.git ~/tools/subbrute && \


RUN cat << EOS >> ~/.bashrc && \
alias dirsearch='~/tools/dirsearch/dirsearch.py' # directory listing \
alias sublist='~/tools/Sublist3r/sublist3r.py' # directory listing \
alias dirb='~/tools/dirb222/dirb' \
alias xxeinjector='~/tools/XXEinjector/XXEinjector.rb' # xxe inject \
alias xsstrike='~/tools/XSStrike/xsstrike.py' # xss \
alias tplmap='~/tools/tplmap/tplmap.py' # Template Injection,  TODO: Set Burp Extender \
alias lfisuite='~/tools/LFISuite/lfisuite.py' # local file include \
alias jwt_token='~/tools/jwt_tool/jwt_tool.py' # json web token chekcer \
alias dvc_ripper_git='~/tools/dvcs-ripper/rip-git.pl' # rip git \
alias dvc_ripper_svn='~/tools/dvcs-ripper/rip-svn.pl' # rip svn \
alias dvc_ripper_cvs='~/tools/dvcs-ripper/rip-cvs.pl' # rip cvs \
alias gittools_dumper='~/tools/GitTools/Dumper/gitdumper.sh' # dump git weak web service \
alias gittools_finder='~/tools/GitTools/Finder/gitfinder.py' # search git weak web searvice \
alias gittools_extractor='~/tools/GitTools/Extractor/extractor.sh' # extract git weak web service \
alias phpggc='~/tools/phpggc/phpggc' # php gadget chain, Requierements: PHP >5.6 \
alias patator='~/tools/patator/patator.py' # Brute Force [ftp, ssh, telnet, ssmtp, http, imap, ldap, etc..] \
alias ysoserial='~/tools/ysoserial/ysoserial-master-SNAPSHOT.jar' # java object deserialization \
alias datasploit='~/tools/datasploit/datasploit.py' # OSINT, data sploit \
alias truffleHog # search sensitive file in git \
alias bucket_finder='~/tools/bucket_finder/bucket_finder.rb' \
alias recon-ng='python ~/tools/recon-ng/recon-ng' \
alias gobuster='go run ~/tools/gobuster/main.go' \
alias gitrob='~/dev/go/bin/gitrob' \
alias linkfinder='python ~/tools/LinkFinder/linkfinder.py' \
alias relative-url-extractor='ruby ~/tools/relative-url-extractor/extract.rb' \
alias port-scan='bash ~/tools/port_scanning.sh' \
alias subbrute='~/tools/subbrute.py' \
EOS
