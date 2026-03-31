pipeline {
    agent {
        label 'AGENT1'
    }

    environment {
        appVersion = ''
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

        stage('Install Dependencies stage') {
            steps {
                script {
                    """
                        npm install
                    """
                }
            }
        }


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