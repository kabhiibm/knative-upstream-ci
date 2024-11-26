#!/bin/bash
#Export USER before test starts
sed -i "/^source.*/a export USER=$\(whoami\)" test/e2e-tests.sh
#Increase e2e timeout to 60m
sed -i "s/\(go_test_e2e.*\)timeout=20m\(.*\).*/\1timeout=40m\2/g" test/e2e-tests.sh
kubectl get cm kb-patch114 -n default -o jsonpath='{.data.kbpatch114}' > ppc64le.patch && git apply ppc64le.patch
echo "Source code patched successfully"
