FROM python:3.6
MAINTAINER "Two Six Labs <magicwand@twosixlabs.com>"

# Configure Environment
USER root
ENV PYTHONUNBUFFERED=1
ENV ENVIRONMENT="development"
ENV APP_ROOT=/ctodd-python-flask-api-template/
ENV FLASK_APP=/ctodd-python-flask-api-template/app/app.py

# Run Installation commands, make directories, and add project files
WORKDIR ${APP_ROOT}
RUN mkdir -p ${APP_ROOT}
ADD . ${APP_ROOT}

# Install Linux Dependencies
RUN apt-get update; apt-get install -y < docker_environment/linux_packages.txt

# Install Python Dependencies
RUN pip3 install -U pip; pip3 install -r docker_environment/python_packages.txt

# Clean Up Installs
RUN xargs rm -rf < docker_environment/directory_cleanup.txt

# Set Health Check
HEALTHCHECK CMD ["bash", "healthcheck.sh"] || exit 1

# Set Port to Expost (8009 external and 5000 internal)
EXPOSE 8009:5000

# Set Command and Entrypoint
ENTRYPOINT ["/bin/bash"]
CMD ["run-command.sh"]
