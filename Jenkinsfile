pipeline {
  agent {
    docker {
      image 'cypress/base:16.13.0'
    }

  }
  stages {
    stage('install') {
      steps {
        sh 'npm ci'
      }
    }

    stage('test:ci') {
      steps {
        sh 'npm run test:ci'
      }
    }

    stage('html test report') {
      steps {
        publishHTML (target : [allowMissing: false,
          alwaysLinkToLastBuild: true,
          keepAll: true,
          reportDir: 'report',
          reportFiles: 'merge-report.html',
          includes: '**/*',
          reportName: 'My Reports',
          reportTitles: 'The Report'])
      }
    }
  }
}