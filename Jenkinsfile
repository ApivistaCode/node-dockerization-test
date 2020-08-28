pipeline {
  agent any

  environment {
    def scmVars = checkout scm
    IMAGE='node-web-app'
    REGISTRY='finneganhu'
    CREDENTIAL='finneganhu_dockerhub'
    dockerImage=''
  }

  options {
    buildDiscarder(logRotator(numToKeepStr: '5'))
    timeout(time: 30, unit: 'MINUTES')
    disableConcurrentBuilds()
  }

  stages {
    // stage('Build Image') {
    //   steps {
    //     sh """
    //       docker build -t ${env.REGISTRY}/${env.IMAGE}:latest .
    //     """
    //   }
    // }
    // stage('Push Image to Registry') {
    //   steps {
    //     script {
    //       docker.withRegistry( '', registryCredential ) {
    //       dockerImage.push()
    //       }
    //     }
    //   }
    // }
    stage('Build image') {
      steps {
        script {
          dockerImage = docker.build REGISTRY + "/" + IMAGE + ":latest"
        }
      }
    }
    stage('Deploy image') {
      steps {
        script {
          docker.withRegistry( '', CREDENTIAL ) {
            dockerImage.push
          }
        }
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