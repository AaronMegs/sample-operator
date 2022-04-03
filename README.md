# sample-operator
Base sample for a custom controller in Kubernetes working with custom resources. Operator=CRD+CustomController
> **Thanks**: 
> [kubernetes/sample-controller](https://github.com/kubernetes/sample-controller)
> [resouer/k8s-controller-custom-resource](https://github.com/resouer/k8s-controller-custom-resource)

## Code generator
- create CRD(custom resource definitions)
- copy [code-generator](https://github.com/kubernetes/code-generator) hack folder and script file, and modify script file for yourself
- go mod vendor
- Execute under the sample-operator folder: `./hack/update-codegen.sh`

## Build&Run
```bash
# Clone repo
$ git clone https://github.com/aaronmegs/sample-operator
$ cd sample-operator
# Build
$ go build -o samplecrd-operator .
$ ./samplecrd-operator -kubeconfig=$HOME/.kube/config -alsologtostderr=true
```

## Usage

You should create the CRD of Foo and Network first:

```
$ kubectl apply -f artifacts/example/crd-foo.yaml
$ kubectl apply -f artifacts/example/crd-network.yaml
```

You can then trigger an event by creating a Foo or Network API instance:

```
$ kubectl apply -f artifacts/example/example-foo.yaml
$ kubectl apply -f artifacts/example/example-network.yaml
```

CURD the Foo and Network API instance, and check the logs of controller.

Enjoy!
