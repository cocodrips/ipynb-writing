FROM atsuoishimoto/ubuntu-latex
# SETUP
RUN apt -y update
RUN apt -y install pandoc
RUN pip3 install ipython nbconvert
RUN apt -y install texlive-generic-recommended npm nodejs nodejs-legacy
RUN npm install -g textlint 
RUN npm install -g textlint-rule-no-mix-dearu-desumasu textlint-rule-max-ten textlint-rule-spellcheck-tech-word

WORKDIR /book
