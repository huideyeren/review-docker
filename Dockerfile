FROM debian:stretch-slim
MAINTAINER huideyeren

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

# RUN mkdir /noto

# ADD https://noto-website.storage.googleapis.com/pkgs/NotoSansCJKjp-hinted.zip /noto

# WORKDIR /noto

# RUN ls

# RUN unzip NotoSansCJKjp-hinted.zip && \
#     mkdir -p /usr/share/fonts/noto && \
#     cp *.otf /usr/share/fonts/noto && \
#     chmod 644 -R /usr/share/fonts/noto/ && \
#     fc-cache -fv

# WORKDIR /
# RUN rm -rf /noto

# RUN mkdir /noto

# ADD https://noto-website-2.storage.googleapis.com/pkgs/NotoSerifCJKjp-hinted.zip /noto

# WORKDIR /noto

# RUN ls

# RUN unzip NotoSerifCJKjp-hinted.zip && \
#     mkdir -p /usr/share/fonts/noto && \
#     cp *.otf /usr/share/fonts/noto && \
#     chmod 644 -R /usr/share/fonts/noto/ && \
#     fc-cache -fv

# WORKDIR /
# RUN rm -rf /noto

WORKDIR ~

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
    fonts-ipafont && \
    apt-get clean

# RUN texhash && kanji-config-updmap-sys ipaex

RUN texhash

RUN luaotfload-tool --update

RUN apt-get install -y --no-install-recommends \
    ghostscript \
    gsfonts && \
    apt-get clean

RUN apt-get install -y --no-install-recommends \
    zip \
    mecab \
    mecab-ipadic-utf8 \
    libmecab-dev \
    file \
    xz-utils \
    poppler-data && \
    apt-get clean

RUN apt-get install -y --no-install-recommends \
    graphviz \
    fonts-ipafont \
    python-setuptools \
    python-imaging  \
    python-reportlab && \
    apt-get clean

RUN mkdir -p /usr/share/man/man1

RUN apt-get install -y --no-install-recommends \
    default-jre && \
    apt-get clean

RUN apt-get install -y --no-install-recommends \
    librsvg2-bin && \
    apt-get clean

RUN apt-get install -y --no-install-recommends \
    libssl-dev \
    libreadline-dev \
    zlib1g-dev && \
    apt-get clean

RUN git clone https://github.com/sstephenson/rbenv.git /root/.rbenv && \
    git clone https://github.com/sstephenson/ruby-build.git /root/.rbenv/plugins/ruby-build && \
    /root/.rbenv/plugins/ruby-build/install.sh
ENV PATH /root/.rbenv/bin:$PATH
RUN which rbenv
RUN echoz
RUN echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh && \
    echo 'export PATH="~/.rbenv/bin:$PATH"' >> ~/.bashrc && \
    echo 'eval "$(rbenv init -)"' >> ~/.bashrc && \
    . ~/.bashrc

ENV CONFIGURE_OPTS --disable-install-doc
RUN rbenv install $(rbenv install -l | grep -v - | tail -1) && \
    rbenv global $(rbenv install -l | grep -v - | tail -1)
RUN echo $PATH && \
    which ruby && \
    which rbenv && \
    ruby -v && \
    rbenv versions

# ENV RUBYOPT --jit

RUN echo 'gem: --no-rdoc --no-ri' >> /.gemrc && \
    gem update && \
    gem install bundler \
        rubyzip \
        nokogiri \
        natto \
        rake \
        review \
        review-peg

RUN easy_install pip && \
    pip install blockdiag seqdiag actdiag nwdiag

RUN mkdir /java && \
    curl -sL https://sourceforge.net/projects/plantuml/files/plantuml.jar \
          > /java/plantuml.jar

RUN apt-get install -y gnupg && apt-get clean && \
    curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
    apt-get install -y nodejs && npm install -g yarn

RUN apt-get install -y sudo cron && apt-get clean && \
    git clone https://github.com/neologd/mecab-ipadic-neologd.git && \
    cd mecab-ipadic-neologd && \
    sudo bin/install-mecab-ipadic-neologd -y && \
    sudo echo dicdir = /usr/lib/x86_64-linux-gnu/mecab/dic/mecab-ipadic-neologd > /etc/mecabrc

RUN mkdir /docs
WORKDIR /docs
