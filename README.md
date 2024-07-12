This project has been archived. It turns out that AWS Lambdas have strict compute and time restrictions that make them unsuitable for model fitting. 

# Lambda wrapper around the epikinetics R package
[![Project Status: Concept – Minimal or no implementation has been done yet, or the repository is only intended to be a limited example, demo, or proof-of-concept.](https://www.repostatus.org/badges/latest/concept.svg)](https://www.repostatus.org/#concept)

To run these scripts you will need AWS credentials. 
You will then have to [install](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) and 
[configure](https://docs.aws.amazon.com/cli/v1/userguide/cli-chap-configure.html) the aws cli.

## Scripts
* `create-repo` - script used to create a new Docker repo
* `build` - builds the Docker image that will be used as a Lambda
* `push` - pushes a locally built image to the repo
* `test` - instantiate the Lambda

## Creating a new Lambda
Once the Docker image has been built and pushed, you have to create a new Lambda using that image. This can be done via 
the cli but it is probably easier to just use the AWS console.
