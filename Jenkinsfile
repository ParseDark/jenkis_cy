pipeline {
  agent any
  tools {nodejs "node17"}
  triggers {
      /* cron: every 5mins will trigger the pipeline */
      cron('*/4 * * * *')
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
  }
  post {
    always {
      sh "npx mochawesome-merge cypress/results/*.json > merge-report.json"
      
      sh "npx mochawesome-report-generator -o=./report -i merge-report.json"

      /* create test report */
      publishHTML (target : [allowMissing: false,
        alwaysLinkToLastBuild: true,
        keepAll: true,
        reportDir: 'report',
        reportFiles: 'merge-report.html',
        includes: '**/*',
        reportName: 'My Reports',
        reportTitles: 'The Report'])


        echo 'Finish....'
        echo 'Test Report in-> ${env.BUILD_URL}/${env.JOB_NAME}/${env.BUILD_NUMBER}/My_20Reports'
        /* clean up our workspace */
        deleteDir()
    }
    success {
        echo 'Succeeeded! : ）'
        emailext (
          to: '13005440214@163.com',
          attachLog: true,
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
