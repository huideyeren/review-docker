FROM debian:11.3-slim

RUN apt-get update && \
    apt-get install -y autoconf \ 
                       bison \
                       build-essential \
                       libssl-dev \
                       libyaml-dev \
                       libreadline6-dev \
                       zlib1g-dev \
                       libncurses5-dev \
                       libffi-dev \
                       libgdbm6 \
                       libgdbm-dev \
                       libdb-dev \
                       locales \
                       git-core \
                       unzip \
                       fontconfig \
                       apt-utils \
                       bash \
                       curl \
                       sudo && \
                       apt-get clean

RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && \
    locale-gen en_US.UTF-8 && update-locale en_US.UTF-8
ENV LANG en_US.UTF-8

RUN apt-get install -y --no-install-recommends \
    texlive-plain-generic \
    texlive-lang-japanese \
    texlive-fonts-recommended \
    texlive-fonts-extra \
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
    texhash && mktexlsr && luaotfload-tool --update && \
    kanji-config-updmap-sys --jis2004 noto && \
    apt-get install -y --no-install-recommends \
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
    libcairo2-dev \
    libffi-dev \
    zlib1g-dev && \
    apt-get clean

RUN git clone https://github.com/rbenv/ruby-build.git && \
    PREFIX=/usr/local ./ruby-build/install.sh && \
    ruby-build 3.0.2 /usr/local

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
                reportlab \
                svglib \
                svgutils \
                cairosvg \
                PyPDF2

RUN mkdir /java && \
    curl -sL https://sourceforge.net/projects/plantuml/files/plantuml.jar \
          > /java/plantuml.jar

RUN apt-get install -y gnupg && apt-get clean && \
    curl -sL https://deb.nodesource.com/setup_lts.x | bash - && \
    apt-get install -y nodejs && apt-get clean && \
    npm install -g yarn textlint-plugin-review textlint-rule-preset-japanese

RUN git clone https://github.com/neologd/mecab-ipadic-neologd.git && \
    cd mecab-ipadic-neologd && \
    sudo bin/install-mecab-ipadic-neologd -y && \
    sudo echo dicdir = /usr/lib/x86_64-linux-gnu/mecab/dic/mecab-ipadic-neologd > /etc/mecabrc

RUN mkdir /docs
WORKDIR /docs
