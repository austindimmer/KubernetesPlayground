# From https://medium.com/@ddebastiani/install-kubernetes-on-windows-wsl-c36f6b2571d2

# Run the following Powershell first

# # at this point you can already use kubectl inside powershell, but we're going to set it up inside WSL instead:
# $envTEMP = "C:\Temp"
# # $env:TEMP will give the current user temp as set at the OS level
# kubectl.exe config view > $envTEMP/kubectl-config
# minikube.exe docker-env --shell=bash > $envTEMP/minikube-config
# cd $envTEMP
# # convert line endings to unix format
# Get-ChildItem -File -Filter *-config | % { $x = get-content -raw -path $_.fullname; $x -replace "`r`n", "`n" | set-content -path $_.fullname }

# pwsh -File ".\SyncWindowsKubeContext2WslKubeContext.ps1" -NonInteractive



# install kubectl if not already installed
# curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && \
#   chmod +x kubectl && \
#   sudo mv kubectl /usr/local/bin/
# cd into windows' TEMP folder.
# Since paths are different from unix, we need to normalise them first
# WINDOWS_TEMP_DIR=/mnt/$(/mnt/c/Windows/System32/cmd.exe /c echo\|set /p=%TEMP% | sed --expression='s|\\|/|g' | sed --expression='s|^\([A-Za-z]\):|\L\1|')
WINDOWS_TEMP_DIR=/mnt/c/temp
echo $WINDOWS_TEMP_DIR
pwd
cd $WINDOWS_TEMP_DIR
mkdir ~/.{kube,minikube}
mv kubectl-config ~/.kube/config
mv minikube-config ~/.minikube/docker-env
# convert windows paths to unix format
sed -i 's|\\|/|g' ~/.{kube,minikube}/{config,docker-env}
sed -i 's|\([ "]\)\([A-Za-z]\):|\1/mnt/\L\2|' ~/.{kube,minikube}/{config,docker-env}
kubectl config use-context minikube
# optional, if you want to use a local docker image
# e.g. docker build -t <your-image-name> .
eval $(cat ~/.minikube/docker-env)
# we can now launch a sample app
kubectl run hello-minikube --image=k8s.gcr.io/echoserver:1.4 --port=8080
# alternatively you can deploy your local docker image with
# kubectl run hello-minikube --image=<your-image-name> --port=<someport> --image-pull-policy=Never

#That’s almost everything needed to see your service running — at this stage, it will only be accessible to kubernetes’ internal network.
#Let’s make sure the deployment is working first:
kubectl get deployment
# NAME             DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
# hello-minikube   1         1         1            1           21s
kubectl get pod
# NAME                              READY     STATUS    RESTARTS   AGE
# hello-minikube-7844bdb9c6-wkqtb   1/1       Running   0          34s
# Now we can expose the service to the outside world:
kubectl expose deployment hello-minikube --type=NodePort
# service "hello-minikube" exposed
# $ kubectl get service hello-minikube
# NAME             TYPE       CLUSTER-IP     EXTERNAL-IP   PORT(S)          AGE
# hello-minikube   NodePort   10.110.6.111   <none>        8080:30668/TCP   19s
# ☝ ️30668 externally reachable port

# We need to go back to powershell to see the service in action:
## should open a browser tab showing the service just deployed

# minikube.exe service hello-minikube