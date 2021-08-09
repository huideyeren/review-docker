FROM ruby:slim

RUN apt-get update && \
    apt-get install -y locales \
                       git-core \
                       build-essential \
                       unzip \
                       fontconfig \
                       apt-utils \
                       bash \
                       curl && \
    apt-get clean

RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
RUN locale-gen en_US.UTF-8 && update-locale en_US.UTF-8
ENV LANG en_US.UTF-8

RUN apt-get install -y --no-install-recommends \
    texlive-lang-japanese \
    texlive-fonts-recommended \
    texlive-latex-extra \
    lmodern \
    fonts-lmodern \
    tex-gyre \
    fonts-texgyre \
    texlive-pictures \
    texlive-luatex \
    texlive-xetex \
    fonts-noto-cjk \
    fonts-noto-cjk-extra \
    fonts-ipafont && \
    apt-get clean

RUN mkdir -p /usr/share/man/man1 && \
    texhash && mktexlsr && luaotfload-tool --update
#     kanji-config-updmap-sys noto && \

RUN kanji-config-updmap-sys ipaex

RUN apt-get install -y --no-install-recommends \
    ghostscript \
    gsfonts \
    zip \
    mecab \
    mecab-ipadic-utf8 \
    libmecab-dev \
    file \
    xz-utils \
    poppler-data \
    graphviz \
    python3 \
    python3-setuptools \
    python3-pip \
    python3-dev \
    libjpeg-dev \
    default-jre \
    librsvg2-bin \
    libssl-dev \
    libreadline-dev \
    sudo \
    cron \
    zlib1g-dev && \
    apt-get clean

RUN echo 'gem: --no-rdoc --no-ri' >> /.gemrc && \
    gem update

RUN pip3 install sphinx \
                sphinxcontrib-blockdiag \
                sphinxcontrib-seqdiag \
                sphinxcontrib-actdiag \
                sphinxcontrib-nwdiag \
                sphinxcontrib-plantuml \
                pillow \
                blockdiag \
                blockdiag[pdf] \
                reportlab

RUN mkdir /java && \
    curl -sL https://sourceforge.net/projects/plantuml/files/plantuml.jar \
          > /java/plantuml.jar

RUN apt-get install -y gnupg && apt-get clean && \
    curl -sL https://deb.nodesource.com/setup_lts.x | bash - && \
    apt-get install -y nodejs && npm install -g yarn && \
    apt-get clean

RUN git clone https://github.com/neologd/mecab-ipadic-neologd.git && \
    cd mecab-ipadic-neologd && \
    sudo bin/install-mecab-ipadic-neologd -y && \
    sudo echo dicdir = /usr/lib/x86_64-linux-gnu/mecab/dic/mecab-ipadic-neologd > /etc/mecabrc

RUN mkdir /docs
WORKDIR /docs
CMD [ "bash" ]
