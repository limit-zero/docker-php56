FROM limit0/php56:latest

RUN echo 'deb http://apt.newrelic.com/debian/ newrelic non-free' | tee /etc/apt/sources.list.d/newrelic.list
RUN wget -O- https://download.newrelic.com/548C16BF.gpg | apt-key add -
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get -y install newrelic-php5
RUN yes "" | newrelic-install install
