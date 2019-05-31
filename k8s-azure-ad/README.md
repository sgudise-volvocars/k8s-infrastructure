##  Authenticate Kubernetes cluster using Azure Active Directory
### Pre Requitions
    
* Kubectl Installed on Mac or Linux 

### Create `~/.kube/config` to access tekgs k8s cluster `k8s-tgs.k8scluster.local`
```
    AGLC02Y751CJGH5:scripts sagudise$ ./create-azureAD-kubeconfig.sh
    sagudise
    Cluster "k8s-tgs.k8scluster.local" set.
    User "sagudise" set.
    Context "k8s-tgs.k8scluster.local" modified.
    Switched to context "k8s-tgs.k8scluster.local".
    To sign in, use a web browser to open the page https://microsoft.com/devicelogin and enter the code A6RKSJD9S to authenticate.
```

### Step by Step Instructions instead of script

1. **Create ~/.kube/config with Cluster API Endpoint**
    ```
    AGLC02Y751CJGH5:~ sagudise$ kubectl config set-cluster k8s.k8scluster.local --server=https://api-k8s-k8scluster-local-16jj91-838602001.us-east-1.elb.amazonaws.com --insecure-skip-tls-verify
    Cluster "k8s.k8scluster.local" set.
    ```
    * `https://api-k8s-k8scluster-local-16jj91-838602001.us-east-1.elb.amazonaws.com` : Cluster API endpoint - AWS classic LoadBalance EndPoint
1. **Update ~/.kube/config with Azure AD Application information**
    ```
    AGLC02Y751CJGH5:.kube sagudise$ kubectl config set-credentials sagudise --auth-provider=azure \
       --auth-provider-arg=environment=AzurePublicCloud \
       --auth-provider-arg=client-id=bd61efe7-1cd8-4d0a-bb19-aa5ad15a47c3 \
       --auth-provider-arg=tenant-id=371cb917-b098-4303-b878-c182ec8403ac \
       --auth-provider-arg=apiserver-id=f8a1cbda-71f6-4146-b58e-8351b420b39c
    ```
    * `bd61efe7-1cd8-4d0a-bb19-aa5ad15a47c3` : Native Application ID
    * `f8a1cbda-71f6-4146-b58e-8351b420b39c` : Web/API Application ID
    * `371cb917-b098-4303-b878-c182ec8403ac` : Azure AD Tenant ID
1. **Create Context**
    ```
    AGLC02Y751CJGH5:.kube sagudise$ kubectl config set-context k8s.k8scluster.local --cluster=k8s.k8scluster.local --namespace=sagudise --user=sagudise
    Context "k8s.k8scluster.local" modified.
    ```
    * context name `k8s.k8scluster.local` and cluster name  ` --cluster=k8s.k8scluster.local` can be different
1. **Set default context**
    ```
    AGLC02Y751CJGH5:.kube sagudise$ kubectl config use-context k8s.k8scluster.local
    Switched to context "k8s.k8scluster.local".
    AGLC02Y751CJGH5:.kube sagudise$
    ```
1. **Login using credentials as directed**
    ```
    AGLC02Y751CJGH5:.kube sagudise$ kubectl get pods
    To sign in, use a web browser to open the page https://microsoft.com/devicelogin and enter the code A4XFDEQVF to authenticate.
    ```
1. **Verify**
    ```
    AGLC02Y751CJGH5:.kube sagudise$ kubectl get pods
    Error from server (Forbidden): pods is forbidden: User "aad:sagudise@teksystems.com" cannot list pods in the namespace "sagudise"
1. **Contact Cluster Administration to update RBAC for minimum required access**
    ```
    AGLC02Y751CJGH5:.kube sagudise$ kubectl get pods
    No resources found.
    AGLC02Y751CJGH5:.kube sagudise$ kubectl get pods -n kube-system
    NAME                                                  READY   STATUS    RESTARTS   AGE
    dns-controller-6b5677554b-jsk55                       1/1     Running   0          43m
    etcd-server-events-ip-10-10-0-8.ec2.internal          1/1     Running   0          1h
    etcd-server-events-ip-10-10-1-103.ec2.internal        1/1     Running   0          44m
    etcd-server-events-ip-10-10-2-161.ec2.internal        1/1     Running   0          38m
    etcd-server-ip-10-10-0-8.ec2.internal                 1/1     Running   0          1h
    etcd-server-ip-10-10-1-103.ec2.internal               1/1     Running   0          44m
    etcd-server-ip-10-10-2-161.ec2.internal               1/1     Running   0          37m
    kube-apiserver-ip-10-10-0-8.ec2.internal              1/1     Running   0          1h
    kube-apiserver-ip-10-10-1-103.ec2.internal            1/1     Running   0          44m
    kube-apiserver-ip-10-10-2-161.ec2.internal            1/1     Running   0          38m
    kube-controller-manager-ip-10-10-0-8.ec2.internal     1/1     Running   0          1h
    kube-controller-manager-ip-10-10-1-103.ec2.internal   1/1     Running   0          44m
    kube-controller-manager-ip-10-10-2-161.ec2.internal   1/1     Running   0          38m
    kube-dns-6b4f4b544c-wgg5t                             3/3     Running   0          1h
    kube-dns-6b4f4b544c-wlpcb                             3/3     Running   0          1h
    kube-dns-autoscaler-6b658bd4d5-lgjcg                  1/1     Running   0          1h
    kube-proxy-ip-10-10-0-71.ec2.internal                 1/1     Running   0          1h
    kube-proxy-ip-10-10-0-8.ec2.internal                  1/1     Running   0          1h
    kube-proxy-ip-10-10-1-103.ec2.internal                1/1     Running   0          44m
    kube-proxy-ip-10-10-1-53.ec2.internal                 1/1     Running   0          1h
    kube-proxy-ip-10-10-2-161.ec2.internal                1/1     Running   0          38m
    kube-proxy-ip-10-10-2-48.ec2.internal                 1/1     Running   0          1h
    kube-scheduler-ip-10-10-0-8.ec2.internal              1/1     Running   0          1h
    kube-scheduler-ip-10-10-1-103.ec2.internal            1/1     Running   0          44m
    kube-scheduler-ip-10-10-2-161.ec2.internal            1/1     Running   0          38m
    weave-net-9jzz6                                       2/2     Running   0          45m
    weave-net-j6m7v                                       2/2     Running   1          1h
    weave-net-k6hlm                                       2/2     Running   1          1h
    weave-net-qkw5v                                       2/2     Running   0          1h
    weave-net-v2r84                                       2/2     Running   1          1h
    weave-net-xwlp5                                       2/2     Running   0          39m
    AGLC02Y751CJGH5:.kube sagudise$
    ```