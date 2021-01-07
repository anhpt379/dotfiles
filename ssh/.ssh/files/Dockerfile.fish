FROM centos:centos7.9.2009

RUN curl 'https://download.opensuse.org/repositories/shells:/fish:/nightly:/master/CentOS_7/shells:fish:nightly:master.repo' -o /etc/yum.repos.d/fish.repo

RUN yum install -y fish && yum clean all

RUN fish --version
