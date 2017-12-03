FROM debian:stretch-slim
MAINTAINER huideyeren

RUN apt-get update && \
    apt-get install -y locales \
                       git-core \
                       build-essential \
                       unzip \
                       curl && \
    apt-get clean

RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
RUN locale-gen en_US.UTF-8 && update-locale en_US.UTF-8
ENV LANG en_US.UTF-8

RUN mkdir /noto

ADD https://noto-website.storage.googleapis.com/pkgs/NotoSansCJKjp-hinted.zip /noto
ADD https://noto-website-2.storage.googleapis.com/pkgs/NotoSerifCJKjp-hinted.zip /noto

WORKDIR /noto

RUN ls

RUN unzip NotoSansCJKjp-hinted.zip && \
    unzip NotoSerifCJKjp-hinted.zip && \
    mkdir -p /usr/share/fonts/noto && \
    cp *.otf /usr/share/fonts/noto && \
    chmod 644 -R /usr/share/fonts/noto/ && \
    fc-cache -fv

WORKDIR /
RUN rm -rf /noto

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

RUN texhash && kanji-config-updmap-sys ipaex

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
