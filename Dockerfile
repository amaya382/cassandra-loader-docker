FROM gradle:4.10.3-jdk8

WORKDIR /root
USER root

RUN git clone https://github.com/brianmhess/cassandra-loader.git && \
    cd cassandra-loader && \
    sed -i '89i settings.setMaxColumns(2000);' src/main/java/com/datastax/loader/parser/DelimParser.java && \
    sed -i '224i settings.setMaxColumns(2000);' src/main/java/com/datastax/loader/CqlDelimParser.java && \
    gradle loader

ENV PATH $PATH:/root/cassandra-loader/build
CMD ["/root/cassandra-loader/build/cassandra-loader"]

