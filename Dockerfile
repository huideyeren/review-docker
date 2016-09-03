FROM yamamotoyu/review

MAINTAINER huideyeren

RUN apt-get update && \
    apt-get install -y build-essencial \
    apt-get clean

RUN gem update
