# Base R Shiny image
FROM rocker/shiny
FROM semoss/docker-r

# Make a directory in the container
WORKDIR /app

COPY . /app

# Install libglpk40
RUN apt-get update && apt-get install -y libglpk40
#RUN apt-get update && apt-get install -y libsecret-1-0

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
