# Terraform AWS Modules Template

[![Terraform Version](https://img.shields.io/badge/Terraform%20Version-0.12.31-blue.svg)](https://releases.hashicorp.com/terraform/)
[![Release](https://img.shields.io/github/release/traveloka/terraform-aws-sqitch-codebuild-shared-resources.svg)](https://github.com/traveloka/terraform-aws-sqitch-codebuild-shared-resources/releases)
[![Last Commit](https://img.shields.io/github/last-commit/traveloka/terraform-aws-sqitch-codebuild-shared-resources.svg)](https://github.com/traveloka/terraform-aws-sqitch-codebuild-shared-resources/commits/master)
[![Issues](https://img.shields.io/github/issues/traveloka/terraform-aws-sqitch-codebuild-shared-resources.svg)](https://github.com/traveloka/terraform-aws-sqitch-codebuild-shared-resources/issues)
[![Pull Requests](https://img.shields.io/github/issues-pr/traveloka/terraform-aws-sqitch-codebuild-shared-resources.svg)](https://github.com/traveloka/terraform-aws-sqitch-codebuild-shared-resources/pulls)
[![License](https://img.shields.io/github/license/traveloka/terraform-aws-sqitch-codebuild-shared-resources.svg)](https://github.com/traveloka/terraform-aws-sqitch-codebuild-shared-resources/blob/master/LICENSE)
![Open Source Love](https://badges.frapsoft.com/os/v1/open-source.png?v=103)

This repository contains a terraform module to create reusable things to be used by CodeBuild pipelines for deploying Sqitch SQL migration framework to RDS instances in the same account. 

## Table of Content

- [Prerequisites](#Prerequisites)
- [Dependencies](#Dependencies)
- [Examples](#Examples)
- [Versioning](#Versioning)
- [Contributing](#Contributing)
- [Contributor](#Contributor)
- [License](#License)
- [Acknowledgments](#Acknowledgments)

## Prerequisites

For Terraform version, this module has been tested on terraform 0.12.31. It might not run correctly on 0.11 or below. 

For terraform Providers:

- Provider [aws](https://www.terraform.io/docs/providers/aws/index.html) version `2.70.0`. We have not tested usage of `3.0.0` and above.
- Provider [random](https://www.terraform.io/docs/providers/random/index.html) version `2.3.0`.

## Dependencies

This module doesn't require any extra module to be run independently first.

## Examples

Go to the `example` directory for example terraform code that uses this module.

## Versioning

We use [SemVer](https://semver.org/) for our versioning

**Latest stable version** `v1.1.0`, 2nd June 2021

**Latest version** `v1.1.0`, 2nd June 2021

**Latest release** :

- Allow usage of Customer Managed Keys for SecureString encryption & decryption

Please also see our `CHANGELOG` document in this repository and see more detail

## Contributing

Please see our example of `CONTRIBUTING` document

## Contributor

For question, issue, and pull request you can contact these people

- [Christianto Handojo](https://github.com/handojo1) (**Author**)

## License

This module is licensed under Apache License 2.0 - see the `LICENSE` file for details

## Acknowledgments

Finally, add some useful link and source and give appreciation to their share

- [Readme Template](https://gist.github.com/PurpleBooth/109311bb0361f32d87a2)
- [Friendly Readme](https://rowanmanning.com/posts/writing-a-friendly-readme/)
- [Opensource Guide](https://opensource.guide/starting-a-project/)
- Inspiration from other open source
