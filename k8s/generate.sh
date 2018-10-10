#! /bin/sh

set -ex

HELLO_SERVICE_YAML=hello-service.yaml
NAME_SERVICE_YAML=name-service.yaml

HELLO_SERVICE_IMAGE=gcr.io/qingyangc-sandbox/skaffold-jib-hello-service
NAME_SERVICE_IMAGE=gcr.io/qingyangc-sandbox/skaffold-jib-name-service

# Generates the deployment for the hello-service, exposing port 8080 (HTTP).
echo "# AUTO-GENERATED" > ${HELLO_SERVICE_YAML}
kubectl run hello-service --image=${HELLO_SERVICE_IMAGE} --port=8080 -o yaml --dry-run >> ${HELLO_SERVICE_YAML}

# Generates the deployment for the name-service, exposing ports 4567 (HTTP) and 5005 (debugger)
kubectl run name-service --image=${NAME_SERVICE_IMAGE} --port=5005 -o yaml --dry-run > temp1
kubectl run name-service --image=${NAME_SERVICE_IMAGE} --port=4567 -o yaml --dry-run > temp2
echo "# AUTO-GENERATED" > ${NAME_SERVICE_YAML}
diff -Dignore temp1 temp2 | grep -v '^#if' | grep -v '^#else' | grep -v '^#endif' >> ${NAME_SERVICE_YAML}
rm temp1 temp2

# Generates the service for the name-service.
kubectl expose -f ${NAME_SERVICE_YAML} --port=80 --target-port=4567 --name=name-service --type=ClusterIP --dry-run -o yaml >> temp
echo "---" >> ${NAME_SERVICE_YAML}
cat temp >> ${NAME_SERVICE_YAML}
rm temp
