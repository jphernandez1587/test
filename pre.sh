kubectl create namespace microclimate-pipeline-deployments
kubectl create secret docker-registry microclimate-registry-secret --docker-server=mycluster:8500 --docker-username=admin --docker-password=admin --docker-email=null
kubectl create secret docker-registry microclimate-pipeline-secret --docker-server=mycluster:8500 --docker-username=admin --docker-password=admin --docker-email=null --namespace=microclimate-pipeline-deployments
kubectl patch serviceaccount default --namespace microclimate-pipeline-deployments -p '{"imagePullSecrets": [{"name": "microclimate-registry-secret"}, {"name": "microclimate-pipeline-secret"}]}'
cloudctl login -a https://mycluster.icp:8443 --skip-ssl-validation -c id-mycluster-account -u admin -p admin
kubectl create secret generic microclimate-helm-secret --from-file=cert.pem=/home/skytap/.helm/cert.pem --from-file=ca.pem=/home/skytap/.helm/ca.pem --from-file=key.pem=/home/skytap/.helm/key.pem
helm repo add ibm-charts https://raw.githubusercontent.com/IBM/charts/master/repo/stable/