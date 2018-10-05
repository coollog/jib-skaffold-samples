#! /bin/sh

kubectl run helloworld --image=gcr.io/qingyangc-sandbox/skaffold-jib --port=8080 -o yaml --dry-run > helloworld.yaml

# This is a complete hack.
kubectl run helloworld-sub --image=gcr.io/qingyangc-sandbox/skaffold-jib-sub --port=5005 -o yaml --dry-run > temp1
kubectl run helloworld-sub --image=gcr.io/qingyangc-sandbox/skaffold-jib-sub --port=4567 -o yaml --dry-run > temp2
diff -Dignore temp1 temp2 | grep -v '^#if' | grep -v '^#else' | grep -v '^#endif' > helloworld-sub.yaml
rm temp1 temp2

kubectl expose -f helloworld-sub.yaml --port=80 --target-port=4567 --name=name-service --type=ClusterIP --dry-run -o yaml > name-service.yaml
