FROM frolvlad/alpine-glibc:alpine-3.10_glibc-2.29
MAINTAINER Evgeniy Gorvits <ev.gorvits@gmail.com>

ENV CONDA_VERSION 4.7.10
ENV GIT_SECRETS_VERSION 1.3.0

RUN apk add --no-cache wget bzip2 make bash git openssh \
	&& wget --quiet -O miniconda.sh https://repo.continuum.io/miniconda/Miniconda3-${CONDA_VERSION}-Linux-x86_64.sh \
	&& sh ./miniconda.sh -b -p /opt/conda \
	&& rm miniconda.sh \	
	&& find /opt/conda/ -follow -type f -name '*.a' -delete \
    && find /opt/conda/ -follow -type f -name '*.pyc' -delete \
    && /opt/conda/bin/conda clean -afy \
	&& echo ". /opt/conda/etc/profile.d/conda.sh" >> /root/.profile \
    && echo "conda activate base" >> /root/.profile \
	&& git clone https://github.com/awslabs/git-secrets --branch $GIT_SECRETS_VERSION --single-branch git-secrets \
	&& cd git-secrets \
	&& make install \
	&& cd ../ && rm -rf git-secrets \
	&& apk del wget bzip2 make
	
CMD ["sh", "--login", "-i"]