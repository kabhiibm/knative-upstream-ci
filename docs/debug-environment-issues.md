# How to debug environment issues ?

1. Check CI job logs for failure details.

2. Ensure vms are running and have network connectivity.
    > Login to bastion and ping cluster nodes.

3. Verify private image registry is working as expected
    ```bash
    # check if registry is responding to curl
    $ curl registry.ppc64le/v2/_catalog --insecure

    # verify a push(use any image)
    $ docker push registry.ppc64le/openzipkin/zipkin:test

    # verify a pull(use any image)
    $ docker pull registry.ppc64le/openzipkin/zipkin:test
    ```
    
4. Verify k8s automation is working as expected.
    ```bash
    # run the k8s automation
    $ /opt/knative-upstream-ci/k8s-ansible-automation/create-cluster.sh
    ....

    PLAY RECAP  ******************************************************************************************************************** *************
    192.168.25.201             : ok=49   changed=22   unreachable=0    failed=0    skipped=13   rescued=0    ignored=0
    192.168.25.202             : ok=33   changed=13   unreachable=0    failed=0    skipped=19   rescued=0    ignored=0
    192.168.25.203             : ok=33   changed=13   unreachable=0    failed=0    skipped=19   rescued=0    ignored=0
    localhost                  : ok=31   changed=12   unreachable=0    failed=0    skipped=10   rescued=0    ignored=0

    # check if cluster node state(ready) & age(not more than few minutes)
    $ kubectl get nodes
    NAME              STATUS   ROLES                  AGE   VERSION
    knative-master    Ready    control-plane,master   82s   v1.22.0
    knative-worker1   Ready    <none>                 60s   v1.22.0
    knative-worker2   Ready    <none>                 60s   v1.22.0
    ```

5. If required, we can run a sample/failing ci job by following steps from [testing](./testing.md) doc.