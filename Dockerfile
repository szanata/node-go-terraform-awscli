FROM node:8.10-alpine

RUN apk add --update 

# Basic tools
RUN apk add \
  git \
  openssh \
  make \
  musl-dev \
  openssl \
  bash

# Python installation
RUN apk add \
  python \
  python-dev \
  py-pip \
  build-base

# AWS Cli
RUN pip install --upgrade awscli

# Terraform
RUN wget https://releases.hashicorp.com/terraform/0.11.11/terraform_0.11.11_linux_amd64.zip -O /tmp/terraform.zip && \
  unzip -d /usr/local/bin/ /tmp/terraform.zip

# Go installation
RUN apk add go

ENV GOROOT /usr/lib/go
ENV GOPATH /go
ENV PATH /go/bin:$PATH

RUN mkdir -p ${GOPATH}/src ${GOPATH}/bin

RUN go get -u github.com/Masterminds/glide/...

WORKDIR $GOPATH

CMD ["make"]

# Parallel
RUN apk add parallel

# Leaving the bin/bash cmd as output
CMD ["/bin/bash"]

