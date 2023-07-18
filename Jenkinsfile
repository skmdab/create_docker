pipeline{

    agent any

    stages{
        stage('Checkout the code'){
            steps{
                git branch: 'main', credentialsId: 'git_token', url: 'https://github.com/skmdab/create_docker_server.git'
            }
        }

        stage('Creating server'){
            steps{
                sh "sh aws_create.sh"
            }
        }

        stage('Installing docker package into server'){
            steps{
                withCredentials([file(credentialsId: 'pemfile', variable: 'PEMFILE')]) {
                    sh "ansible-playbook installdocker.yaml" --private-key=${PEMFILE}
                }
                
            }
        }
    }
}
