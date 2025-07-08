/* groovylint-disable DuplicateStringLiteral, NoDef */
/* groovylint-disable-next-line CompileStatic, NoDef, UnusedVariable, VariableName, VariableTypeRequired */
@Library('piper-lib-os') _

node('cap') {
  /* groovylint-disable-next-line VariableTypeRequired */
    def branch = env.BRANCH_NAME ?: 'unknown'
    def landscape = determineLandscape(branch)

    echo "Branch: ${branch}, Landscape: ${landscape}"

    stage('Prepare') {
        checkout scm
        setupCommonPipelineEnvironment script: this
    }

    stage('Install Dependencies') {
        timeout(time: 10, unit: 'MINUTES') {
      retry(2) {
        timestamps {
          sh 'npm ci'
        }
      }
        }
    }

    stage('TypeScript Build Check') {
        githubNotify context: 'typescript', status: 'PENDING', description: 'TypeScript check started'
        try {
      sh '''
            npx cds-typer "*"
            npx tsc --noEmit
            '''
      githubNotify context: 'typescript', status: 'SUCCESS', description: 'TypeScript check passed'
        } catch (err) {
      githubNotify context: 'typescript', status: 'FAILURE', description: 'TypeScript check failed'
      throw err
        }
    }

    stage('Lint') {
        githubNotify context: 'lint', status: 'PENDING', description: 'Linting started'
        try {
          sh 'npm run lint'
          githubNotify context: 'lint', status: 'SUCCESS', description: 'Lint passed'
        } catch (err) {
          githubNotify context: 'lint', status: 'FAILURE', description: 'Lint failed'
          throw err
        }
    }

    stage('Unit Tests') {
      githubNotify context: 'test', status: 'PENDING', description: 'Tests running'

      script {
        // Check for test files first
        /* groovylint-disable-next-line VariableTypeRequired */
        def testFileCount = sh(script: '''
          find . -type f \\( -name "*.test.js" -o -name "*.test.ts" -o -name "*.spec.js" -o -name "*.spec.ts" \\) \\
          ! -path "./node_modules/*" ! -path "./gen/*" | wc -l
        ''', returnStdout: true).trim() as Integer

        if (testFileCount > 0) {
          try {
            sh 'npm run test'
            githubNotify context: 'test', status: 'SUCCESS', description: 'Tests passed'

            // Archive any generated reports
            archiveArtifacts artifacts: 'coverage/**/*', allowEmptyArchive: true
            archiveArtifacts artifacts: 'test-results/**/*', allowEmptyArchive: true

          } catch (err) {
            githubNotify context: 'test', status: 'FAILURE', description: 'Tests failed'
            throw err
          }
        } else {
          echo '⚠️ WARNING: No test files found in the project.'
          echo '   Consider adding unit tests to improve code quality and catch regressions early.'
          githubNotify context: 'test', status: 'SUCCESS', description: 'No tests found - skipped'
        }
      }
    }

    stage('MTA Build') {
        githubNotify context: 'build', status: 'PENDING', description: 'MTA build started'
        try {
      mtaBuild script: this
      githubNotify context: 'build', status: 'SUCCESS', description: 'MTA build successful'
    } catch (err) {
      githubNotify context: 'build', status: 'FAILURE', description: 'MTA build failed'
      throw err
        }
    }

    // Deployment stages based on branch
    stage('Deploy') {
        script {
      if (env.CHANGE_ID) {
        echo 'Skipping deploy — this is a Pull Request build'
            } else if (branch == 'develop' || branch == 'bpa/develop') {
        deployToDev(landscape)
            } else if (branch.startsWith('release/') || branch.startsWith('bpa/release/')) {
        deployToStaging(landscape)
            } else if (branch == 'main' || branch == 'bpa/main') {
        deployToProd(landscape)
            } else {
        echo "No deploy target defined for branch: ${branch}"
      }
        }
    }
}

String determineLandscape(String branch) {
  if (branch.startsWith('bpa/')) {
    return 'BPA'
  }
  return 'DEVOPS'  // Default for all standard branches
}

Map getLandscapeConfig(String landscape, String environment) {
  def configs = [
        'DEVOPS': [
            'DEV': [
                org: 'ZESPRI-DEVOPS-DEV',
                space: 'DEV',
                apiEndpoint: 'https://api.cf.ap11.hana.ondemand.com/',
                credentialsId: 'cf-credentials-dev'
            ],
            'PREPROD': [
                org: 'ZESPRI-DEVOPS-PREPROD',
                space: 'PREPROD',
                apiEndpoint: 'https://api.cf.ap11.hana.ondemand.com/',
                credentialsId: 'cf-credentials-staging'
            ],
            'PROD': [
                org: 'ZESPRI-DEVOPS-PROD',
                space: 'PROD',
                apiEndpoint: 'https://api.cf.ap11.hana.ondemand.com/',
                credentialsId: 'cf-credentials-prod'
            ]
        ],
        'BPA': [
            'DEV': [
                org: 'Zespri Group Limited_zespri-build-process-automation-dev-sryylsb5',
                space: 'DEV',
                apiEndpoint: 'https://api.cf.jp10.hana.ondemand.com/',
                credentialsId: 'cf-credentials-bpa-dev'
            ],
            'PREPROD': [
                org: 'ZESPRI-BPA-PREPROD-PLACEHOLDER',
                space: 'PREPROD',
                apiEndpoint: 'https://api.cf.jp10.hana.ondemand.com/',
                credentialsId: 'cf-credentials-bpa-staging'
            ],
            'PROD': [
                org: 'ZESPRI-BPA-PROD-PLACEHOLDER',
                space: 'PROD',
                apiEndpoint: 'https://api.cf.jp10.hana.ondemand.com/',
                credentialsId: 'cf-credentials-bpa-prod'
            ]
        ]
    ]

  if (!configs[landscape]) {
    throw new Exception("Unknown landscape: ${landscape}")
  }
  if (!configs[landscape][environment]) {
    throw new Exception("Unknown environment '${environment}' for landscape '${landscape}'")
  }

  return configs[landscape][environment]
}

void deployToDev(String landscape) {
  def config = getLandscapeConfig(landscape, 'DEV')

  githubNotify context: "deploy-dev-${landscape.toLowerCase()}", status: 'PENDING', description: "${landscape} DEV deployment started"
  try {
    echo "Deploying to: ${landscape} DEV"
    cloudFoundryDeploy(
            script: this,
            org: config.org,
            space: config.space,
            apiEndpoint: config.apiEndpoint,
            cfCredentialsId: config.credentialsId,
            deployTool: 'mtaDeployPlugin'
        )
    echo "Deploy to ${landscape} DEV completed"
    githubNotify context: "deploy-dev-${landscape.toLowerCase()}", status: 'SUCCESS', description: "${landscape} DEV deployment successful"
    } catch (err) {
    githubNotify context: "deploy-dev-${landscape.toLowerCase()}", status: 'FAILURE', description: "${landscape} DEV deployment failed"
    throw err
  }
}

void deployToStaging(String landscape) {
  def config = getLandscapeConfig(landscape, 'PREPROD')

  githubNotify context: "deploy-staging-${landscape.toLowerCase()}", status: 'PENDING', description: "${landscape} PREPROD deployment started"
  try {
    echo "Deploying to: ${landscape} PREPROD"
    cloudFoundryDeploy(
            script: this,
            org: config.org,
            space: config.space,
            apiEndpoint: config.apiEndpoint,
            cfCredentialsId: config.credentialsId,
            deployTool: 'mtaDeployPlugin'
        )
    echo "Deploy to ${landscape} PREPROD completed"
    githubNotify context: "deploy-staging-${landscape.toLowerCase()}", status: 'SUCCESS', description: "${landscape} PREPROD deployment successful"
    } catch (err) {
    githubNotify context: "deploy-staging-${landscape.toLowerCase()}", status: 'FAILURE', description: "${landscape} PREPROD deployment failed"
    throw err
  }
}

void deployToProd(String landscape) {
  def config = getLandscapeConfig(landscape, 'PROD')

  githubNotify context: "deploy-prod-${landscape.toLowerCase()}", status: 'PENDING', description: "${landscape} PROD deployment started"
  try {
    echo "Deploying to: ${landscape} PROD"
    cloudFoundryDeploy(
            script: this,
            org: config.org,
            space: config.space,
            apiEndpoint: config.apiEndpoint,
            cfCredentialsId: config.credentialsId,
            deployTool: 'mtaDeployPlugin'
        )
    echo "Deploy to ${landscape} PROD completed"
    githubNotify context: "deploy-prod-${landscape.toLowerCase()}", status: 'SUCCESS', description: "${landscape} PROD deployment successful"
    } catch (err) {
    githubNotify context: "deploy-prod-${landscape.toLowerCase()}", status: 'FAILURE', description: "${landscape} PROD deployment failed"
    throw err
  }
}
