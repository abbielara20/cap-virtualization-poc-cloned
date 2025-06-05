@Library('piper-lib-os') _

node('cap') {

  stage('Prepare') {
    checkout scm
    setupCommonPipelineEnvironment script: this
  }

  stage('Install Dependencies') {
    sh 'npm ci'
  }

  stage('TypeScript Build Check') {
    sh 'npx tsc --noEmit'
  }

  stage('Lint') {
    sh 'npm run lint'
  }


  stage('Unit Tests') {
    sh 'npx jest --ci'
  }

  stage('MTA Build') {
    mtaBuild script: this
  }
}
