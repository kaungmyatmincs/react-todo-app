pipeline {
    agent any

    environment {
        DOCKER_HUB_USER = 'kaungmyatmin21'
        IMAGE_NAME = 'todo-app'
        IMAGE_TAG = 'latest'
    }

    stages {
        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image...'
                bat "docker build -t %DOCKER_HUB_USER%/%IMAGE_NAME%:%IMAGE_TAG% ."
            }
        }

        stage('Push to Docker Hub') {
            steps {
                echo 'Pushing to Docker Hub...'
                bat "docker push %DOCKER_HUB_USER%/%IMAGE_NAME%:%IMAGE_TAG%"
            }
        }
    }

    post {
        success {
            echo 'Pipeline succeeded!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}