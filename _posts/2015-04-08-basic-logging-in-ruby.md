---
layout: post
title: Basic Logging in Ruby
---

Logging is an important topic but gets perhaps less discussion than it should. If you haven't already incorporated a logging strategy into your app, do so soon. If you haven't found a logging tool or Gem to use, start simple with the built in Ruby logger.

A basic log to standard output:

{% highlight ruby %}
require 'logger'

logger = Logger.new(STDOUT)

logger.info("Processing job #{job.id}")
{% endhighlight %}

Seems simple enough. As you can see this log is at the info log level. You will need to ensure there is a consistent approach among your team towards how you will all handle log levels but some general rules of thumb for the various levels are as follows:

* Debug - This is the lowest level and is oftentimes not even turned on in production which means these log lines will not be run. Use for normal and insignificant occurrences in your application. If I want to simply expose a variable in a log I would use this.

* Info - These should still be "normal" occurrences in your application but more significant ones. Perhaps an hourly cron-job ran that you want to take note of.

* Warn - This is for when something is unexpected occurs such as an exception but that your program is able to handle and continue on. Perhaps if you were expecting a configuration to be set but it wasn't and now you are resorting to a default.

* Error - Something went wrong and halted execution of your program. You aren't able to write something to your database for example.

There are a few others that sometimes get used (trace or fatal for example) but these are the main levels you should consider.

Once you clarify your team's approach to log levels you will need to decide at what level to log at different environments, most importantly production. Think of this as a volume control for your logs: only logs of that level or higher will actually be written. So, for example, if you set your log level to Info, Debug logs would not be written but logs at Info or above would be. Setting your log level at Info or Warn in production is a good place to start although you should revisit this decision over time.

To set a level using the default logger:

{% highlight ruby %}
logger.level = Logger::WARN
{% endhighlight %}

If you want to specify a logfile:

{% highlight ruby %}
logger = Logger.new('my_logfile.log')
{% endhighlight %}

If you want to age a logfile so that a new logfile is created after a certain point you can do so according to time limit (daily) or byte size (1000000):

{% highlight ruby %}
logger = Logger.new('my_logfile.log', 'daily')
logger = Logger.new('my_logfile.log', 5, 1000000)
{% endhighlight %}

The second example will leave only 5 logfiles, moving on to the next file once that byte limit is reached.

Effective logging should include a good context and a good technology stack to aggregate and present the logs for searching. I would recommend an [ELK stack](https://www.elastic.co/webinars/elk-stack-devops-environment/) although this might be overkill if you are just starting out.

