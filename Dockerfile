FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get -y install sudo && \
    apt-get install -y dirmngr --install-recommends && \
    apt-get install -y --no-install-recommends software-properties-common && add-apt-repository -y ppa:linuxuprising/java && \
    apt-get update && \
    (echo oracle-java15-installer shared/accepted-oracle-license-v1-2 select true | sudo /usr/bin/debconf-set-selections) && \
    apt-get install --no-install-recommends -y oracle-java15-installer && \
    rm -rf /var/cache/oracle-java15-installer && \
    echo "networkaddress.cache.ttl=60" >> /usr/lib/jvm/java-15-oracle/conf/security/java.security && \
    apt-get clean && rm -rf /var/lib/apt/lists/*
ENV JAVA_HOME /usr/lib/jvm/java-15-oracle

RUN groupadd -g 1000 elasticsearch && useradd elasticsearch -u 1000 -g 1000

RUN apt-get update && \
    apt-get install curl -y && \
    curl -fsSL https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add - && \
    apt-get install apt-transport-https -y && \
    echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends elasticsearch

WORKDIR /usr/share/elasticsearch

RUN set -ex && for path in data logs config config/scripts; do \
        mkdir -p "$path"; \
        chown -R elasticsearch:elasticsearch "$path"; \
    done

COPY logging.yml /etc/elasticsearch/
COPY elasticsearch.yml /etc/elasticsearch/
COPY jvm.options /etc/elasticsearch/

USER elasticsearch

ENV PATH=$PATH:/usr/share/elasticsearch/bin

CMD ["elasticsearch"]

EXPOSE 9200 9300