//before running this pipeline install these plugins
//stage view,pipeline utility steps,aws credentials,aws steps plugins
// in the worker node install docker,node js before hand
pipeline {
    agent {
        label 'AGENT1'
    }

    environment {
        REGION = "us-east-1"
        ACCOUNT_ID = "517695827891"
        PROJECT = "roboshop"
        COMPONENT = "catalogue"
    }

    options {
        disableConcurrentBuilds()
        timeout(time: 30, unit: 'MINUTES') 
    }

    stages {

        stage('Read package.json') {
            steps {
                script {
                    def packageJSON = readJSON file: 'package.json'
                    env.appVersion = packageJSON.version
                    def appName = packageJSON.name

                    echo "Application Name: ${appName}"
                    echo "Application Version: ${env.appVersion}"
                }
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'npm install'
            }
        }

        stage('Docker Build & Push') {
            steps {
                withAWS(credentials: 'aws-creds', region: "${REGION}") {
                    sh """
                        aws ecr get-login-password --region ${REGION} | docker login --username AWS --password-stdin ${ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com

                        docker build -t ${PROJECT}/${COMPONENT}:${env.appVersion} .

                        docker tag ${PROJECT}/${COMPONENT}:${env.appVersion} ${ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com/${PROJECT}/${COMPONENT}:${env.appVersion}

                        docker push ${ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com/${PROJECT}/${COMPONENT}:${env.appVersion}
                    """
                }
            }
        }
    }
}