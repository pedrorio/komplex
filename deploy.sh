docker build -t pedrorio/complex-client:latest -t pedrorio/complex-client:$SHA -f ./client/Dockerfile ./client/
docker build -t pedrorio/complex-server:latest -t pedrorio/complex-server:$SHA -f ./server/Dockerfile ./server/
docker build -t pedrorio/complex-worker:latest -t pedrorio/complex-worker:$SHA -f ./worker/Dockerfile ./worker/

docker push pedrorio/complex-client:latest
docker push pedrorio/complex-server:latest
docker push pedrorio/complex-worker:latest

docker push pedrorio/complex-client:$SHA
docker push pedrorio/complex-server:$SHA
docker push pedrorio/complex-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=pedrorio/complex-server:$SHA
kubectl set image deployments/client-deployment client=pedrorio/complex-client:$SHA
kubectl set image deployments/worker-deployment worker=pedrorio/complex-worker:$SHA