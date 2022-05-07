## Architecting on AWS - Capstone Project

### Build an AWS multi-tier architecture

***

## The Story
Example Corp. creates marketing campaigns for small-to medium-sized businesses. To date, Example Corp hosts their clients using an on-premises data center. Recently, they decided to move their operations to the cloud to save money and transform their business with a cloud-first approach. Some members of their team have cloud experience and recommended the AWS cloud services to build their solution. Example Corp. hired you to work with the engineering teams to build out a proof of concept for their business.

Example Corp decided to redesign their web portal. Customers use the portal to access their accounts, create marketing plans, and run data analysis on their marketing campaigns. They would like to have a working prototype in two weeks. 

### Objectives
* Design an architecture to support this application
* Your solution must be fast, durable, scalable, and more cost-effective than their existing on-premises infrastructure

### Task 1

builds VPC, supporting resources, a basic networking structure, and some Security groups for use in later tasks.



**EFS**
Amazon EFS is designed to provide performance for a broad spectrum of workloads and applications. This includes big data and analytics, media processing workflows, content management, web serving, and home directories. 
Amazon EFS Standard storage classes are ideal for workloads that require the highest levels of durability and availability.
Amazon EFS One Zone storage classes are ideal for workloads such as development, build, and staging environments, as well as applications such as analytics, simulation, and media transcoding. It is also good for backups or replicas of on-premises data which do not require multi-AZ resilience.



**Listener**
A listener checks for connection requests from clients, using the protocol and port that you configure. The rules that you define for a listener determine how the load balancer routes requests to its registered targets. Each rule consists of a priority, one or more actions, and one or more conditions. When the conditions for a rule are met, then its actions are performed. You must define a default rule for each listener, and you can optionally define additional rules.
https://docs.aws.amazon.com/elasticloadbalancing/latest/application/introduction.html


**EC2 auto scaling group**
Better fault tolerance. Amazon EC2 Auto Scaling can detect when an instance is unhealthy, terminate it, and launch an instance to replace it. You can also configure Amazon EC2 Auto Scaling to use multiple Availability Zones. If one Availability Zone becomes unavailable, Amazon EC2 Auto Scaling can launch instances in another one to compensate.
Better availability. Amazon EC2 Auto Scaling helps ensure that your application always has the right amount of capacity to handle the current traffic demand.
Better cost management. Amazon EC2 Auto Scaling can dynamically increase and decrease capacity as needed. Because you pay for the EC2 instances you use, you save money by launching instances when they are needed and terminating them when they aren't.



