FROM public.ecr.aws/lambda/provided:al2-x86_64

RUN yum -y install wget git tar

ENV R_VERSION=4.1.2

RUN yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
  && wget https://cdn.rstudio.com/r/centos-7/pkgs/R-${R_VERSION}-1-1.x86_64.rpm \
  && yum -y install R-${R_VERSION}-1-1.x86_64.rpm \
  && rm R-${R_VERSION}-1-1.x86_64.rpm

ENV PATH="${PATH}:/opt/R/${R_VERSION}/bin/"

# System requirements for R packages
RUN yum -y install openssl-devel

RUN mkdir /lambda
RUN mkdir /lambda/.cmdstan

RUN Rscript -e "install.packages('remotes', repos = 'https://packagemanager.rstudio.com/all/__linux__/centos7/latest')"
RUN Rscript -e "remotes::install_github('mdneuzerling/lambdr')"
RUN Rscript -e "install.packages('cmdstanr', repos = c('https://stan-dev.r-universe.dev', 'https://packagemanager.rstudio.com/all/__linux__/centos7/latest'))"
RUN Rscript -e "cmdstanr::install_cmdstan(dir = '/lambda/.cmdstan', version = '2.35.0')"
RUN Rscript -e "cmdstanr::set_cmdstan_path(path = '/lambda/.cmdstan/cmdstan-2.35.0')"

ENV CMDSTAN="/lambda/.cmdstan/cmdstan-2.35.0"
RUN Rscript -e "remotes::install_github('seroanalytics/epikinetics')"

COPY runtime.R /lambda
RUN chmod 755 -R /lambda

RUN printf '#!/bin/sh\ncd /lambda\nRscript runtime.R' > /var/runtime/bootstrap \
  && chmod +x /var/runtime/bootstrap

CMD ["run_model"]