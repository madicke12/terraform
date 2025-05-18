pipeline {
  agent any
  stages {

    stage('Terraform Init') {
      steps {
        sh '''
          terraform init
        '''
      }
    }
    stage('Terraform Plan') {
      steps {
        sh '''
          terraform plan
        '''
      }
    }
    stage('Terraform Apply') {
      steps {
        sh '''
          terraform apply -auto-approve
        '''
      }
    }
  }
  environment{
     PATH = "/usr/local/bin:$PATH"
     email = "cissemadicke8@gmail.com"
  }
  post {
            failure {
                emailext(
                    subject: "${JOB_NAME}.${BUILD_NUMBER} FAILED",
                    mimeType: 'text/html',
                    to: "$email",
                    body: "${JOB_NAME}.${BUILD_NUMBER} FAILED"
                )
            }
            success {
                emailext(
                    subject: "${JOB_NAME}.${BUILD_NUMBER} PASSED",
                    mimeType: 'text/html',
                    to: "$email",
                    body: "${JOB_NAME}.${BUILD_NUMBER} PASSED"
                )
            }
    }
}

