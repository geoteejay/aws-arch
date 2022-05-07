aws cloudformation create-stack --stack-name waopslab-automation-role \
                                --capabilities CAPABILITY_NAMED_IAM \
                                --template-body file://automation_role.yml 






aws cloudformation create-stack --stack-name waopslab-playbook-investigate-application \
                                --parameters ParameterKey=PlaybookIAMRole,ParameterValue=<ARN of **playbook** IAM role (defined in previous step)> \
                                --template-body file://playbook_investigate_application.yml 







aws cloudformation create-stack --stack-name waopslab-runbook-approval-gate \
                                --parameters ParameterKey=PlaybookIAMRole,ParameterValue=AutomationRoleArn \
                                --template-body file://runbook_approval_gate.yml 




aws cloudformation create-stack --stack-name waopslab-runbook-scale-ecs-service \
                                --parameters ParameterKey=PlaybookIAMRole,ParameterValue=AutomationRoleArn \
                                --template-body file://runbook_scale_ecs_service.yml 
