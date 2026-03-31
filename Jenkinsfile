pipeline {
    agent {
        label 'AGENT1'
    }

    environment {
        COURSE='Devops'
    }

    options {
        disableConcurrentBuilds()
        timeout(time:30, unit:'MINUTES') 
    }

    parameters {
        string(name: 'BRANCH', defaultValue: 'CSE', description: 'BRANCH name')
    }

    stages {
        stage('Build') {
            steps {
                echo 'Building..'
                echo "${COURSE} is very good"
                echo "${params.BRANCH} is bad"
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
                script{
                    if(params.BRANCH == 'CSE'){
                        echo 'CSE branch using groovy method'
                    }else{
                        echo 'Other branch using groovy method'
                    }
                }
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
                script{
                    sh '''
                    echo "Deploying using shell script method"
                    '''
                }
            }
        }
    }

    post {
        always {
            echo 'This will always run'
            //deleteDir()
        }
        success {
            echo 'This will run only if the build succeeds!!!'
        }
        failure {
            echo 'This will run only if the build fails'
        }
    }
}