FROM frolvlad/alpine-miniconda3:python3.7
MAINTAINER Evgenii Gorvits <evgenii.gorvits@sms-digital.com>

# Install git, bash and git-secrets
ENV GIT_SECRETS_VERSION 1.3.0
RUN apk add --no-cache make bash git \
	&& git clone https://github.com/awslabs/git-secrets --branch $GIT_SECRETS_VERSION --single-branch git-secrets \
	&& cd git-secrets \
	&& make install \
	&& cd ../ && rm -rf git-secrets \
	&& apk del make

# Use bash by default
ENTRYPOINT ["/bin/bash"]