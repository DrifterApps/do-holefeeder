# k3s Common Terraform Module

The `k3s-common` module contains all resources that do not depend on a
specific cloud provider. RKE, Kubernetes, Helm, and k3s providers are used
given the necessary information about the infrastructure created in a cloud
provider.

## Variables

###### `node_public_ip`
- **Required**
Public IP of compute node for k3s cluster

###### `node_internal_ip`
- Default: **`""`**
Internal IP of compute node for k3s cluster

###### `node_username`
- **Required**
Username used for SSH access to the k3s server cluster node

###### `ssh_private_key_pem`
- **Required**
Private key used for SSH access to the k3s server cluster node

Expected to be in PEM format.

###### `k3s_kubernetes_version`
- Default: **`"v1.21.4+k3s1"`**
Kubernetes version to use for k3s server cluster

###### `cert_manager_version`
- Default: **`"1.5.3"`**
Version of cert-manager to install alongside k3s (format: `0.0.0`)

Available versions are found in `files/cert-manager`, where a supported version
is indicated by the presence of `crds-${var.cert_manager_version}.yaml`.

###### `k3s_version`
- Default: **`"v2.6.2"`**
k3s server version (format `v0.0.0`)

###### `k3s_server_dns`
- **Required**
DNS host name of the k3s server

A DNS name is required to allow successful SSL cert generation.
SSL certs may only be assigned to DNS names, not IP addresses.
Only an IP address could cause the Custom cluster to fail due to mismatching SSL
Subject Names.

###### `admin_password`
- **Required**
Admin password to use for k3s server bootstrap

Log in to the k3s server using username `admin` and this password.
