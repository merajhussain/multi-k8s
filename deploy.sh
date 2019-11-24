docker build -t merajhussain1/multi-client:latest -t merajhussain1/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t merjahussain1/multi-server:latest -t merajhussain/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t merajhussain1/multi-worker:latest -t merajhussain1/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push merajhussain1/multi-client:latest
docker push merajhussain1/multi-server:latest
docker push merajhussain1/multi-worker:latest


docker push merajhussain1/multi-client:$SHA
docker push merajhussain1/multi-server:$SHA
docker push merajhussain1/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=merajhussain1/multi-server:$SHA
kubectl set image deployments/client-deployment client=merajhussain1/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=merajhussain1/multi-worker:$SHA

