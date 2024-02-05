pipeline {
    agent any
    tools {
        nodejs 'npm'
    }

    environment {
        registryfront = "justelyes44.azurecr.io/angular"
    }

    stages {
        stage("Clone code from GitHub") {
            steps {
                script {
                    git branch: 'main', url: 'https://github.com/Elyes44/azure-aks-angular.git'
                }
            }
        }
    
        stage('Build') {
            steps {
                script {
                   // sh 'rm -rf node_modules'
                  //  sh 'npm cache clean --force'
                    sh 'npm install --legacy-peer-deps --force'
                    sh 'npm run build --legacy-peer-deps --force'
                }
            }
        }
       
        stage('Building a Docker Image') {
            steps {
                script {
                sh "docker image build -t ${registryfront}:latest ."
                }
            }
        }
       
                        stage( 'azure login and push to acr'){
	        steps{
	        	withCredentials([usernamePassword(credentialsId:'acr_creds', passwordVariable : 'password', usernameVariable : 'username')]) {
			        sh "docker login -u ${username} -p ${password} justelyes44.azurecr.io"
			        sh "docker image push ${registryfront}:latest"
	    	        }
            	   }
                }

        stage('K8S Deploy') {
            steps {
                    withKubeConfig(caCertificate: '', clusterName: '', contextName: '', credentialsId: 'aks', namespace: '', restrictKubeConfigAccess: false, serverUrl: '') {
                        sh "kubectl apply -f angular.yaml"
                }
            }
        }
        
    }
}
