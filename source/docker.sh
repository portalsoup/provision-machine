### Docker ###
prunedocker() {
  docker stop $(docker ps -aq) > /dev/null
  docker system prune
}

watchImages() {
  watch -n 1 -d "docker image list --format 'table {{.Repository}}:{{.Tag}}\t{{.ID}}\t{{.CreatedSince}}' | sort -k1"
  alert "Watching images ended"
}

watchContainers() {
  watch -n 1 -d "docker ps --format 'table {{.Image}}\t{{.ID}}\t{{.RunningFor}}' | sort -k1"
  alert "Watching containers ended"
}

alias dfimage="docker run -v /var/run/docker.sock:/var/run/docker.sock --rm alpine/dfimage" # Generate dockerfile from image for inspection
