FROM jupyter/datascience-notebook:latest

USER root
RUN apt update
RUN apt install -y curl
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
RUN apt install -y pandoc
RUN apt install -y texlive-xetex texlive-fonts-recommended texlive-plain-generic


ENV PATH="/root/.cargo/bin:${PATH}"

RUN pip install nltk
RUN python -m nltk.downloader all

COPY requirements.txt /usr/src/requirements.txt
RUN pip install --no-cache-dir -r /usr/src/requirements.txt

USER ${NB_UID}

COPY packages.R ./packages.R 
RUN Rscript ./packages.R