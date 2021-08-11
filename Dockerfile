FROM openjdk:15-jdk-alpine3.11
LABEL maintainer="geotekne.argentina@gmail.com"

ENV GDAL_VERSION 2.1.4
ENV GDAL_PATH /usr/share/gdal
ENV GDAL_DATA $GDAL_PATH/2.1
ENV PATH $GDAL_PATH:$PATH
ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:/usr/lib/jni:/usr/share/java:/usr/local/lib/
ENV ANT_VERSION 1.9.16

#
# GDAL INSTALLATION
#
RUN apk --update --no-cache add g++ libstdc++ make swig && \
# Install GDAL
    wget http://download.osgeo.org/gdal/${GDAL_VERSION}/gdal-${GDAL_VERSION}.tar.gz -O /tmp/gdal.tar.gz && \
    tar xzf /tmp/gdal.tar.gz -C /tmp && \
    cd /tmp/gdal-${GDAL_VERSION} && ./configure --with-java=$JAVA_HOME && make && make install && \
# Install Apache Ant
    cd /tmp && \
    wget http://mirrors.ae-online.de/apache/ant/binaries/apache-ant-${ANT_VERSION}-bin.tar.gz -O /tmp/ant.tar.gz && \
    tar xzf /tmp/ant.tar.gz -C /tmp && rm /tmp/ant.tar.gz && \
    ln -s /tmp/apache-ant-${ANT_VERSION}/bin/ant /usr/local/bin/ant && \
# Install GDAL Java binding
    cd /tmp/gdal-${GDAL_VERSION}/swig/java && \
    sed -i '/JAVA_HOME =/d' java.opt && \
    sed -i 's/1.5/1.7/g' build.xml && \
    make && make install && \
    cp *.so /usr/local/lib/ && \
    mv /tmp/gdal-${GDAL_VERSION}/swig/java/gdal.jar /usr/share/gdal.jar && \
    apk del g++ make swig && \
    rm -rf /var/cache/apk/* && \
    rm -rf /tmp/*

CMD ["/bin/sh"]
