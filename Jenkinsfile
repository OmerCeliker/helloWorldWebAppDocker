pipeline {
  agent any
  stages {
    stage('Build') {
      agent {
        docker {
          image 'maven:latest'
          args '-v -v $WORKSPACE/.m2:/root/.m2 '
        }

      }
      steps {
        sh 'mvn  clean package -Dmaven.test.skip=true'
      }
    }
  }
}
