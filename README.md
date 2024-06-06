 
## VPC_WAY_1
- Create VPC using the shortest code (Reduced code). This uses some terraform function that reduces the code compared to the PC_WAY_2. 

## VPC_WAY_2
- Create VPC using the long way we call all the blocks of code or all other things manually instead of using the terraform function. 

## EC2
- Create one EC2

## EC2_Module_UserData
- This follows the proper terraform folder structure and installed Apache inside ec2 after its lunch.

## IAMPolicy
- Creates one IAM role and attaches one s3 full access policy to that created role. Create one EC2 and assign this created role to this EC2.

## LB 
- Create one LB with TG and EC2. EC2 also installs Apache which is accessible through the LB endpoint.

## LB_With_VPC
- This is a full stack of creating LB. This is created by VPC. Create one EC2, LB, and TG inside this VPC.

## ASG
- Create one Autoscaling group. We created on EC2 and created AMI of that EC2. use this AMI to create an autoscaling group with LB, TG.

## EKS
- EKS craetion with all addon and NG.

## Karpenter
- Deploye karpenter in EKS for autoscaling.
- After karpenter is deployed All the CRDS like (nodepool, ec2nodeclass) is installed manlly and test that cluster is autoscaled or not!

## Grafana
- This is install Grafana using helm chart and expose it using nodeport service so we can access using <ip>:<nodeport>.
- This is only install grafana not any other things!!

## Monitoring
- Deployed grafana and promethues using one single helm chart name is "kube-prometheus-stack".
- Grafana and promethius is both expose as nodeport service.
- To modify values we first install "kube-prometheus-stack" locally to see values and after we can add values into our value file.
- How to install helm chart localy is describe in the our terraform docs!
- We also create storage class and claim it using PVC for grafana POD so if our Grafana pod is re-created then also data is remian same.


