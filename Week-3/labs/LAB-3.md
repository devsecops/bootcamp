# Lab 3

**Table of Contents**

- [Run the Goat](##run-rails-goat)
- [Install Burp](##install-burp)
- [Exercise 1](##exercise-1)
- [Exercise 2](##exercise-2)

# Attack a Vulnerable App

On this lab we will attack Rails Goat (our vulnerable app).

---

## Run Rails Goat

1. Log into your AWS instance and run Rails Goat. This should be a continuation from the previous lab.

 ```
$ vagrant ssh
$ export RAILS_ENV=mysql
$ bundle exec rails server -b 0.0.0.0 -p 8080
 ```

2. Load `http://PUBLIC_IP_ADDRESS:8080` on your browser.

## Install Burp

We use Burp Proxy to intercept our browser's requests before they are sent to the Web application. This gives us the chance to modify the HTTP request before it is submitted.

1. Download and run Burp Proxy (Free Edition).

  ```
  https://portswigger.net/burp/download.html
  ```

2. Select `Temporary project` and click `Next`. Select `Use Burp defaults` and click `Start Burp`.

3. Setup your browser to use the burp proxy.

 E.g., on Firefox, `Preferences > Advanced > Network > Settings`. Select `Manual proxy configuration` and put `localhost` and `8080` for `HTTP Proxy` and `Port`.

4. Now reload your browser and take a look at `Burp > Proxy > Intercept`. Here you can modify requests before they are submitted by the browser. Click `Forward`.

## Exercise 1

Do exercise A1: [SQL Injection Concatentation](https://github.com/OWASP/railsgoat/wiki/A1-SQL-Injection-Concatentation)

## Exercise 2

Do exercise A1: [Command Injection](https://github.com/OWASP/railsgoat/wiki/A1-Command-Injection)

## Challenge

Do 7 of the 14 exercises at [https://github.com/OWASP/railsgoat/wiki](https://github.com/OWASP/railsgoat/wiki)
