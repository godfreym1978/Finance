pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                sh "docker run -d -p 8888:8080  tomcat:secure "
                echo 'Building..'
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}
