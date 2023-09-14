pipeline {
    agent { label 'JDK-17' }
    triggers { pollSCM ('* * * * *') }
    parameters {
        choice(name: 'MAVEN_GOAL', choices: ['package', 'install', 'clean'], description: 'Maven Goal')
    }
    stages {
        stage('vcs') {
            steps {
                git url: 'https://github.com/imsimranmohanty/spring-framework-new.git,
                    branch: 'master'
            }
        }
        stage('build') {
            steps {
                sh "mvn ${params.MAVEN_GOAL}"
				}
        }
        stage('post build') {
            steps {
                junit testResults: '**/surefire-reports/TEST-*.xml'
            }
        }
        stage('docker image build & push') {
            steps {
                sh 'docker image build -t simranmohanty/spcnow:1.0 .'
                sh 'docker image push simranmohanty/spcnow:1.0'
            }
        }
		stage('deploy on k8s') {
		    agent { label 'K8S_DEPLOY' }
			steps {
			    sh 'kubectl apply -f deployment.yaml'
				sh 'kubectl apply -f service.yaml'
			}
		}
    }
}