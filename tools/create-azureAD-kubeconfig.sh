KUBEAPI=$2
NATIVE_CLIENT_ID=bd61efe7-1cd8-4d0a-bb19-aa5ad15a47c3
TENANT_ID=371cb917-b098-4303-b878-c182ec8403ac
WEBAPI_CLIENT_ID=f8a1cbda-71f6-4146-b58e-8351b420b39c
CLUSTER_NAME=azureAD
USERNAME=$1
echo 
if [ $# -ne 2 ]; then
    echo "create-azureAD-kubeconfig.sh <username> <api-endpoint>"
    exit 1
fi

kubectl config set-cluster ${CLUSTER_NAME} --server=${KUBEAPI} --insecure-skip-tls-verify
kubectl config set-credentials ${USERNAME} --auth-provider=azure --auth-provider-arg=environment=AzurePublicCloud --auth-provider-arg=client-id=${NATIVE_CLIENT_ID} --auth-provider-arg=tenant-id=${TENANT_ID} --auth-provider-arg=apiserver-id=${WEBAPI_CLIENT_ID}
kubectl config set-context ${CLUSTER_NAME} --cluster=${CLUSTER_NAME} --user=${USERNAME}
kubectl config use-context ${CLUSTER_NAME}
kubectl get pods
