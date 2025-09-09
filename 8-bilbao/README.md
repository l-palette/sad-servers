Briefly:



---

# Task

There's a Kubernetes Deployment with an Nginx pod and a Load Balancer declared in the manifest.yml file. The pod is not coming up. Fix it so that you can access the Nginx container through the Load Balancer.

There's no "sudo" (root) access.

Root (sudo) Access: False

Test: Running curl 10.43.216.196 returns the default Nginx Welcome page.

# Solution

kubernetes uses local registry
```bash
containers:
      - name: nginx
        image: localhost:5000/nginx
```

```bash
admin@ip-10-1-11-15:~$ docker ps
CONTAINER ID   IMAGE        COMMAND                  CREATED         STATUS         PORTS                                       NAMES
de7ed830b3c2   registry:2   "/entrypoint.sh /etc…"   19 months ago   Up 2 minutes   0.0.0.0:5000->5000/tcp, :::5000->5000/tcp   docker-registry
```


and there is an nginx image
```bash
admin@ip-10-1-13-59:~$ curl http://localhost:5000/v2/_catalog
{"repositories":["nginx"]}
```

the pod is pending
```bash
admin@ip-10-1-13-59:~$ kubectl get pods
NAME                                READY   STATUS    RESTARTS   AGE
nginx-deployment-67699598cc-zrj6f   0/1     Pending   0          598d
```
```bash
admin@ip-10-1-13-59:~$ kubectl describe pod nginx-deployment-67699598cc-zrj6f | tail -n 6
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type     Reason            Age                    From               Message
  ----     ------            ----                   ----               -------
  Warning  FailedScheduling  598d                   default-scheduler  0/2 nodes are available: 1 node(s) didn't match Pod's node affinity/selector, 1 node(s) had untolerated taint {node.kubernetes.io/unreachable: }. preemption: 0/2 nodes are available: 2 Preemption is not helpful for scheduling..
  Warning  FailedScheduling  2m58s (x2 over 7m58s)  default-scheduler  0/2 nodes are available: 1 node(s) didn't match Pod's node affinity/selector, 1 node(s) had untolerated taint {node.kubernetes.io/unreachable: }. preemption: 0/2 nodes are available: 2 Preemption is not helpful for scheduling..
admin@ip-10-1-13-59:~$ 
```



starting config
```bash
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
  labels:
    app: nginx
spec:
  replicas: 1
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: localhost:5000/nginx
        ports:
        - containerPort: 80
        resources:
          limits:
            memory: 2000Mi
            cpu: 100m
          requests:
            cpu: 100m
            memory: 2000Mi
      nodeSelector:
        disk: ssd

---
apiVersion: v1
kind: Service
metadata:
  name: nginx-service
spec:
  selector:
    app: nginx
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
  clusterIP: 10.43.216.196
  type: LoadBalancer
```
...