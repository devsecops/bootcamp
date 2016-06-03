# Lab 2

**Table of Contents**

- [Prereq](##prereq)
- [Install](##install)
- [Create a New App](##create-a-new-app)
- [Push Code to Github](##push-code-to-github)

# Building an App the Naive Way

---
**DISCLAIMER:** This is intended to be an example of a weak/vulnerable web application built with Rails. Please do not use this in production environments

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

Run our new app.

```
$ bundle exec rails server -b 0.0.0.0
```

Go to `http://localhost:3000/` on your browser.

## Scaffolding a Basic Model
Use ctrl-c to quit rails server.

Now add scaffolding:
```
$ bundle exec rails generate scaffold Bootcamp name:string description:text dates:string
$ bundle exec rake db:migrate
```

Add a default route to `config/routes.rb`:
```
root 'bootcamps#index'
```

Run the app:
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

## Adding Search Functionality
In this section, we'll create a search functionality for our app.

In `app/controllers/bootcamps_controller.rb`, we'll add the following logic to the `index` method (a.k.a. action):
```
...
def index
  @bootcamps = Bootcamp.all
  if params[:search].to_s != ''
    @bootcamps = Bootcamp.where("name LIKE '%#{params[:search]}%'")
  else
    @bootcamps = Bootcamp.all
  end
end
...
```
Basically, if there is a `search` query parameter passed to the server from the browser, then we'll search for bootcamps where the name is like the query parameter.

In `app/views/bootcamps/index.html.erb`, we'll add the search field:
```
<h1>Search</h1>
<%= form_tag(bootcamps_path, method: "get", id: "search-form") do %>
  <%= text_field_tag :search, params[:search], placeholder: "Search Bootcamps" %>
  <%= submit_tag "Search Bootcamps"%>
<% end %>

<h1>Listing Bootcamps</h1>
...
```
That's it.

Go to [http://localhost:3000](http://localhost:3000) and try to search for bootcamps by name.

What can you do in the search field? What are the security implications of our "search" implementations?

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
