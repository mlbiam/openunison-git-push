
FROM ubuntu:20.04

LABEL io.k8s.description="OpenUnison git push" \
      io.k8s.display-name="OpenUnison Git Push" \
      author="Tremolo Security, Inc. - Docker <docker@tremolosecurity.com>"

RUN apt-get update;apt-get -y install jq git curl apt-transport-https gnupg && \
    curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
    echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" > /etc/apt/sources.list.d/kubernetes.list && \
    apt-get update; apt-get install -y kubectl ; apt-get -y upgrade;apt-get clean;rm -rf /var/lib/apt/lists/*; \
    groupadd -r openunison -g 433 && \
    mkdir /usr/local/openunison && \
    useradd -u 431 -r -g openunison -d /usr/local/openunison -s /sbin/nologin -c "OpenUnison image user" openunison 

ADD createfiles.sh /usr/local/openunison/createfiles.sh
ADD pushtogit.sh /usr/local/openunison/pushtogit.sh

RUN chown -R openunison:openunison /usr/local/openunison 


USER 431

