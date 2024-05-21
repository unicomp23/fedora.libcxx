clear
docker build --no-cache -t libcxx-builder . 2>&1 | tee ~/tmp/docker.build.log.txt
docker run -it libcxx-builder /bin/bash
