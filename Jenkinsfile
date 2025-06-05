@Library('piper-lib-os') _

node('cap') {

  def branch = env.BRANCH_NAME ?: 'unknown'
  def commit = env.GIT_COMMIT ?: 'HEAD'

  stage('Prepare') {
    checkout scm
    setupCommonPipelineEnvironment script: this
  }

  stage('Install Dependencies') {
    sh 'npm ci'
  }

  stage('TypeScript Build Check') {
    githubNotify context: 'typescript', status: 'PENDING', description: 'TypeScript check started', commitSha: commit
    try {
      sh 'npx tsc --noEmit'
      githubNotify context: 'typescript', status: 'SUCCESS', description: 'TypeScript check passed', commitSha: commit
    } catch (err) {
      githubNotify context: 'typescript', status: 'FAILURE', description: 'TypeScript check failed', commitSha: commit
      throw err
    }
  }

  stage('Lint') {
    githubNotify context: 'lint', status: 'PENDING', description: 'Linting started', commitSha: commit
    try {
      sh 'npm run lint'
      githubNotify context: 'lint', status: 'SUCCESS', description: 'Lint passed', commitSha: commit
    } catch (err) {
      githubNotify context: 'lint', status: 'FAILURE', description: 'Lint failed', commitSha: commit
      throw err
    }
  }

  stage('Unit Tests') {
    githubNotify context: 'test', status: 'PENDING', description: 'Tests running', commitSha: commit
    try {
      sh 'npm run test'
      githubNotify context: 'test', status: 'SUCCESS', description: 'Tests passed', commitSha: commit
    } catch (err) {
      githubNotify context: 'test', status: 'FAILURE', description: 'Tests failed', commitSha: commit
      throw err
    }
  }

  stage('Build MTA') {
    githubNotify context: 'build', status: 'PENDING', description: 'MTA build started', commitSha: commit
    try {
      mtaBuild script: this
      githubNotify context: 'build', status: 'SUCCESS', description: 'MTA build successful', commitSha: commit
    } catch (err) {
      githubNotify context: 'build', status: 'FAILURE', description: 'MTA build failed', commitSha: commit
      throw err
    }
  }

  stage('Stub Deploy') {
    script {
      if (env.CHANGE_ID) {
        echo "Skipping deploy — this is a Pull Request build"
      } else if (branch == 'develop') {
        echo "Would deploy to: DEV"
      } else if (branch.startsWith('release/')) {
        echo "Would deploy to: PRE-PROD"
      } else if (branch == 'main') {
        echo "Would deploy to: PROD"
      } else {
        echo "No deploy target defined for branch: ${branch}"
      }
    }
  }
}
