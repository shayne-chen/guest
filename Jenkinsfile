pipeline {
    agent any
    stages {
        stage('Build') {            
            steps {                
                sh './pipeline_test_files/1.sh'            
            }        
        }        
        stage('Test') {            
            steps {                
                sh './pipeline_test_files/2.sh'          
            }        
        }
        stage('Deploy - Staging') {            
            steps {                
                sh './pipeline_test_files/3.sh'      
            }        
        }        
        stage('Sanity check') {            
            steps {                
                sh './seg_fault_test'         
            }        
        }        
        stage('Deploy - Production') {            
            steps {                
                sh './pipeline_test_files/5.sh'           
            }        
        }    
    }
 
    post {        
        always {            
            echo 'One way or another, I have finished'  
        }        
        success {            
            echo 'I succeeeded!'        
        }        
        unstable {            
            echo 'I am unstable'        
        }        
        failure {            
            sh './pipeline_test_files/5.sh'        
        }        
        changed {            
            echo 'Things were different before...'        
        }    
    }
}
