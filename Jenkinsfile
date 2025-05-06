@Library('piper-lib-os') _

pipeline {
  agent any

  parameters {
    choice(name: 'DEPLOY_ENV', choices: ['dev', 'preprod', 'prod'], description: 'Choose target environment')
  }

  environment {
    // Default to dev if not selected
    CF_API_ENDPOINT = credentials("cf-api-${params.DEPLOY_ENV}")
    CF_ORG          = credentials("cf-org-${params.DEPLOY_ENV}")
    CF_SPACE        = credentials("cf-space-${params.DEPLOY_ENV}")
    CF_CREDENTIALS  = "cf-credentials-${params.DEPLOY_ENV}"
  }

  stages {
    stage('Run Piper Pipeline') {
      steps {
        script {
          piperPipeline(
            customDefaults: [
              '.pipeline/config.yml'
            ],
            environment: [
              CF_API_ENDPOINT : "${env.CF_API_ENDPOINT}",
              CF_ORG          : "${env.CF_ORG}",
              CF_SPACE        : "${env.CF_SPACE}",
              CF_CREDENTIALS  : "${env.CF_CREDENTIALS}"
            ]
          )
        }
      }
    }
  }
}
