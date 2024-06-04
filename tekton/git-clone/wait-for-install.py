import sys
import subprocess

cmd = "kubectl get pods --namespace tekton-pipelines --watch"
watcher = subprocess.Popen(cmd.split(), stdout=subprocess.PIPE)

wait_for = [bytes(arg,'ascii') for arg in sys.argv[1:]]
while len(wait_for):
    line = watcher.stdout.readline()
    print(str(line))
    for i,pckg in enumerate(wait_for):
        if line.find(pckg) != -1:
            break
    if b'1/1' in line:
        wait_for.pop(i)
watcher.kill()
