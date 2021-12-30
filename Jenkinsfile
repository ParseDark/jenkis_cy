pipeline {
  agent {
    // this image provides everything needed to run Cypress
    docker {
      image 'cypress/base:16.13.0'
    }
  }

  stages {
    stage('build and test') {
      steps {
        sh 'npm install --save-dev cypress'
        sh 'npm ci'
        sh "npm run test:ci"
      }
    }
  }
}