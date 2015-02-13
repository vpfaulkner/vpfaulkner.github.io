---
layout: post
title: What is Active Record?
comments: true
---
If you're getting into Rails perhaps the most important concept to learn besides the MVC pattern is the role that Active Record plays.

For starters, it might be worth clarifying that active record can refer to both the general software architecture pattern first coined by Martin Fowler as well as the specific Rails implementation of that pattern. What that pattern hopes to do is essentially abstract the database allowing you as the software developer to interact with application objects (think User.last) rather than the database itself. This is done through Object-Relational Mapping and will make your life as a new Rails developer significantly easier. In addition to making your Rails app nearly database agnostic and allowing you to not build tedious database queries yourself, active record gives you the ability to:

* Represent models and their data
* Represent associations between these models
* Validate models before they get persisted to the database
* Perform database operations in an object-oriented fashion.

(taken from the official Rails guide, see below)

Let's start with some examples.

Using a SQL database without active record, if you wanted to grab the first user in your User table you would have to build the query below:

{% highlight SQL %}
SELECT * FROM clients ORDER BY users.id ASC LIMIT 1
{% endhighlight %}

Not only do you have to know the right query syntax but you are suddenly very coupled to your database because its specific logic is sprinkled throughout your program. Furthermore, reading even a simple query such as this one is difficult and make it harder to communicate what you are doing in your program.

The same query using active record would look like this:

{% highlight ruby %}
user = User.first
{% endhighlight %}

Much cleaner right? Not only are you as a beginner able to make relatively complex database queries without learning another language, but I also find that the active record pattern helps you write better object-oriented code. Some other examples:

{% highlight ruby %}
# Find user with last name as 'Faulkner'
User.where(last_name: 'Faulkner')

# Find user with last name as 'Faulkner' and first name as 'Vance'
User.where(last_name: 'Faulkner', first_name: 'Vance')

# Find non-member users and loop through block
User.where(member: false).find_each { |t| ... }

# Retrieve member users by created_at date
User.where(member: true).order(:created_at)
{% endhighlight %}

There are a multitude of ways to query active record which you can find with the [Rails guide](http://guides.rubyonrails.org/active_record_querying.html). Becoming comfortable with active record is essential as well as relatively easy and will set you up for becoming a productive rails developer. 


