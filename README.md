# Terraform Configuration

## Prerequisites

1. Install Terraform
2. Set up LocalStack for local AWS simulation:
   ```bash
   docker run --rm -p 4566:4566 ministackorg/ministack
   ```
   Refer to [LocalStack documentation](https://ministack.org/docs/iac)

## AWS CLI Setup

### Option 1: Temporary Environment Variables

Set temporary environment variables for your session:

```bash
export AWS_ACCESS_KEY_ID="test"
export AWS_SECRET_ACCESS_KEY="test"
export AWS_DEFAULT_REGION="us-east-1"
```

### Option 2: AWS Profile (Recommended)

Create a local AWS profile:

```bash
aws configure --profile local
```

When prompted, enter:
```
AWS Access Key ID [None]: test
AWS Secret Access Key [None]: test
Default region name [None]: us-east-1
Default output format [None]: json
```

**Note:** All AWS commands will require the `--endpoint-url=http://localhost:4566` flag.

## Convenience Alias

To simplify commands, add an `awslocal` alias to your shell configuration (`~/.bashrc` or `~/.zshrc`):

```bash
# awslocal: aws CLI with local endpoint and local profile
awslocal() {
  # preserve original quoting/word-splitting for passed args
  local args=("$@")
  aws --endpoint-url=http://localhost:4566 --profile local "${args[@]}"
}
export -f awslocal
```

Then use `awslocal` instead of `aws` to automatically include the endpoint and profile flags.