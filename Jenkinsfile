@Library('piper-lib-os') _

node('cap') {

  stage('Prepare') {
    checkout scm
    setupCommonPipelineEnvironment script: this
  }

  stage('Build') {
    mtaBuild script: this
  }

}
