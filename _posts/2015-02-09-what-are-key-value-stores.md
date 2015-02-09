---
layout: post
title: What are Key Value Stores?
comments: true
---
Perhaps you've heard about "key value stores" or even one of the more popular forms of key value stores such as Redis, but are still a little unsure of what they are and their place.

To begin, let's start with simply key value pairs:

{% highlight ruby %}
Name         George
Hair         White
Occupation   President
{% endhighlight %}

You get the picture: data is stored as part of a key (Name) and a value (George). You're probably familiar with this concept but as a way to store data temporarily in memory, such as a hash in Ruby. However, when it comes to persisting data you think of storing it as part of a relational database with structured data, similar to how you would imagine it appearing on an Excel spreadsheet. 

We won't get into the full topic here but the reality is that persisting data in a database doesn't have to look this way. There is another type of database called NoSQL that is preferred for data with inconsistent structure or data that can be very large. NoSQL DBs can come in variety of flavors and be useful for a variety of reasons but the type we are interested in here, key value stores, tend to lend themselves to situations in which accommodating speed and scalability is more important than accommodating complexity.

The most popular key value store is Redis and some advantages that it provides is storing the data in-memory and allows for data types beyond just strings. Use Redis when you are dealing with frequently updated data that you want to retrieve quickly and don't need to a more complex document-based NoSQL or SQL database. Think caching, queues, online shopping carts, etc. Moreover, many popular tools such as [Sidekiq](/2015/02/04/sidekiq-in-rails/) use Redis so you are bound to run into it at one point.





