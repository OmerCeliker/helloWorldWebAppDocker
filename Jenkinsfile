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
docker system prune --all --force --volumes || true
cd /var/lib/jenkins/workspace/helloWorldWebAppDocker_master@2
docker build -t ocel12356/helloworldwebappdocker ./target'''
      }
    }
    stage('PushToDockerRepo') {
      steps {
        sh '''
cd /var/lib/jenkins/workspace/helloWorldWebAppDocker_master@2/target
docker push ocel12356/helloworldwebappdocker '''
      }
    }
    stage('PublishService') {
      steps {
        sh '''
        cp -v /var/lib/jenkins/workspace/helloWorldWebAppDocker_master@2/Route53.json . 
 java -jar $JENKINS_HOME/sshclient-1.0.0.jar -o ./Route53.json -d tsangularbackend -u ubuntu -s ec2-18-216-4-38.us-east-2.compute.amazonaws.com -i $JENKINS_HOME/ohio.pem -r 1 -m ocel12356/helloworldwebappdocker -p 8083
         '''
      }
    }
  }
}
