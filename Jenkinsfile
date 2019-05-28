pipeline {
  agent any
  stages {
    stage('PrintEnvVariables') {
      agent any
      steps {
        sh 'echo  $WORKSPACE'
      }
    }
    stage('Tests') {
      parallel {
        stage('UnitTest') {
          agent {
            docker {
              image 'maven:3.6.1-jdk-8'
              args '-v  $WORKSPACE/.m2:/root/.m2 '
            }

          }
          steps {
            sh 'mvn clean test '
          }
        }
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
    stage('TagBuild') {
      steps {
        sh '''#clean prune 
docker system prune --all --force --volumes

cd /var/lib/jenkins/workspace/helloWorldWebAppDocker_master@2
docker build -t ocel12356/helloworldwebappdocker ./target'''
      }
    }
    stage('PushToDockerHub') {
      steps {
        sh '''
cd /var/lib/jenkins/workspace/helloWorldWebAppDocker_master@2/target
docker push ocel12356/helloworldwebappdocker '''
      }
    }
    stage('PublishPortRunImage') {
      steps {
        sh '''
         docker kill $( docker ps | grep 8083  | awk \'{print $1}\' ) || true
docker \\
 run -p 8083:8083/tcp  ocel12356/helloworldwebappdocker  &'''
      }
    }
  }
  post {
    always {
      archiveArtifacts(artifacts: '**/gs*.jar', fingerprint: true)
    }

  }
}
