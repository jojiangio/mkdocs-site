# SRE Cheatsheet

## Python Essentials
### HTTP Requests

```bash
import requests
res = requests.get("https://example.com/api")
data = res.json()
```

### JSON Parsing

```bash
# Access field
field = data["key"]
# Loop over list of dicts
values = [item["key"] for item in data]
# Filter
filtered = [x for x in data if x["status"] == "failed"]
```

### JSON <-> Python

```bash
# JSON string → Python dict
data = json.loads('{"name": "Alice", "age": 30}')

# Python dict → JSON string
json_str = json.dumps(data)

print(data["name"])   # Alice
print(json_str)       # {"name": "Alice", "age": 30}
```

### Common Modules
```bash
import os        # env vars, file paths
import json      # parse/serialize JSON
import datetime  # handle timestamps
from collections import defaultdict
```

### Aggregate example
```bash
from collections import defaultdict
counts = defaultdict(int)
for log in data:
    counts[log["endpoint"]] += log["count"]
```

## Bash/CLI Essentials
### Text processing
```
grep "ERROR" logfile.log
awk '{print $1, $2}' file.txt
sed 's/old/new/' file.txt
cut -d',' -f1 data.csv
sort file.txt | uniq -c
```

## Json Parsing with jq
```bash
cat data.json | jq '.[] | select(.status=="failed") | .job_id'
cat data.json | jq '[.[] | .cpu] | add / length'  # average CPU
```

## Curl / HTTP
```bash
curl -s https://example.com/api | jq '.'
curl -X POST -H "Content-Type: application/json" -d '{"key":"value"}' https://example.com/api
```

## Kubernetes / Container

### Pod Inspection
```bash
kubectl get pods
kubectl describe pod <pod-name>
kubectl logs <pod-name>          # current
kubectl logs <pod-name> --previous # previous crash
```

### Exec into Pod
```bash
kubectl exec -it <pod-name> -- sh
kubectl exec -it <pod-name> -- curl <service>:<port>
```

### Common Commands
```bash
kubectl get svc,deploy,po
kubectl apply -f deployment.yml
kubectl delete pod <pod-name>
```



