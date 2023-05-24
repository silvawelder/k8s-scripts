#!/bin/bash 

kns() {
  export NAMESPACE=$1
  kubectl config set-context --current --namespace=$NAMESPACE
}

cat ns-list.csv | while read NAME_SPACE;

do
    echo "Running on namespace: $NAME_SPACE"

    echo "Setting up namespace:"
    kns $NAME_SPACE
    kubectl get pods |awk '{print $1 "\t" $3}' | awk -F '\t' '{sub(/-[^-]*-[^-]*$/, "", $1); print $1 ";" $2}' >> outputs/$NAME_SPACE.csv


done
