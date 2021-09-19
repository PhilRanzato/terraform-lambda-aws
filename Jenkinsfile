pipeline {
  agent {
    node {
      label 'c7vfc'
    }
  }
  environment {
    terraform_varsfile = 'testing.tfvars'
  }
  stages { 
      stage('Init Terraform') {
          steps {
              withCredentials([string(credentialsId: 'TF_VAR_secret_key', variable: 'TF_VAR_secret_key'), string(credentialsId: 'TF_VAR_access_key', variable: 'TF_VAR_access_key')]) {
                sh 'terraform init'
              }
        }
      }
      stage('Validate Terraform') {
          steps {
              withCredentials([string(credentialsId: 'TF_VAR_secret_key', variable: 'TF_VAR_secret_key'), string(credentialsId: 'TF_VAR_access_key', variable: 'TF_VAR_access_key')]) {
                sh 'terraform validate'
              }
        }
      }
    }
    post {
        always {
            cleanWs(deleteDirs: true)
        }
    }
}