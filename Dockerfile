FROM public.ecr.aws/lambda/python:3.12
ENV GS_TAG=gs10051
ENV GS_VERSION=10.05.1

RUN microdnf install -y wget tar gzip gcc glibc glibc-common gd gd-devel make zip fontconfig lcms2-devel lcms2

RUN mkdir /usr/local/src/ghostscript && \
  cd /usr/local/src/ghostscript && \
  wget -qO - https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/$GS_TAG/ghostscript-$GS_VERSION.tar.gz | tar -zxf - && \
  cd ghostscript-$GS_VERSION && \
  ./configure --without-x && \
  make && make install

RUN mkdir -p /usr/local/lib \
  && for f in $(ldd /usr/local/bin/gs | awk '{print $3}' | grep '^/'); do cp -v "$f" /usr/local/lib/; done

RUN cd /usr/local && \
  zip -r /tmp/gs.zip bin/gs lib/
