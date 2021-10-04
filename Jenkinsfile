pipeline
{
    agent { label 'aws-slave-1' }
    stages
    {
        stage('Prep')
        {
            steps
            {
                sh "git checkout ${env.GIT_BRANCH}"
            }
        }
    
        stage('Build Docker Image')
        {
            steps
            {
                sh 'docker build -f Dockerfile -t a7medayman6/boosterapp .'
            }
        }
        
        stage('Push Docker Image to Dockerhub')
        {
            steps
            {
                withCredentials([usernamePassword(credentialsId:"Dockerhub", usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')])
                {
                    sh 'docker login --username $USERNAME --password $PASSWORD'
                    sh 'docker push a7medayman6/boosterapp'
                }
            }
        }
        
        stage('Deploy')
        {
            steps
            {
                sh 'docker-compose up -d'
            }
        }
    }
    post
    {
        success
        {
            slackSend (color: '00FF00', message: "THE DEPLOYMENT SUCCEEDED.")
        }
        failure
        {
            slackSend (color: '#FF0000', message: "THE DEPLOYMENT FAILED.")
        }
    }
}
