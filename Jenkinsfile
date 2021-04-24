pipeline {
    agent {label "slave_build"}

    stages {
        stage('Downlod_to_BlubStorage') {
            steps {
                // TODO - understanding how to save
                echo 'Downloding to Blub storage'
            }
        }
        stage('Build') {
            steps {                
                echo 'Building..'
                
                sh 'sudo apt-get install -y nodejs'
                sh 'sudo apt install -y npm'
                sh 'npm install'
                sh 'npm run initdb'
                sh 'npm run dev'
                
                echo 'Finished building process'
                
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
