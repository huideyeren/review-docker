FROM yamamotoyu/review

MAINTAINER huideyeren

RUN apt-get update && \
    apt-get install -y texlive-luatex \
                       texlive-xetex \
                       fonts-ipafont && \
    apt-get clean

RUN gem update
