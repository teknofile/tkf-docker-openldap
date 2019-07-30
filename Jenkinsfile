pipeline {
  agent {
    label 'X86-64-MULTI'
  }

  stages {
    // Run SHellCheck
    stage('ShellCheck') {
      steps {
        sh '''docker pull lsiodev/shellcheck'''
        sh '''docker run --rm=true -t -v ${WORKSPACE}/root:/root lsiodev/shellcheck find root/ -type f -exec shellcheck --exclude=SC1008 --format=checkstyle --shell=bash {} +'''
      }
    }
  }
}
