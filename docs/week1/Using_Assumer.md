# Introduction to Assumer

## What is this "Assumer"?
> The Assumer gem is an interface allowing the user to assume role into an account. Credentials can be loaded anywhere the AWS STS Client knows to load credentials from (ENV, profile, etc.)

## Why use this Assumer?
Assumer helps us to do a "double hop" and get TO the target account which we want to work on, FROM the control account.

The control account contains no / minimal compute resources, its main job is used to manage ROLES.
The target account has all the compute resources (ec2, RDS, etc), you set up your servers in this account.

Using this pattern, we are able to control up to N number of accounts and only have to manage only 1 control account for roles in a very granular way. For example, my software team can have 3 target accounts (1 for production, 1 for pre-production, 1 for testing) and 1 control account that manages which developer gets permission to which account(s).

## I assume now we Assume?

1. Check if your machine has Ruby 2.2.2 installed already or follow the procedure to week1's instruction to install Ruby:
```
ruby --version
```

2. To install [Assumer](https://github.com/devsecops/assumer), follow instructions on https://github.com/devsecops/assumer#build-from-source

3. To use Assumer, check out https://github.com/devsecops/assumer#usage
Example usage:
```
# Use Assumer to get AWS console GUI in your browser:
assumer --target-account 123456789012 --target-role target_role/deployment_admin --control-account 987654321098 --control-role control_role/deployment_admin -g
# Use assumer to get a pry session in Ruby in your shell:
assumer --target-account 123456789012 --target-role target_role/deployment_admin --control-account 987654321098 --control-role control_role/deployment_admin -p
>
```

  **NOTE:** To be able to use this utility you will need to have permission to assume-role against the role you specify!

  i.e. Account number 123456789012 has the role target_role/deployment_admin, Account number 987654321098 has the role control_role/deployment_admin AND YOU need to have permission to login and assumer onto both.

---
## References:
Assumer: https://github.com/devsecops/assumer
