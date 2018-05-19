docker build -t spmovy .
docker run -d -p 8080:8080 --name web-spmovy spmovy