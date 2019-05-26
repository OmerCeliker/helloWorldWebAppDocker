pipeline {
  agent any
  stages {
    stage('PrintEnvVariables') {
      agent any
      steps {
        sh 'echo  $WORKSPACE'
      }
    }
    stage('Build') {
      agent {
        docker {
          image 'maven:3.6.1-jdk-8'
          args '-v  $WORKSPACE/.m2:/root/.m2 '
        }

      }
      steps {
        sh 'mvn  clean install -Dmaven.test.skip=true'
      }
    }
  }
}