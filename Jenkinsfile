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
                
                echo 'creating .env file'
                
                sh '''
                echo "# Host configuration
                PORT=8080
                HOST=0.0.0.0
                NODE_ENV=development
                HOST_URL=http://20.74.41.65:8080
                COOKIE_ENCRYPT_PWD=superAwesomePasswordStringThatIsAtLeast32CharactersLong!
                
                # Okta configuration
                OKTA_ORG_URL=https://dev-19252361.okta.com
                OKTA_CLIENT_ID=0oakcgiuqSqdOXynT5d6
                OKTA_CLIENT_SECRET=3QYagrVr4BIOV5Z3Bv1ldnhYfbwWc95a5vaU7cLk
                
                # Postgres configuration
                PGHOST=10.0.0.20
                PGUSERNAME=postgres
                PGDATABASE=postgres
                PGPASSWORD=p@ssw0rd42
                PGPORT=5432" > .env
                '''
            }
            
            
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
