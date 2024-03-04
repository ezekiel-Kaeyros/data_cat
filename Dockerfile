# Base R Shiny image
FROM rocker/shiny

# Installation de l'openjdk
RUN apt-get update && apt-get install -y openjdk-8-jdk

# Exécuter la commande find pour rechercher libjvm.so et copier le chemin dans une variable d'environnement
RUN LIBJVM_PATH=$(find / -name libjvm.so 2>/dev/null) && echo "export LIBJVM_PATH=$LIBJVM_PATH" >> /etc/profile

# Copier la bibliothèque libjvm.so dans le conteneur en utilisant le chemin capturé
# Copier la bibliothèque libjvm.so dans le répertoire du conteneur
COPY $LIBJVM_PATH /usr/lib/jvm/java-8-openjdk-amd64/jre/lib/amd64/server/

# Définir la variable d'environnement LD_LIBRARY_PATH
ENV LD_LIBRARY_PATH=/usr/lib/jvm/java-8-openjdk-amd64/jre/lib/amd64/server:$LD_LIBRARY_PATH


# Make a directory in the container
WORKDIR /app

COPY . /app


# Install libglpk40
RUN apt-get update && apt-get install -y libglpk40

RUN apt-get update && apt-get install -y libsecret-1-0



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
RUN R -e "install.packages('rJava')"
RUN R -e "install.packages('rhino')"
RUN R -e "install.packages('keyring')"
RUN R -e "install.packages('r2d3')"
RUN R -e "remotes::install_github('deepanshu88/shinyDarkmode')"
RUN R -e "install.packages('shiny.i18n')"
RUN R -e "install.packages('googleLanguageR')"


# Expose the application port
EXPOSE 8180

# Run the R Shiny app
CMD ["R", "-e", "shiny::runApp('/app', host = '0.0.0.0', port = 8180)"]