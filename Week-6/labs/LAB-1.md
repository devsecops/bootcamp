# Lab 1

**Table of Contents**

- [Setting up Rails Goat](##Setting-up-Rails-Goat)
- [Open Redirects](##Open-Redirects)
- [XSS Attack](##XSS-Attack)


# Web Application Vulnerabilities
In this lab we will be exploiting a couple of vulnerabilities that by themselves would be scored as low/medium on a vulnerability scanner.


*Resources:*

- [https://www.owasp.org/index.php/Unvalidated_Redirects_and_Forwards_Cheat_Sheet](https://www.owasp.org/index.php/Unvalidated_Redirects_and_Forwards_Cheat_Sheet)
- [https://www.owasp.org/index.php/Cross-site_Scripting_(XSS)](https://www.owasp.org/index.php/Cross-site_Scripting_(XSS))
- [https://github.com/OWASP/railsgoat/wiki/A10-Unvalidated-Redirects-and-Forwards-(redirect_to)](https://github.com/OWASP/railsgoat/wiki/A10-Unvalidated-Redirects-and-Forwards-(redirect_to))
- [https://github.com/OWASP/railsgoat/wiki/A3-Cross-Site-Scripting](https://github.com/OWASP/railsgoat/wiki/A3-Cross-Site-Scripting)
- [https://github.com/OWASP/railsgoat/wiki/A3-Cross-Site-Scripting-DOM-Based](https://github.com/OWASP/railsgoat/wiki/A3-Cross-Site-Scripting-DOM-Based))


---

## Setting up Rails Goat

First thing you'll have to do is launch your Rails Goat web application.  Use Restacker to do this with the following command you learned from last weeks Lab 3:

```
$ restacker deploy -t mytemplate.json -P parameters.json -c dso -l myapp -n $AWS_STUDENT_ID -u $AWS_STUDENT_ID
```


## Open Redirects

Ensure you are logged out of the application. When requesting the login page, ensure you append a url=. Then, authenticate to the application. Once authenticated, you should be redirected to your test url.


## XSS Attack

1. When registering, enter your JavaScript tag such as in the First Name field. Upon login the header navigation bar will echo "Welcome" + your JS code.

Example of XSS JavaScript test code:
```
<script>alert(1)</script>
```

2. Ensure you are signed out of the application first. Make sure you are using something like Firefox as Safari/Chrome won't work for this exercise. Then, use the following link (substitute hostname for your actual hostname) to execute an alert box:

```
http://127.0.0.1/?url=%2Fdashboard%2Fhome#test=%3Cscript%3Ealert(document.cookie)%3C/script%3E
```
