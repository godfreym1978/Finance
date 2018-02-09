pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                sh "docker run -d --name 'tomcat:secure' "
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
