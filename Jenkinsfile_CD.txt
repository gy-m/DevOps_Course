pipeline {
    agent {label "slave_ci"}

    stages {
            
        stage('Build') {
            // Creating env file 
            steps {
                    echo 'Building..'
                    script {
                    
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
            }
        }
        
        stage('Deploy') {
           // Running the application 
            steps {
                echo 'Deploying....'
                
                sh 'curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -'
                sh 'sudo apt-get install -y nodejs'
                sh 'sudo apt-get install -y build-essential'
                //sh 'cd workspace/pipeline-build'
                sh 'npm install'
                sh 'npm run initdb'
                sh 'sudo npm install pm2 -g'                                 // install pm2
                sh 'pm2 stop src/index.js'
                sh 'pm2 start src/index.js'
                sh 'pm2 save'
                //sh 'pm2 start npm -- run dev'                           // run "npm run dev" as a service in the background using pm2
                //sh 'npm run dev'
                
                echo 'Finished building process'
                
            }
        }
        stage('Test') {
            // TODO: Tesing
            steps {
                echo 'Testing..'
            }
        }
    }

    post {
        always {
            echo 'Creating tar.gz file for artifacts'
            sh 'tar -zcvf /home/proj_admin/my_archive.tar.gz /home/proj_admin/workspace/pipeline-build'
            archiveArtifacts artifacts: 'my_archive.tar.gz', onlyIfSuccessful: true
        }
    }
}
