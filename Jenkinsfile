pipeline {
  agent any
  stages {
    stage('Install') {
      steps {
        sh 'npm ci'
        sh '''npm -v
node -v
cypress -v'''
      }
    }

    stage('Test') {
      steps {
        sh 'npm run test:ci'
      }
    }

  }
  tools {
    nodejs 'node17'
  }
  post {
    always {
      sh 'npx mochawesome-merge cypress/results/*.json > merge-report.json'
      sh 'npx mochawesome-report-generator -o=./report -i merge-report.json'
      publishHTML([allowMissing: false,
              alwaysLinkToLastBuild: true,
              keepAll: true,
              reportDir: 'report',
              reportFiles: 'merge-report.html',
              includes: '**/*',
              reportName: 'My Reports',
              reportTitles: 'The Report'])
      echo 'Finish....'
      echo 'Test Report in-> ${env.BUILD_URL}/${env.JOB_NAME}/${env.BUILD_NUMBER}/My_20Reports'
      deleteDir()
    }

    success {
      echo 'Succeeeded! : ）'
      emailext(to: '13005440214@163.com', attachLog: true, subject: "SUCCESSFUL: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'", body: """<p>SUCCESSFUL: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]':</p>
                  <p>Check console output at &QUOT;<a href='${env.BUILD_URL}'>${env.JOB_NAME} [${env.BUILD_NUMBER}]</a>&QUOT;</p>""", recipientProviders: [[$class: 'DevelopersRecipientProvider']])
    }

    failure {
      echo 'Failed :('
      emailext(to: '13005440214@163.com', subject: "Failed: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'", body: """<p>Failed: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]':</p>
                  <p>Check console output at &QUOT;<a href='${env.BUILD_URL}'>${env.JOB_NAME} [${env.BUILD_NUMBER}]</a>&QUOT;</p>""", recipientProviders: [[$class: 'DevelopersRecipientProvider']])
    }

  }
  triggers {
    cron('*/4 * * * *')
  }
}