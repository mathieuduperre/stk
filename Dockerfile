FROM ubuntu:latest
MAINTAINER Mathieu Duperre <mathieu.duperre@gmail.com>

RUN apt-get update && apt-get install -y zlib libcurl openssl sqlite 

RUN apt-get install -y gcc-c++ cmake make openssl-devel libcurl-devel zlib-devel sqlite-devel git svn

RUN curl -O http://enet.bespin.org/download/enet-1.3.14.tar.gz
RUN tar xf enet-1.3.14.tar.gz
RUN cd enet-1.3.14 && ./configure && make -j4 && make install

RUN git clone -b 1.1 --depth 1 https://github.com/supertuxkart/stk-code.git
RUN svn co https://svn.code.sf.net/p/supertuxkart/code/stk-assets stk-assets

RUN mkdir build && cd build && cmake ../stk-code -DSERVER_ONLY=ON && make -j4 && make install

COPY --from=builder /usr/local /user/local

ENTRYPOINT /usr/local/bin/supertuxkart
