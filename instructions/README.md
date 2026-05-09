1. install terraform
2. https://ministack.org/docs/iac using the command: `docker run --rm -p 4566:4566 ministackorg/ministack`


--- set up aws cli:

set temp env vars:
```
export AWS_ACCESS_KEY_ID="test"
export AWS_SECRET_ACCESS_KEY="test"
export AWS_DEFAULT_REGION="us-east-1"
```

Or better way could also create a profile: `aws configure --profile local`
```
run:~/github-repos/terraform$ aws configure --profile local

inputs for example:

AWS Access Key ID [None]: test
AWS Secret Access Key [None]: test
Default region name [None]: us-east-1
Default output format [None]: json
```

Will have to use `--endpoint-url=http://localhost:4566` flag with every command.

Easy way to pass in endpoint flag and local profile flag:
Edit `~/.bashrc` or `~/.zshrc` setting:

copy paste this at the end of the file:
```
# awslocal: aws CLI with local endpoint and local profile
awslocal() {
  # preserve original quoting/word-splitting for passed args
  local args=("$@")
  aws --endpoint-url=http://localhost:4566 --profile local "${args[@]}"
}
export -f awslocal
```

Now instead of using `aws` use `awslocal`. The endpoint and profile flags will be added to the commands automatically saving time.