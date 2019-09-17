#!/bin/bash

print_install_stage () {
echo -e "\e[32m=============================================================================\e[0m"
echo " $1"
echo -e "\e[32m=============================================================================\e[0m"
} 

curl -sL https://github.com/operator-framework/operator-lifecycle-manager/releases/download/0.10.0/install.sh | bash -s 0.10.0


print_install_stage "Installing Istio Operator"

# Istio

# Istio-operator is a Kubernetes operator to deploy and manage Istio resources for a Kubernetes cluster.

# Overview
# Istio is an open platform to connect, manage, and secure microservices and it is emerging as the standard for building service meshes on Kubernetes. It is built out on multiple components and a rather complex deployment scheme (around 14 Helm subcharts and 50+ CRDs). Installing, upgrading and operating these components requires deep understanding of Istio and Helm (the standard/supported way of deploying Istio).

# The goal of the Istio-operator is to automate and simplify these and enable popular service mesh use cases (multi cluster federation, canary releases, resource reconciliation, etc) by introducing easy higher level abstractions.


kubectl create -f https://operatorhub.io/install/istio.yaml


print_install_stage "Installing Jaeger Operator"
# https://operatorhub.io/operator/jaeger

# Community Jaeger Operator

# Jaeger, inspired by Dapper and OpenZipkin, is a distributed tracing system released as open source by Uber Technologies. It is used for monitoring and troubleshooting microservices-based distributed systems.

# Core capabilities
# Jaeger is used for monitoring and troubleshooting microservices-based distributed systems, including:

# Distributed context propagation
# Distributed transaction monitoring
# Root cause analysis
# Service dependency analysis
# Performance / latency optimization
# OpenTracing compatible data model
# Multiple storage backends: Cassandra, Elasticsearch, memory.
# Operator features
# Multiple modes - Supports allInOne, production, and streaming modes of deployment.

# Configuration - Directly pass down all supported Jaeger configuration through the Operator.

# Storage - Configure storage used by Jaeger. By default, memory is used. Other options include elasticsearch or cassandra. On OpenShift, the operator can delegate creation of an Elasticsearch cluster to the Elasticsearch Operator if deployed.

# Agent - can be deployed as sidecar and/or daemonset.

# UI - Optionally setup ingress (Kubernetes) or secure route (OpenShift) to provide access to the Jaeger UI.

# Before you start
# Ensure that the appropriate storage solution, that will be used by the Jaeger instance, is available and configured.
# If intending to deploy an Elasticsearch cluster via the Jaeger custom resource, then the Elasticsearch Operator must first be installed.
# Troubleshooting
# https://www.jaegertracing.io/docs/latest/troubleshooting/
# Example Configuration
# A more complex Jaeger instance taken from the documentation:

# apiVersion: jaegertracing.io/v1
# kind: Jaeger
# metadata:
#   name: my-jaeger
# spec:
#   strategy: allInOne
#   allInOne:
#     image: jaegertracing/all-in-one:latest
#     options:
#       log-level: debug
#   storage:
#     type: memory
#     options:
#       memory:
#         max-traces: 100000
#   ingress:
#     enabled: false
#   agent:
#     strategy: DaemonSet
#   annotations:
#     scheduler.alpha.kubernetes.io/critical-pod: ""

kubectl create -f https://operatorhub.io/install/jaeger.yaml

# Jaeger Operator for Kubernetes - Alternative Install Method
# The Jaeger Operator is an implementation of a Kubernetes Operator.
# Getting started
# To install the operator, run:
# kubectl create namespace observability
# kubectl create -f https://raw.githubusercontent.com/jaegertracing/jaeger-operator/master/deploy/crds/jaegertracing_v1_jaeger_crd.yaml
# kubectl create -f https://raw.githubusercontent.com/jaegertracing/jaeger-operator/master/deploy/service_account.yaml
# kubectl create -f https://raw.githubusercontent.com/jaegertracing/jaeger-operator/master/deploy/role.yaml
# kubectl create -f https://raw.githubusercontent.com/jaegertracing/jaeger-operator/master/deploy/role_binding.yaml
# kubectl create -f https://raw.githubusercontent.com/jaegertracing/jaeger-operator/master/deploy/operator.yaml
# Once the jaeger-operator deployment in the namespace observability is ready, create a Jaeger instance, like:
# kubectl apply -f - <<EOF
# apiVersion: jaegertracing.io/v1
# kind: Jaeger
# metadata:
#   name: simplest
# EOF
# This will create a Jaeger instance named simplest. The Jaeger UI is served via the Ingress, like:
# $ kubectl get ingress
# NAME             HOSTS     ADDRESS          PORTS     AGE
# simplest-query   *         192.168.122.34   80        3m
# In this example, the Jaeger UI is available at http://192.168.122.34.
# The official documentation for the Jaeger Operator, including all its customization options, are available under the main Jaeger Documentation.

print_install_stage "Installing Redis Enterprise Operator"

# https://operatorhub.io/operator/redis-enterprise

# Redis Enterprise
# Redis Enterprise Software is enterprise grade, distributed, in-memory NoSQL database server, fully compatible with open source Redis by Redis Labs. Redis Enterprise Software extends open source Redis and delivers stable high performance, zero-downtime linear scaling and high availability, with significant operational savings.

# Redis Enterprise provides a flexible and cost-effective data platform so developers can focus on rapid, high-quality development for sophisticated use cases that meet the needs of a modern digital enterprise. With Redis Enterprise, you can:

# Enjoy high performance and record-setting low latencies with minimal operational overhead
# Develop highly scalable microservices-based and Kubernetes-orchestrated applications
# Use versatile data structures for a variety of use cases, such as high-speed transactions, user session management, real-time analytics, caching and many more
# Leverage enterprise-grade operational controls for high availability, security and seamless scale
# Automate operational best practices for deploying and managing the Redis Enterprise data platform with built-in Kubernetes Operator support
# Deploy, manage and move applications to and from any cloud for seamless portability
# Core capabilities
# Speed application development and time to market - Unburden developers from the complexity of infrastructure operations and empower them to manage data with maximum flexibility. This helps them build modern applications quickly, make changes rapidly and support a variety of different data tructures, models, relationships and use cases.
# Ensure business continuity with always-on data service - Maintain service uptime and ensure failsafe high availability, instant failover and automatic recovery to protect your applications against unplanned downtime, outages and data loss.
# Design for performance and unmatched user experience - Deliver the highest level of responsiveness and interactive customer experiences with best-inclass exceptional linear scaling high performance through a shared-nothing architecture and in-memory processing.
# Simplify operations with automated lifecycle management and layered orchestration - Automate database provisioning, management and maintenance, and abstract away the complexities of high availability, seamless scale and zero-downtime upgrades with built-in support for Kubernetes and Operators.
# Enjoy multi-level robust security - Provide granular control to meet self-imposed and regulatory compliance regulations and standards with built-in finegrained security controls and data encryption.
# Gain platform independence with flexible deployment options - Ensure portability with multiple deployment options across any cloud of choice for multicloud and hybrid deployments and on-premises.
# Ensure success - Leverage 24x7 enterprise-grade support backed by expertise in managing and scaling hundreds of thousands of Redis databases for thousands of enterprise customers worldwide.
# Future proof investments - Use the most popular database amongst developers, built on open source innovation and entrenched firmly in the application landscape with over 1B downloads on Docker. Redis preserves your investment for years with easy extensibility and versatility through its Modules and support for over 50 different programming languages
# Prerequisites
# A minimum of 3 nodes which support the following requirements

# Nodes Per Cluster - 1 node minimum with at least 2 nodes for advanced cluster features
# RAM - At least 2GB with 4GB recommended
# Storage - At least 10GB of free space with 20GB recommended
# A kubernetes version of 1.8 or higher
# For service broker - a k8s distribution that supports service catalog (see also: service-catalog)

kubectl create -f https://operatorhub.io/install/redis-enterprise.yaml

print_install_stage "Installing Kiali Operator"

.# Kiali Operator

# https://operatorhub.io/operator/kiali

# A Microservice Architecture breaks up the monolith into many smaller pieces that are composed together. Patterns to secure the communication between services like fault tolerance (via timeout, retry, circuit breaking, etc.) have come up as well as distributed tracing to be able to see where calls are going.

# A service mesh can now provide these services on a platform level and frees the application writers from those tasks. Routing decisions are done at the mesh level.

# Kiali works with Istio, in OpenShift or Kubernetes, to visualize the service mesh topology, to provide visibility into features like circuit breakers, request rates and more. It offers insights about the mesh components at different levels, from abstract Applications to Services and Workloads.

# See https://www.kiali.io to read more.

# Prerequisites
# Today Kiali works with Istio. So before you install Kiali, you must have already installed Istio. Note that Istio can come pre-bundled with Kiali (specifically if you installed the Istio demo helm profile or if you installed Istio with the helm option '--set kiali.enabled=true'). If you already have the pre-bundled Kiali in your Istio environment and you want to install Kiali via the Kiali Operator, uninstall the pre-bundled Kiali first. You can do this via this command:

# kubectl delete --ignore-not-found=true all,secrets,sa,templates,configmaps,deployments,clusterroles,clusterrolebindings,ingresses,customresourcedefinitions --selector="app=kiali" -n istio-system
# When you install Kiali in a non-OpenShift Kubernetes environment, the authentication strategy will default to login. When using the authentication strategy of login, you are required to create a Kubernetes Secret with a username and passphrase that you want users to provide in order to successfully log into Kiali. Here is an example command you can execute to create such a secret (with a username of admin and a passphrase of admin):

# kubectl create secret generic kiali -n istio-system --from-literal "username=admin" --from-literal "passphrase=admin"
# Kiali Custom Resource Configuration Settings
# For quick descriptions of all the settings you can configure in the Kiali Custom Resource (CR), see the file kiali_cr.yaml

# Accessing the UI
# By default, the Kiali operator exposes the Kiali UI as a Route on OpenShift or Ingress on Kubernetes. On OpenShift, the default root context path is '/' and on Kubernetes it is '/kiali' though you can change this by configuring the 'web_root' setting in the Kiali CR.

kubectl create -f https://operatorhub.io/install/kiali.yaml

print_install_stage "Installing Grafana Operator"

# https://operatorhub.io/operator/grafana-operator

# Grafana Operator

# A Kubernetes Operator based on the Operator SDK for creating and managing Grafana instances.

# Grafana is an open platform for beautiful analytics and monitoring. For more information please visit the Grafana website

# Current status
# The Operator can deploy and manage a Grafana instance on Kubernetes and OpenShift. The following features are supported:

# Install Grafana to a namespace
# Configure Grafana through the custom resource
# Import Grafana dashboards from the same or other namespaces
# Import Grafana data sources from the same namespace
# Install Plugins (panels)

kubectl create -f https://operatorhub.io/install/grafana-operator.yaml


print_install_stage "Installing Prometheus Operator"

# https://operatorhub.io/operator/prometheus

# Prometheus Operator

# The Prometheus Operator for Kubernetes provides easy monitoring definitions for Kubernetes services and deployment and management of Prometheus instances.

# Once installed, the Prometheus Operator provides the following features:

# Create/Destroy: Easily launch a Prometheus instance for your Kubernetes namespace, a specific application or team easily using the Operator.

# Simple Configuration: Configure the fundamentals of Prometheus like versions, persistence, retention policies, and replicas from a native Kubernetes resource.

# Target Services via Labels: Automatically generate monitoring target configurations based on familiar Kubernetes label queries; no need to learn a Prometheus specific configuration language.

# Other Supported Features
# High availability

# Multiple instances are run across failure zones and data is replicated. This keeps your monitoring available during an outage, when you need it most.

# Updates via automated operations

# New Prometheus versions are deployed using a rolling update with no downtime, making it easy to stay up to date.

# Handles the dynamic nature of containers

# Alerting rules are attached to groups of containers instead of individual instances, which is ideal for the highly dynamic nature of container deployment.

# This Operator will be installed in the "my-prometheus" namespace and will be usable from this namespace only.

kubectl create -f https://operatorhub.io/install/prometheus.yaml

print_install_stage "Installing Aqua Security Operator"

# https://operatorhub.io/operator/aqua

# Aqua Security Operator
# The Aqua Security Operator runs within a Kubernetes cluster, and provides a means to deploy and manage the Aqua Security cluster and components

# Server (sometimes called “console”)
# Database (not recommended for production environments)
# Gateway
# Enforcer (sometimes called “agent”)
# Scanner
# CSP (package containing the Server, Database, and Gateway - not supported, and not for production environments) Use the aqua-operator to -
# Deploy Aqua Security components on Kubernetes
# Scale up Aqua Security components with extra replicas
# Assign metadata tags to Aqua Security components
# Automatically scale the number of Aqua scanners according to the number of images in the scan queue
# Before You Begin Using the Operator CRDs
# Obtain access to the Aqua registry https://www.aquasec.com/about-us/contact-us/

# Kubernetes 1.11, 1.12, 1.13 or 1.14
# The operator in Kubernetes needs to be able to create the all the requirements by passing the parameter requirements as true. You can also create the requirements

# Service account with pull permissions from the Aqua Docker registry
# Secret for the Docker registry
# Secret for the database
# After the Installation
# Once the operator is installed in the cluster, you now can use the CRDs to install the Aqua cluster and components.


kubectl create -f https://operatorhub.io/install/aqua.yaml

kubectl get csv -n operators #Istio, Redis, Kiali
kubectl get csv -n my-grafana-operator
kubectl get csv -n my-aqua
kubectl get csv -n my-prometheus

