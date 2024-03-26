#!/bin/bash
docker run --rm -it   -v $PWD:$HOME -v $HOME/.aws:$HOME/.aws -w $HOME -v /etc/passwd:/etc/passwd:ro -u root --entrypoint sh hashicorp/terraform:1.1.5 $@