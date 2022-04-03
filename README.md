# sample-operator
Base sample for a custom controller in Kubernetes working with custom resources. Operator=CRD+CustomController

## Code generator
- create CR(custom resource)
- copy [code-generator](https://github.com/kubernetes/code-generator) hack folder and script file, and modify script file for yourself
- go mod vendor
- Execute under the sample-operator folder: ./hack/update-codegen.sh

## Compile&Run
```bash
#Clone repo
$ git clone https://github.com/aaronmegs/sample-operator
$ cd k8s-controller-custom-resource
# Build
$ go build -o samplecrd-operator .
$ ./samplecrd-operator -kubeconfig=$HOME/.kube/config -alsologtostderr=true
```
