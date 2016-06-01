# Lab 2

**Table of Contents**

- [Prereq](##prereq)
- [Install](##install)
- [Create a New App](##create-a-new-app)
- [Push Code to Github](##push-code-to-github)

# Building an App from the Ground Up

---
## Prereq


```
$ vagrant ssh
```

## Install

Install and run a local database.

```$ sudo yum -y install mariadb mariadb-server mariadb-devel
$ sudo systemctl start mariadb.service
```

Install dependencies.

```
$ sudo yum -y install links
$ sudo yum -y install nodejs
```

Install Rails.

```
$ gem install rails
```

## Create a New App

```
$ rails new --skip-turbolinks --skip-spring \
            --skip-test-unit -d mysql \
            myapp
```

Create the database and schema.

```
$ cd myapp
$ bundle exec rake db:create
$ bundle exec rake db:migrate
```

Run our new app. Note: setup port forwarding first.

```
$ bundle exec rails server -b 0.0.0.0
```

Got to `http://localhost:3000/` on your browser.

Use ctrl-c to quit rails. Now add scaffolding. 

```
$ bundle exec rails generate scaffold Bootcamp name:string description:text dates:string
$ bundle exec rake db:migrate
```

Add a default route to `config/routes.rb`

```
root 'bootcamp#index'
```

Run the app.

```
$ bundle exec rails server -b 0.0.0.0
```

Got to `http://localhost:3000/` on your browser.

Now edit `app/views/bootcamps/show.html.erb` and make the description field a `raw` field. It should look like so:

```
...
<p>
  <strong>Description:</strong>
  <%=raw @bootcamp.description %>
</p>
...
```

Now run the app, and create a new bootcamp entry. What can you do in the description field? What are the security implications of using the `raw` method.



## Push Code to Github

Greate a new project in your githuhb account and push the code, e.g.,:

```
echo "# myapp" >> README.md
git init
git add README.md
git commit -m "first commit"
git remote add origin https://github.com/YOUR_USERNAME/myapp.git
git push -u origin master
```


Now create a tag and publish a release.