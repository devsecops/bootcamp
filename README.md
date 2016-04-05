# DevSecOps Bootcamp

## Curriculum

### Pre-work:
- Install and configure AWS CLI
- Install and test Ruby v2.2x
### Prerequisites:
- Basic Linux skills (Bash scripting, start/sop service, create a user, basis sysadmin)
- Basic Ruby/Rails (install Ruby, Rails, Gems, write basic Ruby scripts)
- Networking Basics (common network protocols & ports)

### Draft syllabus outline:
- **Week1:** Intro/Overview
- **Week2:** Dev - build an app from templates ‘the wrong way’, dev some gauntlt checks
  - Deploy an existing app in AWS from the ground-up, using deployment automation (will need to prep Cfn, etc for this). Deliberately Naive to security.
  - Draft some attacks
  - AWS (general)
  - Ruby
  - Rails
  - Shell Script (Bash)
  - AWS CLI
  - RailsGoat?
  - Single instance (frail), keep state on instance
- **Week3:** Sec - attack the vulnerable thing with gauntlt
  - Attack the app using drafted attacks, adapt and dev new attacks
  - Gauntlt
  - Metasploit?
  - SQLMap
  - Nmap
  - Compromise the app
- **Week4:** Ops -
  - Learn tools to detect attacks, instrument app to detect attacks
  - Execute Incident response (contain / burn it down)
  - Keep the app alive (tension of burn-down the compromised one vs service availability)
  - Splunk / Log collection
  - VPC Flow Logs? (Stretch)
  - Application Logs
  - Instance/OS logs
  - CloudWatch
  - CloudTrail
- **Week5:** Dev2
  - This is the right way to deploy the app… refine from lessons learned in weeks 2-4. Get Rugged
  - AutoScale
  - Developing for Resilience
  - Minimum privileges (IAM, OS hardening, run the app as a non-priv user)
  - How to use CloudWatch to be more resilient
  - Abstract state (use RDS)
  - Stacker?? (Stretch)
  - Control-Plane pattern? (AWS has a white-paper on this, do we just change the words?)
- **Week6:** Sec2
  - Prove that exploitation is more difficult
  - Privilege escalation
  - Horizontal movement
  - Account Takeover (compare first version of app to updated version of app)
  - Bad patterns (VPN, network layer coupling, tight coupling, etc)
- **Week7:** Ops2
  - Selfie??
  - Splunk Alerts
  - Incident response in AWS, respond faster
- **Week8:** Capstone
  - Hack lab – build an infrastructure from a template, make it better on the fly, keep it alive while others attack it and while attacking others (Capture the Flag).
