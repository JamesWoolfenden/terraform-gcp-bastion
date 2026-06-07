#!/usr/bin/env bash
set -euo pipefail

KUBERNETES_MINOR_VERSION="v1.31"

apt-get update
apt-get install -y apt-transport-https ca-certificates curl gnupg

mkdir -p /etc/apt/keyrings

# packages.cloud.google.com/apt (kubernetes-xenial) and apt-key are both retired;
# Kubernetes packages now live in the community-owned pkgs.k8s.io repos, signed
# and trusted per-repo via /etc/apt/keyrings rather than the deprecated global keyring.
curl -fsSL "https://pkgs.k8s.io/core:/stable:/${KUBERNETES_MINOR_VERSION}/deb/Release.key" \
  | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/${KUBERNETES_MINOR_VERSION}/deb/ /" \
  > /etc/apt/sources.list.d/kubernetes.list

apt-get update
apt-get install -y kubelet kubeadm kubectl
apt-mark hold kubelet kubeadm kubectl

# Helm's official apt repo, signed via /etc/apt/keyrings — replaces the retired
# git.io/get_helm.sh shortener (which piped an unpinned, unverified script to bash).
curl -fsSL https://baltocdn.com/helm/signing.asc \
  | gpg --dearmor -o /etc/apt/keyrings/helm.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" \
  > /etc/apt/sources.list.d/helm-stable-debian.list

apt-get update
apt-get install -y helm
