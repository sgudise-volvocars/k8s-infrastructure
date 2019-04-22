1. **Render Cluster**
    ```
    $ ./render-cluster.sh 
    Usage: ./render-cluster.sh <name> <region> <OrgnizationUnit|environment> <network_cidr> <Internal|Public> [--force]

1. **Initilize and deploy**
    ```
    $ ./render-cluster.sh  vs1 us-west-2 dev 10.0.0.0/16 Internal 
    cd ./vs1.uswest2.dev.sarithm.com
    make k8s-init
    make kops-update-yes

1. **Verify**
    ```
    $ kubectl get nodes 
    NAME                                       STATUS   ROLES    AGE   VERSION
    ip-10-0-0-253.us-west-2.compute.internal   Ready    master   2h    v1.11.8
    ip-10-0-1-29.us-west-2.compute.internal    Ready    node     2h    v1.11.8
    ip-10-0-1-37.us-west-2.compute.internal    Ready    master   2h    v1.11.8
    ip-10-0-2-94.us-west-2.compute.internal    Ready    master   2h    v1.11.8
    $ 