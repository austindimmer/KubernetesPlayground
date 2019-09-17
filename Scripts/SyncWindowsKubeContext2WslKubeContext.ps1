# at this point you can already use kubectl inside powershell, but we're going to set it up inside WSL instead:
$envTEMP = "C:\Temp"
# $env:TEMP will give the current user temp as set at the OS level
kubectl.exe config view > $envTEMP/kubectl-config
minikube.exe docker-env --shell=bash > $envTEMP/minikube-config
cd $envTEMP
# convert line endings to unix format
Get-ChildItem -File -Filter *-config | % { $x = get-content -raw -path $_.fullname; $x -replace "`r`n", "`n" | set-content -path $_.fullname }