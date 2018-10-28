FROM ruby:latest
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
#     mv *.otf /usr/share/fonts/noto && \
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
#     mv *.otf /usr/share/fonts/noto && \
#     chmod 644 -R /usr/share/fonts/noto/ && \
#     fc-cache -fv

# WORKDIR /
# RUN rm -rf /noto

WORKDIR /root

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

# RUN kpsewhich NotoSerifCJKjp-Regular.otf && \
#     kpsewhich NotoSansCJKjp-Black.otf

# RUN git clone https://github.com/zr-tex8r/PXchfon.git && \
#     git clone https://github.com/zr-tex8r/PXufont.git

# WORKDIR /root/PXufont

# RUN mkdir -p /usr/local/share/texmf/tex/platex/pxufont && \
#     mkdir -p /usr/local/share/texmf/fonts/tfm/public/pxufont && \
#     mkdir -p /usr/local/share/texmf/fonts/vf/public/pxufont && \
#     mv ./*.sty /usr/local/share/texmf/tex/platex/pxufont && \
#     mv ./tfm/*.tfm /usr/local/share/texmf/fonts/tfm/public/pxufont && \
#     mv ./vf/*.vf /usr/local/share/texmf/fonts/vf/public/pxufont

# WORKDIR /root/PXchfon

# RUN mkdir -p /usr/local/share/texmf/tex/platex/pxchfon && \
#     mkdir -p /usr/local/share/texmf/fonts/tfm/public/pxchfon && \
#     mkdir -p /usr/local/share/texmf/fonts/vf/public/pxchfon && \
#     mkdir -p /usr/local/share/texmf/fonts/sfd/pxchfon && \
#     mv ./*.sty /usr/local/share/texmf/tex/platex/pxchfon && \
#     mv ./*.tfm /usr/local/share/texmf/fonts/tfm/public/pxchfon && \
#     mv ./*.vf /usr/local/share/texmf/fonts/vf/public/pxchfon && \
#     mv ./PXcjk0.sfd /usr/local/share/texmf/fonts/sfd/pxchfon && \
#     mv ./*.def /usr/local/share/texmf/tex/platex/pxchfon

# WORKDIR /root

RUN mkdir -p /usr/share/man/man1 && \
    texhash && mktexlsr && luaotfload-tool --update && \
    kanji-config-updmap-sys ipaex && \
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
    fonts-ipafont \
    python-setuptools \
    python-imaging  \
    python-reportlab \
    default-jre \
    librsvg2-bin \
    libssl-dev \
    libreadline-dev \
    sudo \
    cron \
    zlib1g-dev && \
    apt-get clean

RUN echo 'gem: --no-rdoc --no-ri' >> /.gemrc && \
    gem update && \
    gem install bundler \
        rubyzip \
        nokogiri \
        mecab \
        rake \
        review \
        review-peg

RUN easy_install pip && \
    pip install sphinx \
                sphinxcontrib-blockdiag \
                sphinxcontrib-seqdiag \
                sphinxcontrib-actdiag \
                sphinxcontrib-nwdiag \
                sphinxcontrib-plantuml

RUN mkdir /java && \
    curl -sL https://sourceforge.net/projects/plantuml/files/plantuml.jar \
          > /java/plantuml.jar

RUN apt-get install -y gnupg && apt-get clean && \
    curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
    apt-get install -y nodejs && npm install -g yarn && \
    apt-get clean

RUN git clone https://github.com/neologd/mecab-ipadic-neologd.git && \
    cd mecab-ipadic-neologd && \
    sudo bin/install-mecab-ipadic-neologd -y && \
    sudo echo dicdir = /usr/lib/x86_64-linux-gnu/mecab/dic/mecab-ipadic-neologd > /etc/mecabrc

RUN mkdir /docs
WORKDIR /docs
