 
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
