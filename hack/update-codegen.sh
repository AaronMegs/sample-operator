#!/usr/bin/env bash

# Copyright 2017 The Kubernetes Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -o errexit
set -o nounset
set -o pipefail

SCRIPT_ROOT=$(dirname "${BASH_SOURCE[0]}")/..
CODEGEN_PKG=${CODEGEN_PKG:-$(cd "${SCRIPT_ROOT}"; ls -d -1 ./vendor/k8s.io/code-generator 2>/dev/null || echo ../code-generator)}

# generate the code with:
# --output-base    because this script should also be able to run inside the vendor dir of
#                  k8s.io/kubernetes. The output-base is needed for the generators to output into the vendor dir
#                  instead of the $GOPATH directly. For normal projects this can be dropped.


# 修改配置项如下
# 代码生成的目录与 go mod 一致且，代码所在文件目录层级应与 go mod 一致
# 此时， --output-base 应该匹配到对应的目录，/../ 指代的应该与代码目录层级一致
# 执行时应在 sample-operator 目录下进行：./hack/update-codegen.sh
#bash "${CODEGEN_PKG}"/generate-groups.sh "deepcopy,client,informer,lister" \
bash "${CODEGEN_PKG}"/generate-groups.sh "all" \
  github.com/aaronmegs/sample-operator/pkg/client github.com/aaronmegs/sample-operator/pkg/apis \
  samplecrd:v1alpha1 \
  --output-base "$(dirname "${BASH_SOURCE[0]}")/../../../.." \
  --go-header-file "${SCRIPT_ROOT}"/hack/boilerplate.go.txt

# compare with k8s sample
# bash "${CODEGEN_PKG}"/generate-groups.sh "deepcopy,client,informer,lister" \
#   k8s.io/sample-controller/pkg/generated k8s.io/sample-controller/pkg/apis \
#   samplecontroller:v1alpha1 \
#   --output-base "$(dirname "${BASH_SOURCE[0]}")/../../.." \
#   --go-header-file "${SCRIPT_ROOT}"/hack/boilerplate.go.txt


# To use your own boilerplate text append:
#   --go-header-file "${SCRIPT_ROOT}"/hack/custom-boilerplate.go.txt

# 也可以在sample的目录下执行下边生成全部folder的命令
#bash "${SCRIPT_ROOT}"/vendor/k8s.io/code-generator/generate-groups.sh "all" "./pkg/generated" "./pkg/apis" "samplecrd:v1alpha1" -o "./" --go-header-file "./hack/boilerplate.go.txt"
#bash "${CODEGEN_PKG}"/generate-groups.sh "all" "./pkg/generated" "./pkg/apis" "samplecrd:v1alpha1" -o "./" --go-header-file "./hack/boilerplate.go.txt"

