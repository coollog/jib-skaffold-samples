frontend-service

/index.html - survey results page
/survey.html - take the survey

vote-service

/ - send vote data to this, publishes to notification-service

notification-service

subscribe to vote notifications


```
kubectl create clusterrolebinding my-cluster-admin-binding --clusterrole=cluster-admin --user=$(gcloud info --format="value(config.account)")
kubectl apply -f ambassador.yaml
./skaffold dev
```