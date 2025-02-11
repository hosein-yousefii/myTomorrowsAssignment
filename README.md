# myTomorrowsAssignment
**Please do not consider it as final approach, there is always room to make it better**

## Approaches
There are lots of solutions that can be implemented to meet the requirements, and it depends on several factors like
application type, the way development team is working, the way company infra and applications need to be managed,
number of applications, number of developers and environments, time to deliver applications and other important points.

In this assignment I see 2 approaches:
- Helm centralization, Create a helm template for any type of applications.
- App type specific, Create helm template for a sepecific application type that can be used for other application with
same type

The approach that I followed is in between:
- we have a helm template that is not fully customized, but it's enough to be able to integrate it to applications.
- there are rooms to make it fully customizable, in this case we need to specify the application values on terraform level.

## Usage
In order to run this application on your local system, I suggest to run it on a VM with helm and terraform command.
```
# scenario is tested on ubuntu20
./start-up.sh
```

## Containerization
- for each application and repository read the README.md.
- Registry: find all images [here](https://github.com/hosein-yousefii?tab=packages)

# Answers to assignment questions in Readme.md

**Explaining how the code works, how to deploy the application and how to verify its successful deployment.**
* on each directory Readme.md is provided with needed information, but generally:
 There is a flask-basis docker image which provide the necessary steps to build an image. Using ONBUILD option
helps to do not waste time on building unnecessary steps on basis image, and MOUNT CACHE option is available if needed.
* a helm template is provided (it's not fully customizable, it's just a demonstration of template), within the values.yaml
you can control options in helm, like how many secret to configure, security context, ingress endpoints, probes and other features.
I used my own helm function to improve customization, and it's used as dependency.
* the way that the terraform module is written is general and can be used for any other helm releases, only configuration of that application
needs to be placed under any environments, and terraform based on the workspace switch the environments, also it's possible to apply any customization on va
lues.yaml or provide a separate values.yaml
* minikube with ingress and metallb will be installed through the script.

by executing the start-up.sh script it starts to implement minikube and then deploy application using terraform.

**Explain the decisions made during the design and implementation of the solution.**
* Since it's required that the Helm chart and Terraform be written in a reusable way for other
applications, I also created a Docker base image that can be reused by applications of the same
type.
* A Helm template that works for every application requires extensive customization. I made some
adjustments to make it partially compatible, ensuring that basic configurations are customizable
unless special requirements arise.
* I assumed you might want to centralize Helm templates and use Terraform to modify variables for
different application types, which is a good approach depending on the overall CI/CD design. In
this case, you need to ensure that the same configuration is copied for each environment. Another
approach is to package the chart and move it through different environments to guarantee that the
same tested package from development is used.
* These decisions depend on several factors, including CI/CD design, delivery time, and the
number of applications.
* Terraform design follows this structure:
```
applications/
└── environments
    ├── common.tfvars
    ├── dev
    │   ├── dev-common.tfvars
    │   ├── flask-auth-app
    │   │   └── terraform.tfvars
    │   │   └── values.yaml
    │   ├── flask-config-app
    │   │   └── terraform.tfvars
    │   └── flask-stream-app
    │       └── terraform.tfvars
    ├── prod
    │   ├── flask-auth-app
    │   │   └── terraform.tfvars
    │   ├── flask-config-app
    │   │   └── terraform.tfvars
    │   ├── flask-stream-app
    │   │   └── terraform.tfvars
    │   └── prod-common.tfvars
    └── test
```
* Different environments are structured based on our setup. At the top level, we have common
variables that are shared across all environments or mandated by company policy. Each environment
then has its own variable configuration, and within each application folder, we store
application-specific variables.
* I created a folder for each application because there might be multiple files related to it.
This structure ensures that by switching the Terraform workspace, we use the correct variables
for the environment while also sharing Terraform modules efficiently.

I think the approach of centralization is good and makes the management easier, it has some drawbacks and complexity too. (changes might affect others, so need to be more complex)

**Explain the networking strategy you would adopt to deploy production ready applications on AWS.**
* I would consider high availability, security, scalability, and manageability to answer this
question.
* VPC design: Use a separate VPC to isolate the production environment, implement subnet
segmentation (public and private), and deploy subnets across multiple AZs. NAT Gateway is the
standard solution for private instances to enable one-way access to the internet, while VPC
endpoints help bypass the internet for supported services.
* Choosing between ALB, NLB, or API Gateway depends on the application and overall
infrastructure, as these options are commonly used and highly effective.
* If multiple VPCs are involved, Transit Gateway simplifies VPC connectivity and management.
* Security Groups, NACLs, and WAF play crucial roles in security and reducing the attack surface,
while Route 53 remains a key component for DNS management.

**Describe how you would implement a solution to grant access to various AWS services to the deployed application.**
* The best approach is to use IAM roles and policies, ensuring least privilege access.
* Grant access based on compute type: For EC2, create an IAM role with the required policies and
attach it to the instance. For EKS, IRSA is the solution at the pod level—create an IAM OIDC
provider for EKS, define an IAM role with an assume-role policy for the Kubernetes service
account, and associate the role with a service account in a specific namespace.
* If the access is temporary, STS is preferred.
* Before deploying the application, create an IAM role for its purpose and assign it to the
application's service account. To achieve this, we determine which role is needed for each
application, create the required Terraform modules, then use the role to create the service
account and assign it to the application.

**Describe how would you automate deploying the solution across multiple environments using CI/CD.**
* For each application and environment, the TFVAR file is located at the repository level. In
CI/CD, the pipeline detects when a PR is created and selects the corresponding Test TFVAR file,
which contains all the necessary information for that application in that environment.
Then, the application is deployed.
**Discuss any trade-offs considered when designing the solution.**
*Mixing the infrastructure layer with the application layer is not a sustainable approach in the
long run.
*Using Terraform to deploy on Kubernetes is not ideal, as it lacks features available in Helm.
Additionally, managing Terraform state becomes problematic—it’s not feasible to maintain a
separate state for each application, and having a single state for all applications across
different environments is not a good practice.
**Explain how scalability, availability, security, and fault tolerance are addressed in the solution.**
* Scalability: Using HPA (Horizontal Pod Autoscaler) in Kubernetes, Helm centralization, and a
customizable Helm template can help. Providing a Docker base image is another key point, and
deploying applications with Kubernetes Deployments offers additional advantages.
* Availability & Fault Tolerance: A Pod Disruption Budget (PDB) is implemented for the
application. Pod anti-affinity is used to prevent multiple pods from running on the same node.
Probes ensure the application is live and ready, while resource requests guarantee that required
resources are always available.
* Security: A SecurityContext is used to drop unnecessary capabilities. The Dockerfile runs a non-root user with no special permissions instead of the default root user.
**Suggest any potential enhancements that could be made to improve the overall solution.**
There is room for improvement in this solution, but the question is: for what purpose do you want
to improve it? Is there a specific need or goal you want to achieve? The scale of the
application, knowledge, development team, and other factors determine how we can enhance it. I
can share valuable insights about autoscaling, service accounts, AppArmor, Vault, and more, but
these need to be discussed. 
Currently, this is not a solution—it's just an assignment to demonstrate different skill sets and
mindsets.
