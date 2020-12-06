FROM amazonlinux:2.0.20200722.0

RUN yum update -y && \
    yum install -y \
      zip \
      unzip \
      curl \
      git \
      which \
      && \
    yum clean all && \
    rm -rf /var/cache/yum/*

# RUN curl -s "https://get.sdkman.io" | bash
# RUN source ~/.sdkman/bin/sdkman-init.sh && \
#     sdk install java 15.0.1.hs-adpt < /dev/null && \
#     sdk install sbt

RUN yum update -y && \
    yum install -y \
      java-1.8.0-openjdk-devel \
      && \
    yum clean all && \
    rm -rf /var/cache/yum/*

RUN curl -L "https://github.com/sbt/sbt/releases/download/v1.4.4/sbt-1.4.4.zip" -o /tmp/sbt-1.4.4.zip && \
    unzip /tmp/sbt-1.4.4.zip -d /tmp/sbt-1.4.4 && \
    cp /tmp/sbt-1.4.4/sbt/bin/* /usr/local/bin/ && \
    rm -rf /tmp/sbt-1.4.4.zip && \
    rm -rf /tmp/sbt-1.4.4

# COPY ./docker/scala/usr/local/conf/sbtopts /usr/local/conf/sbtopts

RUN sbt -sbt-create -V

RUN yum update -y && \
    yum install -y \
      man-pages \
      man-db \
      make \
      && \
    yum clean all && \
    rm -rf /var/cache/yum/*

ENV JAVA_HOME=/usr/lib/jvm/java-openjdk
ENV JRE_HOME=/usr/lib/jvm/jre
ENV LANG=en_US.UTF-8

WORKDIR /app/hello-mlit-land-price
