pipeline { 
    environment { 
        repository = "btc3yssrepo"  
        dockerImage = ''
       registry = 'public.ecr.aws/k3f1h3u2/btc3yssrepo'
       app = '' 
  }
  agent any

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
                     sh "docker tag $repository:${currentBuild.number} $registry:$BUILD_NUMBER"
                     sh "docker push public.ecr.aws/k3f1h3u2/$repository:$BUILD_NUMBER"
                    }
                }
            }
      stage('Cleaning up') { 
        steps { 
              sh "docker rmi $repository:$BUILD_NUMBER" 
          }
      } 
      stage('Git Clone and Modify yaml') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'ystdgd07', usernameVariable: 'username', passwordVariable: 'password')]) {
                        sh """
                        git config user.email "ysotgood@gmail.com"
                        git config user.name "yangsungsoo"
                        sed -i "s/tag:.*/tag: $BUILD_NUMBER/g" ./charts/web/values.yaml
                        git add .
                        git commit -m "Update yaml file $BUILD_NUMBER"
                        git push -u origin master
                        """
                    }
                }
            }
        }
  }
}
