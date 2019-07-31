pipeline {
  agent {
    label 'X86-64-MULTI'
  }

  stages {
    // Run SHellCheck
    stage('ShellCheck') {
      steps {
        sh '''#!/bin/bash
              set -e
              docker run --rm \
              -v ${WORKSPACE}/root:/scan:ro \
              -t teknofile/tkf-docker-shellcheck:dev \
              /scripts/find_and_check.sh'''
      }
    }
  }
}
