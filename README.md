# gmt-book

To compile the files and produce the book 
in PDF format you can run the script
```
./scripts/build.sh
```
This only produces `book.pdf` at the time being.

The old method was:
```
make pdfs
```

If you don't have a correctly configured unix-like system you can install docker and use the following command:
```
docker run --rm -i --user="$(id -u):$(id -g)" --net=none -v "$PWD":/data blang/latex:ubuntu ./scripts/build.sh
```

To mimic github actions you could install `act` and give the command: 
```
act push
```
