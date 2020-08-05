FROM rocker/rstudio:4.0.0

ENV LANG ja_JP.UTF-8
ENV LC_ALL ja_JP.UTF-8

RUN apt-get update -y \
  && apt-get install -y --no-install-recommends\
    apt-utils \
    build-essential \
    libv8-dev \
    vim \
    libnlopt-dev \
    cmake \
    git \
    libzmq3-dev \
    libudunits2-dev \
    libgdal-dev \
    gdal-bin \
    libproj-dev \
    proj-data \
    proj-bin \
    libgeos-dev \
    liblz4-tool \
    librsvg2-dev \
    libbz2-dev \
    fonts-ipaexfont \
  && rm -rf /var/lib/apt/lists/* \
  && apt-get clean

# Language and tz setting
RUN sed -i '$d' /etc/locale.gen \
  && echo "ja_JP.UTF-8 UTF-8" >> /etc/locale.gen \
	&& locale-gen ja_JP.UTF-8 \
	&& /usr/sbin/update-locale LANG=ja_JP.UTF-8 LANGUAGE="ja_JP:ja"
RUN /bin/bash -c "source /etc/default/locale"
RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

# Fix libraries and their versions to install
COPY lib_names.csv ./
COPY install_libraries.R ./
COPY Rprofile.txt ~/.Rprofile

RUN echo 'www-port=8888' > /etc/rstudio/rserver.conf \
  && Rscript -e "install.packages(c('littler', 'docopt', 'remotes'))"

# Install R libraries
RUN Rscript install_libraries.R \
  && rm install_libraries.R lib_names.csv

# Install lightgbm
RUN git clone --recursive https://github.com/microsoft/LightGBM \
  && cd LightGBM \
  && mkdir build \
  && cd build \
  && cmake .. \
  && make -j4 \
  && cd ../ \
  && Rscript build_r.R \
  && cd / \
  && rm -r /LightGBM

EXPOSE 8888

CMD ["/init"]
