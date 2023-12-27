pipeline { 
    environment { 
        repository = "yangsungsoo/webbuild"  
        dockerImage = ''
       registry = 'public.ecr.aws/k3f1h3u2/btc3-ecr'
       app = '' 
  }
  agent any
  
  stages { 
      stage('Building our image') { 
          steps { 
              script {
                  sh "docker build -t $repository:$BUILD_NUMBER ." 
              }
          } 
      }
      stage('Push Image') {
            steps {
                script{
                     sh "aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/k3f1h3u2/btc3-ecr"
                     sh "docker tag beanbeeean/onboarding:$BUILD_NUMBER public.ecr.aws/k3f1h3u2/btc3-ecr"
                     sh "docker push public.ecr.aws/k3f1h3u2/btc3-ecr"
                    }
                }
            }
      stage('Cleaning up') { 
        steps { 
              sh "docker rmi $repository:$BUILD_NUMBER" 
          }
      } 
  }
}
