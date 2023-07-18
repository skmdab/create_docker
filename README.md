# Create Docker

This repository contains scripts and configurations for deploying a Docker instance on AWS.

## Prerequisites

Before you can use these scripts, ensure that you have the following:

- Linux or macOS environment
- AWS CLI installed and configured with credentials
- Jenkins installed and running
- Git installed
- Ansible installed and running
- The Jenkins user must be part of the Docker group

Please make the following modifications in the `aws_create` script according to your environment:
- VPC-ID
- Availability Zone (AZ)
- Security groups
- AMI-ID
- Subnets
- PEM file name

## Create Jenkins Job with a Pipeline and choose "Pipeline Script from SCM".

To-do's in Jenkins:
------------------------------------------
1. Add the AWS PEM file in Jenkins credentials with the ID "pemfile".

Please ensure you have completed the above steps before proceeding.

## Contributing

Contributions are welcome! If you would like to contribute to this project, please follow these guidelines:

1. Fork the repository.
2. Create a new branch for your feature or bug fix.
3. Make your changes and test them thoroughly.
4. Commit your changes and push them to your forked repository.
5. Submit a pull request, explaining the purpose and changes of your contribution.

## License

This project is licensed under the [MIT License](LICENSE).
