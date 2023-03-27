export INSTALL_K3S_EXEC="server --write-kubeconfig-mode=644 --bind-address=192.168.56.110  --advertise-address=192.168.56.110";
      curl -sfL https://get.k3s.io |  sh -;
      if [[ ! -d "/vagrant/confs" ]]; then
          mkdir /vagrant/confs
      fi;
    #   rm -rf /vagrant/confs/* &>/dev/null;
      cp /var/lib/rancher/k3s/server/node-token /vagrant/confs/master-node-token;
      cp /etc/rancher/k3s/k3s.yaml /vagrant/confs/k3s.yaml;            



echo "[APP-1] : deploying..." 
kubectl create configmap app1-html --from-file /vagrant/confs/k3s/html/app1/app.html
kubectl create configmap app2-html --from-file /vagrant/confs/k3s/html/app2/app.html
kubectl create configmap app3-html --from-file /vagrant/confs/k3s/html/app3/app.html

kubectl apply -f /vagrant/confs/k3s/app.deployment.yaml
kubectl apply -f /vagrant/confs/k3s/app.service.yaml
kubectl apply -f /vagrant/confs/k3s/app.ingress.yaml


