pipeline {
  agent {
    label 'X86-64-MULTI'
  }

  environment {
    CONTAINER_NAME = 'tkf-docker-openldap'
    TKF_USER = 'teknofile'

  }

  stages {
    // Run SHellCheck
    stage('ShellCheck') {
      steps {
        sh '''echo "TODO: Determine a good strategy for finding and scanning shell code"'''
      }
    }
    stage('Docker Build x86') {
      steps {
        sh "docker build --no-cache --pull -t ${TKF_USER}/${CONTAINER_NAME}:amd64 ."
      }
    }
    stage('Docker Push x86') {
      steps {
        withCredentials([
          [
            $class: 'UsernamePasswordMultiBinding',
            credentialsId: 'teknofile-docker-creds',
            usernameVariable: 'DOCKERUSER',
            passwordVariable: 'DOCKERPASS'
          ]
        ]) {
          echo 'Logging into DockerHub'
          sh '''#! /bin/bash
            echo $DOCKERPASS | docker login -u $DOCKERUSER --password-stdin
            '''
          sh "docker tag ${TKF_USER}/${CONTAINER_NAME} ${TKF_USER}/${CONTAINER_NAME}:latest"
          sh "docker push ${IMAGE}:latest"
        }
      }
    }
  }
}
