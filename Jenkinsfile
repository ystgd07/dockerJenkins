pipeline { 
    environment { 
        repository = "btc3yssrepo"  
        dockerImage = ''
       registry = 'public.ecr.aws/k3f1h3u2/btc3-ecr'
       app = '' 
  }
  agent any
  def now = new Date()
  def IMAGE_VERSION = now.format("yyyyMMddHHmm")
  stages { 
      stage('Building our image') { 
          steps { 
              script {
                  sh "docker build -t $repository:${currentBuild.number} ." 
              }
          } 
      }
      stage('Push Image') {
            steps {
                script{
                     sh "aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/k3f1h3u2/$repository"
                     sh "docker tag $repository:${currentBuild.number} public.ecr.aws/k3f1h3u2/$repository:${currentBuild.number}"
                     sh "docker tag $repository:${currentBuild.number-1} public.ecr.aws/k3f1h3u2/btc3-ecr/yangsungsoo:${currentBuild.number-1}"
                     sh "docker push public.ecr.aws/k3f1h3u2/$repository:${currentBuild.number}"
                     sh "docker push public.ecr.aws/k3f1h3u2/$repository::${currentBuild.number-1}"
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
