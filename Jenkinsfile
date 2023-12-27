pipeline {
   agent any

   environment {
       DOCKER_USERNAME = credentials('username')
       DOCKER_PASSWORD = credentials('password')
       ECR_ACCESS_KEY = credentials('ecrAccesskey')
       ECR_PATH = 'public.ecr.aws/k3f1h3u2/btc3-ecr'
       IMAGE_NAME = 'public.ecr.aws/k3f1h3u2/btc3-ecr/yangsungsoo'
       REGION = 'ap-northeast-2'
   }

   stages {
     
       stage('Build Docker Image') {
           steps {
               script {
                   withCredentials([string(credentialsId: 'username', variable: 'DOCKER_USERNAME'),
                                    string(credentialsId: 'password', variable: 'DOCKER_PASSWORD')]) {
                       sh "docker build -t $DOCKER_USERNAME/jenkins:${currentBuild.number} ."
                       sh "docker build -t $DOCKER_USERNAME/jenkins:latest ."
                       sh "docker tag $DOCKER_USERNAME:jenkins $DOCKER_USERNAME:latest"
                   }
               }
           }
       }
      
      stage('upload aws ECR') {
            steps {
                script{
                    // cleanup current user docker credentials
                    sh 'rm -f ~/.dockercfg ~/.docker/config.json || true'
                    
                   
                    docker.withRegistry("https://${ECR_PATH}", "ecr:${REGION}:${ECR_ACCESS_KEY}") {
                      docker.image("${username}/jenkins:${currentBuild.number}").push()
                      docker.image("${password}/jenkins:latest").push()
                    }

                }
            }
            post {
                success {
                    echo 'success upload image'
                }
                failure {
                    error 'fail upload image' // exit pipeline
                }
            }
        }


   }
 
   post {
       success {
      
           echo 'Docker image build, login, push, and local image cleanup successful!'
       }

       failure {
           echo 'One or more stages failed. Check the logs for details.'
       }
   }
}
