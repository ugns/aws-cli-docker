# AWS CLI in Docker

Containerized AWS CLI on Debian stable to avoid requiring the aws cli to be installed locally.

Includes the SSM Session Manager plugin to allow for remote session access to EC2 instances.

## Build

```
docker build -t jtbouse/aws-cli .
```

Automated build on Docker Hub

[![DockerHub Badge](http://dockeri.co/image/jtbouse/aws-cli)](https://hub.docker.com/r/jtbouse/aws-cli/)

## Usage

Configure:

```
$ aws configure
AWS Access Key ID [None]: accesskey
AWS Secret Access Key [None]: secretkey
Default region name [None]: us-east-1
Default output format [None]:
```

Upload file to S3:

```
$ aws s3 cp ../sample-file.yaml s3://somebucket/example/
```

Caveat: Because `aws` mounts the current directory as `/project`, paths to local files must be relative to the current directory.

Start SSM Session:

```
$ aws ssm start-session --target instance-id-to-connect
```

## Install

To use `aws` as a drop-in replacement for calls to the aws-cli, use one of the following methods:

Add an alias to your shell:

```
alias aws='docker run --rm -t $(tty &>/dev/null && echo "-i") -v ${HOME}/.aws:/root/.aws -v "$(pwd):/project" jtbouse/aws-cli'
```

Or drop it into your path named `aws`:

```
$ curl -o /usr/local/bin/aws https://raw.githubusercontent.com/jtbouse/aws-cli/master/aws
$ chmod a+x /usr/local/bin/aws
```

## Maintenance

- The Docker image build & publish is automated by DockerHub for master commits and tags.
- The awscli and s3cmd packages have handcoded versions in the Dockerfile that need to be bumped manually.

## References

AWS CLI Docs: https://aws.amazon.com/documentation/cli/
