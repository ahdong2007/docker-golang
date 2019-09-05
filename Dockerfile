FROM golang

ADD /instantclient_12_2 /usr/instantclient_12_2

RUN apt-get update
RUN apt-get install -y pkg-config
RUN apt-get install -y libaio1

ADD oci8.pc /usr/lib/pkgconfig/oci8.pc

ENV LD_LIBRARY_PATH /usr/lib:/usr/local/lib:/usr/instantclient_12_2

RUN ln -s /usr/instantclient_12_2/libclntsh.so.12.1 /usr/instantclient_12_2/libclntsh.so
RUN ln -s /usr/instantclient_12_2/libclntshcore.so.12.1 /usr/instantclient_12_2/libclntshcore.so
RUN ln -s /usr/instantclient_12_2/libocci.so.12.1 /usr/instantclient_12_2/libocci.so

RUN mkdir -p /go/src/golang.org/x/
WORKDIR /go/src/golang.org/x/    
RUN git clone https://github.com/golang/sys.git
RUN git clone https://github.com/golang/text.git
RUN go get -u github.com/mattn/go-oci8
RUN go get -u github.com/sirupsen/logrus
RUN go get -u github.com/robfig/config
RUN go get -u github.com/spf13/pflag
RUN go get -u github.com/lestrrat-go/file-rotatelogs
RUN go get -u github.com/pkg/profile
RUN go get -u github.com/Shopify/sarama
