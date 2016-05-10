<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [Curriculum](#curriculum)
  - [Pre-work:](#pre-work)
  - [Prerequisites:](#prerequisites)
  - [Syllabus Outline (Rough Draft):](#syllabus-outline-rough-draft)
    - [Week 1:](#week-1)
    - [Week 2:](#week-2)
    - [Week 3:](#week3)
    - [Week 4:](#week4)
    - [Week 5:](#week5)
    - [Week 6:](#week6)
    - [Week 7:](#week7)
    - [Week 8:](#week8)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# Curriculum

## Pre-work  
- Install and configure AWS CLI
- Install and test Ruby v2.2x  

## Prerequisites  
- Basic Linux skills (Bash scripting, start/stop service, create a user, basis sysadmin)
- Basic Ruby/Rails (install Ruby, Rails, Gems, write basic Ruby scripts)
- Networking Basics (common network protocols & ports)

## Syllabus Outline (Rough Draft)  

### Week 1  
_Intro/Overview_  

### Week 2
_Dev - build an app from templates ‘the wrong way’_  
  - Deploy an existing app in AWS from the ground-up, using deployment automation (will need to prep Cfn, etc for this). Deliberately Naive to security.
  - Draft some attacks
  - Develop some Gauntlt checks
  - AWS (general)
  - Ruby
  - Rails
  - Shell Script (Bash)
  - AWS CLI
  - RailsGoat?
  - Single instance (frail), keep state on instance

### Week3:  
_Sec - attack the vulnerable app_  
  - Attack the app using drafted attacks, adapt and dev new attacks
  - Gauntlt
  - Metasploit
  - SQLMap
  - Nmap
  - Compromise the app

### Week4:  
_Ops_  
  - Learn tools to detect attacks, instrument app to detect attacks
  - Execute Incident response (contain / burn it down)
  - Keep the app alive (tension of burn-down the compromised one vs service availability)
  - Splunk / Log collection
  - VPC Flow Logs? (Stretch)
  - Application Logs
  - Instance/OS logs
  - CloudWatch
  - CloudTrail

### Week5:  
_Advanced Dev_  
  - This is the right way to deploy the app… refine from lessons learned in weeks 2-4. Get Rugged
  - AutoScale
  - Developing for Resilience
  - Minimum privileges (IAM, OS hardening, run the app as a non-priv user)
  - How to use CloudWatch to be more resilient
  - Abstract state (use RDS)
  - Stacker?? (Stretch)
  - Control-Plane pattern? (AWS has a white-paper on this, do we just change the words?)

### Week6:  
_Advanced Sec_  
  - Prove that exploitation is more difficult
  - Privilege escalation
  - Horizontal movement
  - Account Takeover (compare first version of app to updated version of app)
  - Bad patterns (VPN, network layer coupling, tight coupling, etc)

### Week7:  
_Advanced Ops_
  - Selfie
  - Splunk Alerts
  - Incident response in AWS, respond faster

### Week8:  
_Capstone Project_  
  - Hack lab – build an infrastructure from a template, make it better on the fly, keep it alive while others attack it and while attacking others (Capture the Flag).
