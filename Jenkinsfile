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
        sh 'mvn  clean install -Dmaven.test.skip=true '
      }
    }
    stage('TagBuild') {
      steps {
        sh '''pwd
docker ps
cd /var/lib/jenkins/workspace/helloWorldWebAppDocker_master@2
docker build -t ocel12356/helloworldwebappdocker ./target'''
      }
    }
    stage('PushToDockerHub') {
      steps {
        sh '''pwd
docker ps
cd /var/lib/jenkins/workspace/helloWorldWebAppDocker_master@2/target
docker push ocel12356/helloworldwebappdocker '''
      }
    }
    stage('PublishPortRunImage') {
      steps {
        sh '''pwd
docker \\
 run -p 8083:8083/tcp  ocel12356/helloworldwebappdocker  &'''
      }
    }
  }
}