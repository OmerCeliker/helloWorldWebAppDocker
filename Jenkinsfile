/*
https://jenkins.io/doc/book/pipeline/docker/
*/

pipeline {
  agent any
  stages {
    
    stage('Build') {
      
        agent {
        docker { 
                image 'maven:3.3-jdk-8' 
                 args  '-v $(pwd):/usr/src/mymaven  -w /usr/src/mymaven '
               
               }
            }
      
      
      steps {
        sh 'mvn -version'
      }
    }
    
  }
  
  
}
