docker_repo=docker.io/clarkzjw
docker_image=wordpress
docker_image_tag=$(date -u +%Y%m%d)
sudo docker build -t $docker_repo/$docker_image:"$docker_image_tag" .
sudo docker push $docker_repo/$docker_image:"$docker_image_tag"
