pipeline {
  agent {
    docker {
      image 'cypress/base:16.13.0'
    }

  }
  stages {
    stage('Install') {
      steps {
        sh 'npm ci'
      }
    }

    stage('Test') {
      steps {
        sh 'npm run test:ci'
      }
    }

    stage('Html test report') {
      steps {
        /* create test report */
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
  post {
    always {
        echo 'Finish....'
        /* clean up our workspace */
        deleteDir() 
    }
    success {
        echo 'Succeeeded! : ）'
    }
    failure {
        echo 'Failed :(',
        mail to: '13597213421@163.com',
             subject: "Failed Pipeline: ${currentBuild.fullDisplayName}",
             body: "Something is wrong with ${env.BUILD_URL} http://ubuntu:8088/job/jenkis_cy/job/master/2/My_20Reports/"
    }
  }
}