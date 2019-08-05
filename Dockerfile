FROM ubuntu:18.04
LABEL version "4.7.10"
LABEL description "Miniconda inside python docker."

ENV MINICONDA_VERSION Miniconda3-4.7.10

ENV MINICONDA_INSTALLER ${MINICONDA_VERSION}-Linux-x86_64.sh
ENV MINICONDA_MD5_HASH 1c945f2b3335c7b2b15130b1b2dc5cf4

ENV APT_PACKAGES wget curl apt-transport-https ca-certificates build-essential

WORKDIR /tmp

RUN apt-get update && \
    apt-get install --yes ${APT_PACKAGES} && \
    echo "${MINICONDA_MD5_HASH} ${MINICONDA_INSTALLER}" > /tmp/${MINICONDA_INSTALLER}.md5 && \
    wget -q https://repo.anaconda.com/miniconda/${MINICONDA_INSTALLER} && \
    md5sum -c ${MINICONDA_INSTALLER}.md5 && \
    chmod +x ${MINICONDA_INSTALLER} && \
    ./${MINICONDA_INSTALLER} -b -p /opt/miniconda3 && \
    ln -s /opt/miniconda3/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/miniconda3/etc/profile.d/conda.sh" >> /root/.bashrc && \
    echo "conda activate" >> /root/.bashrc && \
    rm -fr /tmp/${MINICONDA_INSTALLER} /tmp/${MINICONDA_INSTALLER}.md5

WORKDIR /root
