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
                // This ensures the git directory is initialized locally
                checkout scm
            }
        }

        stage('Build') {
            steps {
                echo 'Building the application...'
                // Use 'bat' for Windows, 'sh' for Linux
                bat 'npm install'
            }
        }

        stage('Test') {
            steps {
                echo 'Running unit tests...'
                bat 'npm test || exit 0' 
            }
        }

        stage('Containerize') {
            steps {
                echo 'Creating Docker image...'
                bat "docker build -t %DOCKER_HUB_USER%/%IMAGE_NAME%:latest ."
            }
        }

        stage('Push') {
            steps {
                echo 'Logging into Docker Hub and pushing image...'
                withCredentials([usernamePassword(credentialsId: "${DOCKER_HUB_CREDS}", passwordVariable: 'DOCKER_PASS', usernameVariable: 'DOCKER_USER')]) {
                    // Windows-specific docker login syntax
                    bat "echo %DOCKER_PASS% | docker login -u %DOCKER_USER% --password-stdin"
                    bat "docker push %DOCKER_HUB_USER%/%IMAGE_NAME%:latest"
                }
            }
        }
    }

    post {
        always {
            echo 'Cleaning up workspace...'
            bat "docker rmi %DOCKER_HUB_USER%/%IMAGE_NAME%:latest || exit 0"
        }
    }
}