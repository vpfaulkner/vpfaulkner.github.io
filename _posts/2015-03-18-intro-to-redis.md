---
layout: post
title: Intro to Redis
---

Over the last few months there has been no tool I've used more than Redis. Although much of this is due to how much we've also used [Sidekiq for background jobs](/2015/02/04/sidekiq-in-rails/) and Sidekiq uses Redis for a job queue essentially, we have also used Redis alone when we needed any kind of key-value store including times when we wanted to cache.

Perhaps the best feature it brings to the table is its ability to handle different types of data structures in addition to strings:

* Strings
* Hashes
* Lists of strings
* Sets of strings (non-repeating, unsorted elements)
* Sorted sets of strings

A more in-depth look at the Redis data types is [here](http://redis.io/topics/data-types-intro), and if you are unfamiliar with key value stores, check out this [other post](2015/02/09/what-are-key-value-stores/). To get started, first make sure it is installed:

{% highlight sh %}
brew install redis
{% endhighlight %}

You'll need to ensure the redis server is running and can use the command line interface, although we will look at the Ruby Client for Redis.

{% highlight sh %}
redis-server
{% endhighlight %}

{% highlight sh %}
redis-cli
redis> set mykey myvalue
OK
redis> get key
"value"
{% endhighlight %}

If you would like to use the Ruby client, require and instantiate it with default configuration and listening on localhost:

{% highlight ruby %}
require "redis"

redis = Redis.new
{% endhighlight %}

If you want to use a specific URL, you can either pass that in when instantiating Redis or set it as an environment variable called REDIS_URL.

Remember to think of key value stores similar to that of a dictionary where you want to save something, a value, and identify that value with a key later, similar to how a word and its meaning are stored together in a dictionary.

{% highlight ruby %}
redis.set("mykey", "myvalue")
redis.get("mykey")
# "myvalue"
{% endhighlight %}

The methods available to your instance of Redis are the same as those listed on the [website](http://redis.io/commands).

Consider Redis when you need something much faster and more lightweight than a full on database. Again, this is why it makes a good candidate for caching (in my opinion better than Memcached). However, it can also be used as a message queue between services although apparently the maker of Redis is looking into creating a [separate tool](http://antirez.com/news/88) to do just that.

