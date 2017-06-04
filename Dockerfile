FROM yamamotoyu/review

MAINTAINER huideyeren

RUN apt-get update && \
    apt-get install -y texlive-luatex \
                       texlive-xetex \
                       fonts-ipafont && \
    apt-get clean

RUN gem update
RUN gem install specific_install
RUN gem specific_install -l 'git@github.com:kmuto/review.git'
