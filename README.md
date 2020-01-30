Update static_server

```
docker build -t ifaniry/cf_static_server:beta .
# or : docker build --no-cache --pull -t ifaniry/cf_static_server:beta .
docker push ifaniry/cf_static_server:beta
```

Changing CF stack/rootfs

```
cf push MY-AWESOME-APP -s ifaniry/cf_static_server:beta
# or cf push MY-AWESOME-APP -s "docker.pkg.github.com/$GITHUB_REPOSITORY/cf_static_server:latest"
```