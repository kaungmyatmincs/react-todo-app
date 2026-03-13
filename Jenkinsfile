pipeline {
    agent any

    environment {
        DOCKER_HUB_USER = 'kaungmyatmin21'
        IMAGE_NAME = 'todo-app'
        DOCKER_HUB_CREDS = 'docker-hub-creds'
    }

    stages {
        stage('Build') {
            steps {
                echo 'Building the application...'
                sh 'npm install'
            }
        }

        stage('Test') {
            steps {
                echo 'Running unit tests...'
                sh 'npm test || true'
            }
        }

        stage('Containerize') {
            steps {
                echo 'Creating Docker image...'
                sh "docker build -t ${DOCKER_HUB_USER}/${IMAGE_NAME}:latest ."
            }
        }

        stage('Push') {
            steps {
                echo 'Logging into Docker Hub and pushing image...'
                withCredentials([usernamePassword(credentialsId: "${DOCKER_HUB_CREDS}", passwordVariable: 'DOCKER_PASS', usernameVariable: 'DOCKER_USER')]) {
                    sh "echo \$DOCKER_PASS | docker login -u \$DOCKER_USER --password-stdin"
                    sh "docker push ${DOCKER_HUB_USER}/${IMAGE_NAME}:latest"
                }
            }
        }
    }

    post {
        always {
            echo 'Cleaning up workspace...'
            sh "docker rmi ${DOCKER_HUB_USER}/${IMAGE_NAME}:latest || true"
        }
    }
}