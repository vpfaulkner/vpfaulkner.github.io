---
layout: post
title: Intro to PostgreSQL
comments: true
---
If you are just getting started with Rails you might not realize it but the database you are using is [SQLite](https://www.sqlite.org/). SQLite. SQLite is perhaps the most widely-deployed database out there and will work well for many application needs. However, it does have some limitations with speed, particularly write operations, and not as full featured as other relational databases such as MySQL and PostgreSQL. 

PostgreSQL is worth a deeper look because of how popular it is with rails developers today. Without getting too much in the details, Postgres really lends itself to object-oriented, relational database interactions and is very efficient. It does well with concurrency without read locks and has a strong community if you have any questions or issues.

To begin, make sure you have it installed on your computer:

{% highlight sh %}
brew install postgresql
{% endhighlight %}

I usually go with PostreSQL over SQLite from the beginning of any Rails project just because it is easier than migrating later:

{% highlight sh %}
rails new myapp -d postgresql
{% endhighlight %}

You can confirm everything by looking at the newly created database.yml file:

{% highlight sh %}
development:
  adapter: postgresql
  encoding: unicode
  database: myapp_development
  pool: 5
  username: myapp
  password:
{% endhighlight %}

When needing to persist data there are a variety of different options from full featured DBs such as PostsgreSQL even to simple [key-value stores](/2015/02/09/what-are-key-value-stores/) and sometimes just picking one and experimenting is the best path forward. Nevertheless, knowing a little bit more on what is going on under the hood of your current database and what other options you have out there is always worth the research.
