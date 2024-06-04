pipeline {
    agent any

    parameters {
        string(name: 'DOCKER_IMAGE', defaultValue: 'my-docker-image', description: 'Docker image name')
        string(name: 'EMAIL_RECIPIENT', defaultValue: 'zubin.00007@gmail.com', description: 'Email recipient for notifications')
    }

    stages {
        stage('Install Plugins') {
            steps {
                script {
                    def plugins = ['git', 'multiple-scms', 'sonar', 'docker-plugin', 'email-ext']
                    plugins.each { plugin ->
                        if (!Jenkins.instance.pluginManager.getPlugin(plugin)) {
                            Jenkins.instance.updateCenter.getPlugin(plugin).deploy(true)
                        }
                    }
                }
            }
        }

        stage('Checkout Code') {
            steps {
                checkout([$class: 'MultipleSCM',
                          scmList: [
                            [$class: 'GitSCM',
                             branches: [[name: '*/main']],
                             doGenerateSubmoduleConfigurations: false,
                             extensions: [],
                             submoduleCfg: [],
                             userRemoteConfigs: [[url: 'https://github.com/mediocrates97/infracraft.git']]],
                            [$class: 'GitSCM',
                             branches: [[name: '*/main']],
                             doGenerateSubmoduleConfigurations: false,
                             extensions: [],
                             submoduleCfg: [],
                             userRemoteConfigs: [[url: 'https://github.com/mediocrates97/terransible.git']]]
                          ]
                ])
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarQube') {
                    sh 'mvn clean verify sonar:sonar'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build(params.DOCKER_IMAGE)
                }
            }
        }

        stage('Deploy Docker Image') {
            steps {
                script {
                    withCredentials([sshUserPrivateKey(credentialsId: 'deploy-server-credentials', keyFileVariable: 'SSH_KEY')]) {
                        sh "docker save ${params.DOCKER_IMAGE} | bzip2 | ssh -i $SSH_KEY user@remote-server 'bunzip2 | docker load'"
                    }
                }
            }
        }
    }

    post {
        success {
            mail to: params.EMAIL_RECIPIENT,
                 subject: "Jenkins Build Successful",
                 body: "The Jenkins build was successful."
        }
        failure {
            mail to: params.EMAIL_RECIPIENT,
                 subject: "Jenkins Build Failed",
                 body: "The Jenkins build failed. Please check the logs."
        }
    }
}
