<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [Curriculum](#curriculum)
  - [Pre-work:](#pre-work)
  - [Prerequisites:](#prerequisites)
  - [Syllabus Outline (Rough Draft):](#syllabus-outline-rough-draft)
    - [Week 1](#week-1)
    - [Week 2](#week-2)
    - [Week3:](#week3)
    - [Week4:](#week4)
    - [Week5:](#week5)
    - [Week6:](#week6)
    - [Week7:](#week7)
    - [Week8:](#week8)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# Curriculum

## Pre-work  
- Install and configure AWS CLI
- Install and test Ruby v2.2x  

## Prerequisites  
- Basic Linux skills (Bash scripting, start/sop service, create a user, basis sysadmin)
- Basic Ruby/Rails (install Ruby, Rails, Gems, write basic Ruby scripts)
- Networking Basics (common network protocols & ports)

## Syllabus Outline (Rough Draft)  

### Week 1:
_Intro/Overview_  
  - Introduce yourself
  - Introduce DevSecOps
  - Set up your workstation

### Week 2:
_Dev - build an app_  
  - Ruby
  - Rails API
  - Shell Script (Bash)
  - AWS CLI
  - AWS SDK
  - Deploy on a single instance. Keep the state of the app on one instance.

### Week 3:  
_Sec - attack the vulnerable app_  
  - Deploy vulnerable app to AWS.
  - Attack the app using different techniques (e.g. OWASP Top 10)
  - Tools of the trade:
    - Nmap
    - Metasploit
    - SQLMap

### Week 4:  
_Ops - Detection & Alerting_  
  - Learn tools to detect attacks, instrument app to detect attacks
  - Execute Incident response (contain / burn it down)
  - Keep the app alive (tension of burn-down the compromised one vs service availability)
  - Splunk / Log collection
  - Application Logs
  - Instance/OS logs
  - CloudWatch
  - CloudTrail

### Week 5:  
_Rugged Dev_  
  - Developing for Resilience.
  - Service Oriented Architecture (SOA).
  - Stacker
  - Gauntlt
  - AutoScale
  - Minimum privileges (IAM, OS hardening, run the app as a non-priv user)
  - How to use CloudWatch to be more resilient
  - Abstract state (use RDS)
  - Control-Plane pattern

### Week 6:  
_Rugged Sec_  
  - Privilege escalation
  - Horizontal movement
  - Account Takeover
  - Bad patterns (VPN, network layer coupling, tight coupling, etc)

### Week 7:  
_Rugged Ops_
  - Selfie
  - Splunk Alerts
  - Incident response in AWS, respond faster

### Week 8:  
_Capstone Project_  
  - Hack lab – build an infrastructure from a template, make it better on the fly, keep it alive while others attack it and while attacking others (Capture the Flag).

### Week 9:
_Final Presentation_
  - Demos
