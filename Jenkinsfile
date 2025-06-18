/* groovylint-disable DuplicateStringLiteral, NoDef */
/* groovylint-disable-next-line CompileStatic, NoDef, UnusedVariable, VariableName, VariableTypeRequired */
@Library('piper-lib-os') _

node('cap') {
  /* groovylint-disable-next-line VariableTypeRequired */
    def branch = env.BRANCH_NAME ?: 'unknown'

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

          // Publish test results if available
          publishTestResults testResultsPattern: 'test-results/jest-junit.xml', allowEmptyResults: true
          publishHTML([
            allowMissing: true,
            alwaysLinkToLastBuild: true,
            keepAll: true,
            reportDir: 'coverage',
            reportFiles: 'index.html',
            reportName: 'Coverage Report'
          ])
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
            } else if (branch == 'develop') {
        echo 'Deploying to: DEV'
        cloudFoundryDeploy script: this
        echo 'Deploy completed'
            } else if (branch.startsWith('release/')) {
        echo 'Would deploy to: PRE-PROD'
            } else if (branch == 'main') {
        echo 'Would deploy to: PROD'
            } else {
        echo "No deploy target defined for branch: ${branch}"
      }
        }
    }
}
