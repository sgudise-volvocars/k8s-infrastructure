#!/bin/sh
# This script render kubernetes cluster data from template

if [[ $# -lt 5 ]] ; then
    echo "Usage: $0 <name> <region> <OrgnizationUnit|environment> <network_cidr> <Internal|Public> [--force]"
    exit 1
fi

NAME=$1
REGION=$2
ENV=$3
NETWORK_CIDR=$4
LB_TYPE=$5

SREGION=`echo "${REGION//-/}"`
DOMAIN_NAME="sarithm.com"
CLUSTER_NAME=${NAME}.${SREGION}.${ENV}.${DOMAIN_NAME}

CURRENT_DIR=$(dirname $0)
CLUSTER_DIR=${CURRENT_DIR}/${CLUSTER_NAME}

if [ -d "${CLUSTER_DIR}" ] ; then
#  &&  [ "$6" != "--force"]]; then 
    echo "Cluster is already exists! use --force to overwrite/rebuild"
    exit 1
else
    mkdir -p ${CLUSTER_DIR}
fi

cp ./render-source/*  ${CLUSTER_DIR}
cat << EOF > ${CLUSTER_DIR}/Makefile
CLUSTER_NAME := ${CLUSTER_NAME}
SSH_PUBLIC_KEY := ~/.ssh/${CLUSTER_NAME}.pub
DNS_ZONE := ${ENV}.${DOMAIN_NAME}
KOPS_STATE_STORE := s3://${SREGION}.${ENV}.${DOMAIN_NAME}
REGION := ${REGION}
NETWORK_CIDR := ${NETWORK_CIDR}
LB_TYPE := ${LB_TYPE}
include ../Makefile.in
EOF

echo "cd ${CLUSTER_DIR}"
echo "make k8s-init"
echo "make kops-update-yes"