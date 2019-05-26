pipeline {
  agent any
  stages {
    stage('CreateBuildDir') {
      agent any
      steps {
        sh 'mkdir /var/lib/jenkins/workspace/helloWorldWebAppDocker_build'
      }
    }
    stage('Build') {
      agent {
        docker {
          image 'maven:3.6.1-jdk-11-slim'
          args '-v /var/lib/jenkins/workspace/helloWorldWebAppDocker_build:/usr/src/mymaven  -w /usr/src/mymaven '
        }

      }
      steps {
        sh 'mvn clean package'
      }
    }
  }
}