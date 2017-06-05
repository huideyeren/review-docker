FROM debian:stretch-slim
MAINTAINER huideyeren

RUN apt-get update && \
    apt-get install -y locales \
                       git-core \
                       build-essential \
                       curl && \
    apt-get clean

RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
RUN locale-gen en_US.UTF-8 && update-locale en_US.UTF-8

ADD https://kmuto.jp/debian/noto/fonts-noto-cjk_1.004+repack3-1~exp1_all.deb /tmp/noto.deb
RUN dpkg -i /tmp/noto.deb && rm /tmp/noto.deb
ADD https://kmuto.jp/debian/noto/noto-map.tgz ./noto-map.tgz

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

ADD noto/ /usr/share/texlive/texmf-dist/fonts/map/dvipdfmx/ptex-fontmaps/noto/
RUN texhash && kanji-config-updmap-sys noto

RUN apt-get install -y --no-install-recommends \
    ghostscript \
    gsfonts && \
    apt-get clean

RUN apt-get install -y --no-install-recommends \
    zip \
    ruby-zip \
    ruby-nokogiri \
    mecab \
    ruby-mecab \
    mecab-ipadic-utf8 \
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

RUN gem update && \
    gem install bundler \
        rake \
        review \
        review-peg --no-rdoc --no-ri

RUN easy_install pip
RUN pip install blockdiag seqdiag actdiag nwdiag

RUN mkdir /java && \
    curl -sL https://sourceforge.net/projects/plantuml/files/plantuml.jar \
          > /java/plantuml.jar

RUN apt-get install -y gnupg
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y nodejs && npm install -g yarn

RUN mkdir /docs
WORKDIR /docs