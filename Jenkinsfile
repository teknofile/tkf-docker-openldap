pipeline {
  agent {
    label 'X86-64-MULTI'
  }

  stages {
    // Run SHellCheck
    stage('ShellCheck') {
      steps {
        sh '''find "./root" \
                -type f \
                -exec docker run --rm -i -v "${WORKSPACE}/root:/mnt" \
                koalaman/shellcheck:stable {} +'''
      }
    }
  }
}
