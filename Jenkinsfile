@Library('piper-lib-os') _

pipeline {
  agent { label 'cap' }

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
          def apiEndpoint   = credentials("cf-api-${params.DEPLOY_ENV}")
          def org           = credentials("cf-org-${params.DEPLOY_ENV}")
          def space         = credentials("cf-space-${params.DEPLOY_ENV}")
          def credentialsId = "cf-credentials-${params.DEPLOY_ENV}"
                    
          piperPipeline(
            customDefaults: ['.pipeline/config.yml'],
            environment: [
              CF_API_ENDPOINT : apiEndpoint,
              CF_ORG          : org,
              CF_SPACE        : space,
              CF_CREDENTIALS  : credentialsId
            ]
          )
        }
      }
    }
  }
}
