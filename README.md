Run `skaffold dev` to start the continuous development cycle:

```shell
./skaffold dev
```

Use `skaffold-darwin` for macOS.

Skaffold uses `k8s/` directory by default

Generate the kubernetes manifests:

```shell
(cd k8s/ && ./kubegen.sh)
```


# Debug

Pass image to watch (excludes the image to debug so it's not rebuilding and we can do hot swap):

```shell
./skaffold dev -w gcr.io/qingyangc-sandbox/skaffold-jib-hello-service -w gcr.io/qingyangc-sandbox/leeroy-app
```

Then can just attach default debugger in IntelliJ at port 5005.

# Test

```shell
curl localhost:8080/hello
```

```shell
curl localhost:8080/leeroy
# 
```
