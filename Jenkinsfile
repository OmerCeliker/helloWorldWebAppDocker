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
        sh 'mvn  clean install '
      }
    }
    stage('Analysis') {
      parallel {
        stage('Security') {
          steps {
            sh 'echo running Security'
          }
        }
        stage('Code Quality') {
          steps {
            sh 'echo running Code Quality'
          }
        }
      }
    }
    stage('Tests') {
      parallel {
        stage('IntegrationTest') {
          steps {
            sh 'echo running Integration Test'
          }
        }
        stage('SmokeTest') {
          steps {
            sh 'echo smokeTest'
          }
        }
      }
    }
    stage('TagBuild') {
      steps {
        sh '''#clean prune 
docker system prune --all --force --volumes
cd $WORKSPACE
docker build -t ocel12356/helloworldwebappdocker ./target'''
      }
    }
    stage('PushToDockerHub') {
      steps {
        sh '''
cd $WORKSPACE/target
docker push ocel12356/helloworldwebappdocker '''
      }
    }
    stage('PublishPortRunImage') {
      steps {
        sh '''
         docker kill $( docker ps | grep 8083  | awk \'{print $1}\' ) || true
docker \\
 run -d   -p 8083:8083/tcp  ocel12356/helloworldwebappdocker  '''
      }
    }
  }
}