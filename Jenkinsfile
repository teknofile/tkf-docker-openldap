pipeline {
  agent {
    label 'X86-64-MULTI'
  }

  stages {
    // Run SHellCheck
    stage('ShellCheck') {
      steps {
        sh '''docker run --rm -t -v "${WORKSPACE}/root":/scan:ro teknofile/tkf-docker-shellcheck:dev /scripts/find_and_check.sh > shellcheck.xml'''
      }
    }
  }
}
