pipeline {
  agent any
  stages {
    stage('Build') {
      agent {
        docker {
          image 'maven:3-alpine'
          args '-v -v $WORKSPACE/.m2:/root/.m2 '
        }

      }
      steps {
        sh 'mvn  clean package -Dmaven.test.skip=true'
      }
    }
  }
}
