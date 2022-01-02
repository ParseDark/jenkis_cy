pipeline {
  agent {
    docker {
      image 'whd1073363531/cypress_env:9.2.0'
    }
  }
   triggers {
      cron('*/5 * * * *')
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
        archiveArtifacts artifacts: 'report/*', onlyIfSuccessful: true
        archiveArtifacts artifacts: 'videos/*', onlyIfSuccessful: true
        /* clean up our workspace */
        deleteDir() 
    }
    success {
        echo 'Succeeeded! : ）'
        emailext (
          to: '13005440214@163.com',
          attachLog: true,
          attachmentsPattern: 'videos',
          subject: "SUCCESSFUL: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'",
          body: """<p>SUCCESSFUL: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]':</p>
            <p>Check console output at &QUOT;<a href='${env.BUILD_URL}'>${env.JOB_NAME} [${env.BUILD_NUMBER}]</a>&QUOT;</p>""",
          recipientProviders: [[$class: 'DevelopersRecipientProvider']]
        )
    }
    failure {
        echo 'Failed :('
        emailext (
          to: '13005440214@163.com',
          subject: "Failed: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'",
          body: """<p>Failed: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]':</p>
            <p>Check console output at &QUOT;<a href='${env.BUILD_URL}'>${env.JOB_NAME} [${env.BUILD_NUMBER}]</a>&QUOT;</p>""",
          recipientProviders: [[$class: 'DevelopersRecipientProvider']]
        )
    }
  }
}