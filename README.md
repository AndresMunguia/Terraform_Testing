# Terraform_Testing


This repo is a testing environment used to practice and learn automation with IaC tools on AWS platform. 


## Challenge

For this week's challenge I created a serverless infrastucture which is made of 2 Lambdas and 2 REST APIs.

### Tools Used:

- Terraform
- Terraform Cloud
- Amazon CLI
- VCS
- Git
- Postman
- VScode
- GitHub Actions


## How It Looks:

Once the infrastructure is built, we may see it on AWS console, it will relfect the 2 Lambdas:

![image](https://user-images.githubusercontent.com/67026239/201937443-fc3a94b4-2fa5-496e-be13-76389e7e6a84.png)

As well as the 2 REST APIs:

![image](https://user-images.githubusercontent.com/67026239/201937746-ba6c5e32-d13a-4522-8d4d-8cfed91273e3.png)


## How this repo works:

This repo has a automation pipeline that, everytime there is a push or pull on main branch, it will validate the code using:

'
terraform validate
'

it will also format everything using:

'
terraform fmt
'

and finally, if validation was successful, it will apply the changes, upload .tfstate to Terraform Cloud and deploy the infra, all this by executing:

'
terraform apply
'
