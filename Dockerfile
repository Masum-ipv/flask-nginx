FROM python:3.6.4
MAINTAINER Masum <fakhrulislamcuet@gmail.com>

# Environment setting
ENV APP_ENVIRONMENT production

# Flask demo application
COPY ./app /app
RUN apt-get update
RUN pip install -r requirements.txt

# Nginx configuration
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/conf.d/nginx.conf

# Supervisor configuration
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY gunicorn.conf /etc/supervisor/conf.d/gunicorn.conf

# Gunicorn default configuration
COPY gunicorn.config.py /app/gunicorn.config.py

WORKDIR /app

EXPOSE 80 443

CMD ["/usr/bin/supervisord"]
