pipeline {
  agent any

  environment {
    def scmVars = checkout scm
    IMAGE='node-web-app'
    REGISTRY='finneganhu'
  }

  options {
    buildDiscarder(logRotator(numToKeepStr: '5'))
    timeout(time: 30, unit: 'MINUTES')
    disableConcurrentBuilds()
  }

  stages {
    stage('Build Image') {
      steps {
        sh """
          docker build -t ${env.REGISTRY}/${env.IMAGE}:latest .
        """
      }
    }
  }

  post {
    always {
      cleanWs()
      wsCleaner()
    }
    cleanup {
      sh "docker rmi ${env.REGISTRY}/${env.IMAGE} || exit 0"
    } 
  }
}