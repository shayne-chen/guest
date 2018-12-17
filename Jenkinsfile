pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                sudo echo 'Building..'>>/home/mobvoi/result
		sudo sh /home/mobvoi/jenkins.sh
            }
        }
        stage('Test') {
            steps {
		sudo echo 'Testing..'>>/home/mobvoi/result
                sudo sh /home/mobvoi/jenkins.sh
            }
        }
        stage('Deploy') {
            steps {
                sudo echo 'Deploying....'>>/home/mobvoi/result
		sudo sh /home/mobvoi/jenkins.sh
            }
        }
    }
}
