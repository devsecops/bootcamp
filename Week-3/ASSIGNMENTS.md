# WEEK 3 ASSIGNMENTS 

## Assignment #1: Automate Role Assumption

- Using your favorite programming/scripting language, automate assuming role into the target account and opening the AWS Console UI.

- Use the [assumer](https://github.com/devsecops/assumer) gem to automate assuming a role into the target account: 
 - Example: `assumer -a 717986480831 -r human/dso/TGT-dso-DeploymentAdmin -A 100352119871 -R dso/ctrl/my-app/CTL-my-app-DeploymentAdmin -p dso -g -u $AWS_USERNAME`
