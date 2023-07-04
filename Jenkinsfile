pipeline{

    agent any

    stages{
        stage('Checkout the code'){
            steps{
                git branch: 'main', credentialsId: 'f1458e0b-2e10-40f0-aa9b-6070a8514a7c', url: 'https://github.com/skmdab/create_docker_server.git'
            }
        }

        stage('Creating server'){
            steps{
                sh "sh aws_create.sh"
            }
        }

        stage('Installing docker package into server'){
            steps{
                sh "ansible-playbook installdocker.yaml"
            }
        }
    }
}
