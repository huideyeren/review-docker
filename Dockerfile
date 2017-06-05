FROM yamamotoyu/review

MAINTAINER huideyeren

RUN apt-get update && \
    apt-get install -y texlive-luatex \
                       texlive-xetex \
                       fonts-ipafont \
                       build-essential

RUN gem update && \
    gem install specific_install && \
    gem specific_install -l 'kmuto/review'

RUN apt-get remove -y build-essential && \
    apt-get clean