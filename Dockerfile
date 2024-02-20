# Base R Shiny image
FROM rocker/shiny


# Make a directory in the container
WORKDIR /app

COPY . /app

# Install libglpk40
RUN apt-get update && apt-get install -y libglpk40

RUN apt-get update && apt-get install -y libsecret-1-0

# install wget and gnupg
RUN apt-get update && apt-get install -my wget gnupg

# install oracle java 8
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections \
    && echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee /etc/apt/sources.list.d/webupd8team-java.list \
    && echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list \
    && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886 \
    && apt-get update \
    && apt-get install oracle-java8-installer -y

# clean local repository
RUN apt-get clean

# set up JAVA_HOME
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

# Install R dependencies
RUN R -e "install.packages('crosstalk')"
RUN R -e "install.packages('dataMaid')"
RUN R -e "install.packages('DBI')"
RUN R -e "install.packages('DiagrammeR')"
RUN R -e "install.packages('dplyr')"
RUN R -e "install.packages('DT')"
RUN R -e "install.packages('lubridate')"
RUN R -e "install.packages('partykit')"
RUN R -e "install.packages('plotly')"
RUN R -e "install.packages('plyr')"
RUN R -e "install.packages('reactable')"
RUN R -e "install.packages('readr')"
RUN R -e "install.packages('readxl')"
RUN R -e "install.packages('shiny')"
RUN R -e "install.packages('shiny.fluent')"
RUN R -e "install.packages('shiny.router')"
RUN R -e "install.packages('shiny.semantic')"
RUN R -e "install.packages('shiny.tailwind')"
RUN R -e "install.packages('shinyauthr')"
RUN R -e "install.packages('shinycssloaders')"
RUN R -e "install.packages('shinydashboard')"
RUN R -e "install.packages('shinyjs')"
RUN R -e "install.packages('shinymanager')"
RUN R -e "install.packages('shinythemes')"
RUN R -e "install.packages('shinyWidgets')"
RUN R -e "install.packages('stringr')"
RUN R -e "install.packages('tibble')"
RUN R -e "install.packages('tools')"
RUN R -e "install.packages('validate')"
RUN R -e "install.packages('viridis')"
RUN R -e "install.packages('XML')"
RUN R -e "install.packages('xml2')"
RUN R -e "install.packages('mailR')"
#RUN R -e "install.packages('rJava')"
RUN R -e "install.packages('rhino')"
RUN R -e "install.packages('keyring')"
RUN R -e "install.packages('r2d3')"


# Expose the application port
EXPOSE 8180

# Run the R Shiny app
CMD ["R", "-e", "shiny::runApp('/app', host = '0.0.0.0', port = 8180)"]
