# Jenkinsonar

## Overview

This project demonstrates a CI/CD pipeline using Jenkins to:

- Checkout code from multiple SCMs.

- Perform SonarQube analysis.

- Build and deploy Docker images.

- Send email notifications upon build success or failure.

## Setup

### Prerequisites

- Jenkins

- Docker

- Maven

- SonarQube

### Jenkins Pipeline

The Jenkins pipeline is defined in the `Jenkinsfile`. Ensure that the following plugins are installed:

- Git Plugin

- Multiple SCMs Plugin

- SonarQube Scanner for Jenkins

- Docker Plugin

- Email Extension Plugin

### Running the Pipeline

1\. Configure Jenkins parameters and credentials as described in the `Jenkinsfile`.

2\. Trigger the Jenkins pipeline.

### Additional Files

- `Dockerfile`: Defines the Docker image build process.

- `sonar-project.properties`: Configuration for SonarQube analysis.

- `pom.xml`: Maven configuration and dependencies.

- `.gitignore`: Excludes unnecessary files from the repository.

#
