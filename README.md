# Setting a connection pool using PgBouncer for PostgreSQL

Setting up a connection pool for PostgreSQL does not have to be a complicated process.
Actually, it can be a reasonably simple procedure if you know enough. In this repo you'll
find a simple tutorial on how to deploy PgBouncer alongside a Postgres database in a
kubernetes environment.

> Note: This tutorial uses kustomize to configure and setup the deployment manifest.
        If you never used it before, it is a [simple and powerful tool](https://kustomize.io/)
        to customize kubernetes deployments.

## Requirements

- kubernetes cluster (e.g., miniconda, k3s/k3d, kind)
- kubectl (1.16+ kustomize)
- Linux / MacOS

# Setting up the environment / resources

1. Start the kubernetes cluster
```bash
minikube start
```

2. Generate k8s deploy manifest
```bash
kubectl kustomize > deploy.yaml
```

3. Create the k8s resources
```bash
kubectl create -f deploy.yaml
```

4. Test the setup
```bash
kubectl -n database exec -it pg-0 -- bash -c 'PGPASSWORD=password_user1 psql -U user1 -h pgbouncer -p 5439 -d sandbox -c " SELECT current_database();"'
```

5. Destroy the k8s resources
```bash
kubectl delete -f deploy.yaml
```

6. Clean remaining artifacts
```bash
rm deploy.yaml
```

## References

- https://www.pgbouncer.org/config.html
- https://gitlab.com/aztek-io/oss/containers/pgbouncer-container
- https://www.cybertec-postgresql.com/en/pgbouncer-authentication-made-easy/

# License

[MIT License](LICENSE)