pipeline {
    agent {
        label 'AGENT1'
    }

    environment {
        appVersion = ''
        REGION="us-east-1"
        ACCOUNT_ID="517695827891"
        PROJECT="roboshop"
        COMPONENT="catalogue"
    }

    options {
        disableConcurrentBuilds()
        timeout(time:30, unit:'MINUTES') 
    }

    stages {
        // install pipeline utility steps
        stage('Read package.json') {
            steps {
                script {
                    // Read the entire package.json file into a Groovy object
                    def packageJSON = readJSON file: 'package.json'
                    
                    // Access specific properties, such as 'version' or 'name'
                    appVersion = packageJSON.version
                    def appName = packageJSON.name

                    // Log the values
                    echo "Application Name: ${appName}"
                    echo "Application Version: ${appVersion}"
                }
            }
        }

        //ssh into agent and first install npm and then run this file
        stage('Install Dependencies stage') {
            steps {
                script {
                    """
                        npm install
                    """
                }
            }
        }

        //install aws credentials and aws steps plugins before this
        stage('Docker Build') {
            steps {
                script {
                    """
                        withAWS(credentials: 'aws-creds', region: 'us-east-1'){
                            aws ecr get-login-password --region ${REGION} | docker login --username AWS --password-stdin ${ACCOUNT_ID}.dkr.ecr.us-east-1.amazonaws.com
                            docker tag roboshop/catalogue:v1 ${ACCOUNT_ID}.dkr.ecr.us-east-1.amazonaws.com/roboshop/catalogue:v1
                            docker push ${ACCOUNT_ID}.dkr.ecr.us-east-1.amazonaws.com/roboshop/catalogue:v1
                        }
                    """
                }
            }
        }
    }
}