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

First, let's generate a `users` table using the Rails `scaffold` generator:
```
rails generate scaffold User first_name:string last_name:string title:string
```

Any time we create new tables, we need to run migrations:
```
rake db:migrate
```

Start the rails server:
```
rails s -b 0.0.0.0
```

Go to http://localhost:3000/users and try adding a couple of users

Now, let's actually implement the Search feature.

In `app/controllers/users_controller.rb`, we'll add the following logic to the `index` method (aka action):
```
...
def index
  @users = User.all
  if params[:search].to_s != ''
    @users = User.where("first_name LIKE '#{params[:search]}'")
  else
    @users = User.all
  end
end
...
```
Basically, if there is a `search` query parameter passed to the server from the browser, then we'll search for users where the user first name is like the query parameter.

In `app/views/users/index.html.erb`, we'll add the search field:
```
<h1>Search</h1>
<%= form_tag(users_path, method: "get", id: "search-form") do %>
  <%= text_field_tag :search, params[:search], placeholder: "Search Users" %>
  <%= submit_tag %>
<% end %>

<h1>Listing Users</h1>
...
```
That's it.

Go to http://localhost:3000/users and try to search for users by first name.

What can you do in the search field? What are the security implications of our "search" code?

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
