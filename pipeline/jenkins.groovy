pipeline {
    agent any
    parameters {

        choice(name: 'OS', choices: ['linux', 'darwin', 'windows', 'all'], description: 'Pick OS')
        choice(name: 'ARCH', choices: ['arm64', 'amd64'], description: 'Pick ARCH')

    }
    stages {
        stage('Example') {
            steps {
                echo "Build for platform ${params.OS}"
                echo "Build for arch: ${params.ARCH}"
                sh "make build TARGETARCH=${params.ARCH} TARGETOS=${params.OS}"
            }
        }
    }
}