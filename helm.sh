#!/bin/bash

helm package chart
helm repo index --url https://lukas-pastva.github.io/helm-argie --merge index.yaml .