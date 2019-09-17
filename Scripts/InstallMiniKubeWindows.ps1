# From <https://kubernetes.io/docs/tasks/tools/install-kubectl/#install-kubectl-on-windows> 
# Frim https://blogs.msdn.microsoft.com/wasimbloch/2017/01/23/setting-up-kubernetes-on-windows10-laptop-with-minikube 

choco install kubernetes-cli

# From <https://kubernetes.io/docs/tasks/tools/install-minikube/> 

choco install minikube

# From <https://helm.sh/docs/using_helm/#installing-helm> 

choco install kubernetes-helm

# Example MiniKube start commands. Run after MiniKube is installed. ON Windows make sure switch is connected to the internet and external 

minikube start --memory=24576 --cpus=8 --kubernetes-version=v1.15.2 --vm-driver="hyperv" --hyperv-virtual-switch="vEthernet VoiceShortCuts"
minikube start --memory=24576 --cpus=8 --kubernetes-version=v1.15.2 --vm-driver="hyperv" --hyperv-virtual-switch="vEthernet VoiceShortCuts" --v=7 --logtostderr
minikube start --memory=16384 --cpus=4 --kubernetes-version=v1.15.2 --vm-driver="hyperv" --hyperv-virtual-switch="vEthernet VoiceShortCuts"
minikube start --memory=16384 --cpus=4 --kubernetes-version=v1.15.2 --vm-driver="hyperv" --hyperv-virtual-switch="vEthernet VoiceShortCuts" --v=7 --logtostderr

# If oting to use gVisor

# gVisor depends on the containerd runtime to run in Minikube. When starting minikube, specify the following flags, along with any additional desired flags:
# $ minikube start --container-runtime=containerd  --docker-opt containerd=/var/run/containerd/containerd.sock


minikube start -p gVisor --container-runtime=containerd --docker-opt containerd=/var/run/containerd/containerd.sock --memory=24576 --cpus=8 --kubernetes-version=v1.15.2 --vm-driver="hyperv" --hyperv-virtual-switch="vEthernet VoiceShortCuts" --v=7 --logtostderr

# Enabling gVisor
# To enable this addon, simply run:

minikube addons enable gvisor
# Within one minute, the addon manager should pick up the change and you should see the gvisor pod and gvisor Runtime Class:

kubectl get pod, runtimeclass gvisor -n kube-system
# NAME         READY   STATUS    RESTARTS   AGE
# pod/gvisor   1/1     Running   0          2m52s

# NAME                              CREATED AT
# runtimeclass.node.k8s.io/gvisor   2019-06-15T04:35:09Z
# Once the pod has status Running, gVisor is enabled in Minikube.

# Running pods in gVisor
# To run a pod in gVisor, add the gvisor runtime class to the Pod spec in your Kubernetes yaml:

# runtimeClassName: gvisor
# An example Pod is shown below:

# apiVersion: v1
# kind: Pod
# metadata:
#   name: nginx-untrusted
# spec:
#   runtimeClassName: gvisor
#   containers:
#   - name: nginx


# at this point you can already use kubectl inside powershell, but we're going to set it up inside WSL instead:
$envTEMP = "C:\Temp"
# $env:TEMP will give the current user temp as set at the OS level
kubectl.exe config view > $envTEMP/kubectl-config
minikube.exe docker-env --shell=bash > $envTEMP/minikube-config
cd $envTEMP
# convert line endings to unix format
Get-ChildItem -File -Filter *-config | % { $x = get-content -raw -path $_.fullname; $x -replace "`r`n", "`n" | set-content -path $_.fullname }

# Once the config files have been copied as above then run ConfigureWSL.sh in WSL shell


# You need to clear minikube’s local state:
minikube delete

# Switch Kubernetes Context to MiniKube
kubectl config use-context minikube
# Validate config and context
kubectl config view

# Validate in MiniKube Dashboard
minikube dashboard




