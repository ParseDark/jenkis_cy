pipeline {
  agent {
    docker {
      image 'cypress/base:16.13.0'
    }

  }
  stages {
    stage('install') {
      steps {
        sh 'npm install --save-dev cypress'
        sh 'npm ci'
      }
    }

    stage('test:ci') {
      steps {
        sh 'npm run test:ci'
      }
    }

    stage('post report') {
      steps {
        archiveArtifacts(artifacts: '/report', allowEmptyArchive: true, defaultExcludes: true, caseSensitive: true)
      }
    }

    stage('clean') {
      steps {
        sh 'npm run clean'
      }
    }

    stage('Deliver') {
      steps {
        input 'Finished using the web site? (Click "Proceed" to continue)'
      }
    }

  }
}