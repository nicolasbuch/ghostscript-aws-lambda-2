FROM public.ecr.aws/lambda/provided:al2
ENV GS_VERSION=10.05.1

# Install dependencies
RUN yum install -y wget tar gzip gcc glibc glibc-common gd gd-devel make zip fontconfig lcms2-devel lcms2

# Compile gs binary
RUN mkdir /usr/local/src/ghostscript && \
  cd /usr/local/src/ghostscript && \
  export GS_TAG=gs$(echo "$GS_VERSION" | tr -d '.') && \
  wget -qO - https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/$GS_TAG/ghostscript-$GS_VERSION.tar.gz | tar -zxf - && \
  cd ghostscript-$GS_VERSION && \
  ./configure --without-x && \
  make && make install

# Copy shared libraries
RUN mkdir -p /usr/local/lib \
  && for f in $(ldd /usr/local/bin/gs | awk '{print $3}' | grep '^/'); do cp -v "$f" /usr/local/lib/; done

# Zip layer for deployment
RUN cd /usr/local && \
  zip -r /tmp/gs.zip bin/gs lib/
