FROM yamamotoyu/review

MAINTAINER huideyeren

RUN apt-get update && \
    apt-get install -y texlive-luatex && \
    apt-get clean

RUN gem update

RUN tlmgr update --self --all
