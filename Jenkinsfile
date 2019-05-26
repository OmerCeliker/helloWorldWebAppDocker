pipeline {
  agent any
  stages {
    stage('Build') {
      agent {
        docker {
          image 'maven:3.6.1-jdk-11-slim'
          args '-v \"$(pwd)\":/usr/src/mymaven  -w /usr/src/mymaven '
        }

      }
      steps {
        sh 'mvn -version'
      }
    }
  }
}
