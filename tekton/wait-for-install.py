import sys
import subprocess

cmd = "kubectl get pods --namespace tekton-pipelines --watch"
watcher = subprocess.Popen(cmd.split(), stdout=subprocess.PIPE)

wait_for = [
    b'tekton-pipelines-controller',
    b'tekton-pipelines-webhook',
    b'tekton-triggers-controller',
    b'tekton-triggers-webhook',
    b'tekton-triggers-core-interceptors',
]

while len(wait_for):
    line = watcher.stdout.readline()
    print(str(line))
    for i,pckg in enumerate(wait_for):
        if line.find(pckg) != -1:
            break
    if b'1/1' in line:
        wait_for.pop(i)
watcher.kill()
