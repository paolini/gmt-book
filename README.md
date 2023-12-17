# gmt-book

You need docker to build the files.

Build with:

```
docker run --rm -i --user="$(id -u):$(id -g)" --net=none -v "$PWD":/data blang/latex:ubuntu scripts/build.sh
```

Use 
```
act push
```
to mimic github build.