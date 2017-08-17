node {
    docker.withRegistry('https://registry.hub.docker.com', 'docker-registry-login') {
        stage('Checkout') {
            checkout scm
        }
        stage('Build') {
            myDocker = docker.build("limit0/php56:${env.BRANCH_NAME}", '.')
        }
        stage('Push Container') {
            if (!env.BRANCH_NAME.contains('master')) {
                myDocker.push("${env.BRANCH_NAME}-latest")
                myDocker.push("${env.BRANCH_NAME}-v${env.BUILD_NUMBER}")
            } else {
                myDocker.push("latest");
                myDocker.push("v${env.BUILD_NUMBER}");
            }
        }
    }
}
