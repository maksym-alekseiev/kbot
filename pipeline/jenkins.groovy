pipeline {
    
    agent any
        environment {
        REPO = 'https://github.com/maksym-alekseiev/kbot'
        BRANCH = 'main'
    }

    parameters {

        choice(name: 'OS', choices: ['linux', 'darwin', 'windows', 'all'], description: 'Pick OS')
        choice(name: 'ARCH', choices: ['arm64', 'amd64'], description: 'Pick ARCH')

    }

    stages {
        
        stage('clone') {
            steps {
                echo 'CLONE REPOSITORY'
                    git branch: "${BRANCH}", url: "${REPO}"
            }
        }
        
        stage('test'){
            steps {
                script {
                    echo 'TEST EXECUTION STARTED'
                    sh 'make test'
                }
            }
        }
        
        stage('build') {
            steps {
                echo "Build for platform ${params.OS}"
                echo "Build for arch: ${params.ARCH}"
                sh "make build TARGETARCH=${params.ARCH} TARGETOS=${params.OS}"
            }
        }
        
        stage('push'){
            steps {
                script{
                    docker.withRegistry('', 'DOCKER_HUB')
                    sh 'make push'
                }
            }
        }

    }
}