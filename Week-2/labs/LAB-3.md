# Lab 3

**Table of Contents**

- [Install Rails Goat](##install-rails-goat)
- [Run the Goat](##run-the-goat)
- [Exercise 1](##exercise-1)
- [Install Burp](##install-burp)
- [Exercise 2](##exercise-2)

# Run a Weak App

---

## Install Rails Goat


Install dependencies.

```
$ yum -y install sqlite-devel
```

Clone Rails Goat.

```
$ cd ~
$ git clone https://github.com/OWASP/railsgoat.git
```

Setup the Goat.

```
$ export RAILS_ENV=mysql 
$ cd railsgoat
$ bundle install
$ bundle exec rake db:create
$ bundle exec rake db:migrate
```

## Run the Goat

Run the app.

```
bundle exec rails server -b 0.0.0.0
```

Load `http://VM_IP_ADDRESS:3000` on your browser. You may need to run `ifconfig` to find out your VM's IP address.


## Exercise 1

Do exercice A1: [SQL Injection Concatentation](https://github.com/OWASP/railsgoat/wiki/A1-SQL-Injection-Concatentation)

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

## Exercise 2

Do exercise A1: [Command Injection](https://github.com/OWASP/railsgoat/wiki/A1-Command-Injection)
