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
                   sshagent (credentials: ['jenkins-ssh']) {
                        sh """
                        git config --global user.email "ysotgood@gmail.com"
                        git config --global user.name "yangsungsoo"
                        rm -rf argorepo
                        git clone git@github.com:ystgd07/argorepo.git
                        cd ./argorepo
                        sed -i "s/tag:.*/tag: $BUILD_NUMBER/g" ./charts/web/values.yaml
                        git add ./charts/web/values.yaml
                        git commit -m "Update yaml file $BUILD_NUMBER"
                        git remote -v
                        git push -u origin +master
                        """
                    }
                }
            }
        }
  }
}
