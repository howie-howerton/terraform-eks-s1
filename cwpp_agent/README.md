# SentinelOne CWPP agent
Deploy autonomous CWPP across cloud, container, and server workloads. The building blocks of your secure cloud transformation are visibility, file integrity monitoring, protection,
and compliance.

How to install the SentinelOne CWPP agent to a Kubernetes Cluster using “helm”.

Authenticate to GitHub Packages with Docker:
sudo docker login docker.pkg.github.com --username <username>

**1. Pull the latest s1-agent GA container image:**
```
docker pull docker.pkg.github.com/S1-Agents/cwpp_agent/s1-agent:GA
```


**2. Tag the s1-agent container image with your container registry:**
```
sudo docker tag docker.pkg.github.com/S1-Agents/cwpp_agent/s1-agent:GA <registry>/s1-agent:GA
```


**3. Push the tagged container image to your container registry:**
```
sudo docker push <registry>/s1-agent:GA
```


**4. Pull the latest s1-helper GA container image:**
```
docker pull docker.pkg.github.com/S1-Agents/cwpp_agent/s1-helper:GA
```


**5. Tag the s1-helper container image with your container registry:**
```
sudo docker tag docker.pkg.github.com/S1-Agents/cwpp_agent/s1-helper:GA <registry>/s1-helper:GA
```


**6. Push the tagged container image to your container registry:**
```
sudo docker push <registry>/s1-helper:GA
```

**7. Clone the helm charts repository:**
```
git clone git@github.com:S1-Agents/cwpp_agent.git
```

**8. Create a namespace for the SentinelOne installation:**
```
kubectl create namespace <namespace>
```

**9. If you do not have already secret to access the container registry, you may create it with the following command:**
```
kubectl create secret -n <namespace> docker-registry <secret-name> --docker-server=<registry> --docker-username=<username> --docker-password=<personal-access-key> --docker-email=<email>
```

**10. Open “helm_charts/sentinelone/values.yaml” for editing to configure the installation.**

**11. Replace “name” value using the secret name from above:**
```
...
image:
  pullPolicy: IfNotPresent
  imagePullSecrets:
    # EDIT HERE
    - name: <YOUR REGISTRY SECRET>
  nameOverride: ""
  fullnameOverride: ""
...
```

**12. Replace “repository” and “tag” values using the same tag of s1-helper that was pushed to the registry:**
```
...
helper:
  # Specifies whether a helper should be created
  create: true
  # The name of the helper to use.
  # If not set and create is true, a name is generated using the fullname template
  name: s1-helper
  Image:
    # EDIT HERE
    repository: "<YOUR HELPER IMAGE PATH>"
    tag: "<YOUR HELPER IMAGE TAG>"
...
```


**13. Replace “repository” and “tag” values using the same tag of s1-agent that was pushed to the registry, and edit “site_key” value:**
```
...
agent:
  # Specifies whether an agent should be created
  create: true
  # The name of the agent to use.
  # If not set and create is true, a name is generated using the fullname template
  name: s1-agent
  Image:
    # EDIT HERE
    repository: "<YOUR AGENT IMAGE PATH>"
    tag: "<YOUR AGENT IMAGE TAG>"
  env:
    # If secrets.create is true, the site token will be saved as a secret
    # EDIT HERE
    site_key: "<YOUR SITE TOKEN>"
  annotations: {}
  nodeSelector: {}
  tolerations: []
...
```

**14. Choose a name for the deployment and the namespace from above before installation:**
```helm install <release_name> --namespace=<namespace> ./helm_charts/sentinelone```

Expected result:
```
   NAME: <release_name>
   LAST DEPLOYED: Thu Jan  2 15:52:04 2020
   NAMESPACE: <namespace>
   STATUS: deployed
   REVISION: 1
```

**15. Check all of the pods under the namespace:**
```
kubectl get pods -n <namespace>
```

Expected result (4 nodes, one agent per node):
```
   NAME                                      READY   STATUS    RESTARTS   AGE
   s1-agent-2xmvw                            1/1     Running   0          5m13s
   s1-agent-2zzgw                            1/1     Running   0          5m13s
   s1-agent-kfvmw                            1/1     Running   0          5m13s
   s1-agent-nl6hr                            1/1     Running   0          5m13s
   s1-helper-56cf7fd4c-tqcjb                 1/1     Running   0          5m13s
```

**16. View of the current deployed SentinelOne release:**
```
helm list -n <namespace>
```

