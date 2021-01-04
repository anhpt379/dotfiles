FROM centos:centos7.9.2009

RUN curl 'https://download.opensuse.org/repositories/shells:/fish:/release:/3/RHEL_7/shells:fish:release:3.repo' -o /etc/yum.repos.d/fish.repo

RUN yum update -y && yum install -y fish && yum clean all

RUN fish --version
