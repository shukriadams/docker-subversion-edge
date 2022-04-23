set -e

DOCKERPUSH=0

while [ -n "$1" ]; do 
    case "$1" in
    --dockerpush) 
        DOCKERPUSH=1 ;; 
    esac 
    shift
done

docker build -t shukriadams/subversion-edge .
echo "container built"

if [ $DOCKERPUSH -eq 1 ]; then
    echo "starting docker push"
    TAG=$(git describe --tags --abbrev=0) 
    echo "Tag ${TAG} detected"

    docker tag shukriadams/subversion-edge:latest shukriadams/subversion-edge:"${TAG}"
    docker login -u $DOCKER_USER -p $DOCKER_PASS 
    docker push shukriadams/subversion-edge:$TAG
fi

echo "build complete"