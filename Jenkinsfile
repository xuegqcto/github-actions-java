      node ('master') { 
        checkout scm 
        stage('Build') { 
          withMaven(maven: 'mvn') { 
            if (isUnix()) { 
              sh 'mvn -Dmaven.test.failure.ignore clean package' 
            }  
            else { 
              bat 'mvn -Dmaven.test.failure.ignore clean package' 
            } 
          } 
        }   
        stage('Results') { 
         
          archiveArtifacts 'target/*.jar' 
        } 
      } 
