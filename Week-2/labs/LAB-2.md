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

Install and run a local database:

```
$ sudo yum -y install mariadb mariadb-server mariadb-devel
$ sudo systemctl start mariadb.service
```

Install dependencies:

```
$ sudo yum -y install links
$ sudo yum -y install nodejs
```

Install Rails:

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

Go to `http://localhost:3000/` on your browser.

Use ctrl-c to quit rails. Now add scaffolding. 

```
$ bundle exec rails generate scaffold Bootcamp name:string description:text dates:string
$ bundle exec rake db:migrate
```

Add a default route to `config/routes.rb`

```
root 'bootcamps#index'
```

Run the app.

```
$ bundle exec rails server -b 0.0.0.0
```

Go to `http://localhost:3000/` on your browser.

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

## Add Your Own Functionality

Do one of the following:

1. Capability to upload and display an image when creating/showing a bootcamp entry
2. Integrate Devise to authenticate users
3. Implement access controls for the bootcamp model

**Challenge:** do all 3.

**Resources:**

* Rails Form Helpers: [http://guides.rubyonrails.org/form_helpers.html](http://guides.rubyonrails.org/form_helpers.html)
* Devise: [https://github.com/plataformatec/devise](https://github.com/plataformatec/devise)
* Devise Wiki: [https://github.com/plataformatec/devise/wiki](https://github.com/plataformatec/devise/wiki)
* MyApp: [https://github.com/godinezj/myapp](https://github.com/godinezj/myapp)

## Push Code to Github

Create a new project in your githuhb account and push the code, e.g.,:

```
echo "# myapp" >> README.md
git init
git add README.md
git commit -m "first commit"
git remote add origin https://github.com/YOUR_USERNAME/myapp.git
git push -u origin master
```


Now create a tag and publish a release.
