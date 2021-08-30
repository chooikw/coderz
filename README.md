# Coderz

This project utilises [code-server](https://github.com/cdr/code-server) by coder.com to orchestrate development environment for your software development project team.

## Usage
1. Build the docker image, mapping current user into the container user **code**
```
docker build -t coderz --build-arg UID=$(id -u) --build-arg GID=$(id -u) .
```
2. Generate environment for new developer:
```
 ./newuser.sh -u USERNAME -p PORT -c COMPANY
```
3. Run developer docker:
```
./docker-USERNAME.sh
```

### Pro tips:
1. Use unique port number for each developers, eg: 8080,8081... and use **nginx** to proxy subdomain to that docker port
2. Configure the docker-USERNAME.sh to bind more development ports, 8000 is default laravel serve port
