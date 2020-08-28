pipeline {
  agent any

  environment {
    def scmVars = checkout scm
    IMAGE='node-web-app'
    NAMESPACE='finneganhu'
    REGCREDS='finneganhu_dockerhub'
    TAG_NAME='latest'
  }

  options {
    buildDiscarder(logRotator(numToKeepStr: '5'))
    timeout(time: 30, unit: 'MINUTES')
    disableConcurrentBuilds()
  }

  stages {
    stage('Build, tag and push release to registry') {
      steps {
        buildPushImage(
          namespace: "${env.NAMESPACE}",
          image: "${env.IMAGE}",
          tag: "${env.TAG_NAME}",
          credentials: "${env.REGCREDS}"
        )
      }
    }
  }

  post {
    always {
      cleanWs()
      wsCleaner()
    }
    cleanup {
      sh "docker rmi ${env.NAMESPACE}/${env.IMAGE}:${env.TAG_NAME} || exit 0"
    } 
  }
}