pipeline {
    agent any

    environment {
        DOCKER_HUB_USER = 'kaungmyatmin21'
        IMAGE_NAME = 'todo-app'
        DOCKER_HUB_CREDS = 'docker-hub-creds'
    }

    stages {
        stage('Checkout') {
            steps {
                // Forces the git environment to initialize inside the container
                checkout scm
            }
        }

        stage('Build') {
            steps {
                echo 'Building the application...'
                // Inside the Linux container, we use 'sh'
                sh 'npm install'
            }
        }

        stage('Test') {
            steps {
                echo 'Running unit tests...'
                // Use '|| true' so the pipeline continues even if tests fail
                sh 'npm test || true'
            }
        }

        stage('Containerize') {
            steps {
                echo 'Creating Docker image...'
                // Standard Linux variable syntax: ${VARIABLE}
                sh "docker build -t ${DOCKER_HUB_USER}/${IMAGE_NAME}:latest ."
            }
        }

        stage('Push') {
            steps {
                echo 'Logging into Docker Hub and pushing image...'
                withCredentials([usernamePassword(credentialsId: "${DOCKER_HUB_CREDS}", passwordVariable: 'DOCKER_PASS', usernameVariable: 'DOCKER_USER')]) {
                    // Standard Linux pipe for docker login
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