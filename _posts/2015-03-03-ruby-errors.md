---
layout: post
title: Ruby Errors
---
Rescue clauses should not be used recklessly in your code because they might make important bugs in your code hard to find. But in certain situations, particularly when your code deals with an external service that you can't control, they become critical.

In it's simplest and most common form you can simply insert a rescue that rescues StandardError (don't ever rescue from Exception as it can prevent much more important errors from coming to your attention!). See below:

{% highlight ruby %}
def post
  begin
    puts "About to send"
    # HTTP Post logic
  rescue => e
    puts "rescued from #{e.inspect}"
    # Other rescue logic
  end
end
{% endhighlight %}

Here we have several things going on: a begin which marks the block you wish to rescue from (and the block which you might want to retry, see below), then the http post logic, and then logic to be executed upon rescue with e now holding the error information. I choose http post logic as an example because it is the very scenario that I see as commonly requiring rescue. For example, if the server receiving your post goes down or times out, you don't want your program to crash. Instead, you should decide on how you want to handle these errors in advance and add that logic here.

If you want to retry the post you can do so:

{% highlight ruby %}
def post
  begin
    puts "About to send"
    # HTTP Post logic
  rescue => e
    puts "rescued from #{e.inspect}"
    retry_count ? retry_count += 1 : retry_count = 0
    retry if retry_count < 3
  end
end
{% endhighlight %}

Here retry will go to the begin statement and retry the post. To prevent infinite retries, however, we are using a retry_count variable.

You can also include else logic when the rescue clause is not executed and/or ensure logic that will be executed no matter what:

{% highlight ruby %}
def post
  begin
    puts "About to send"
    # HTTP Post logic
  rescue => e
    puts "rescued from #{e.inspect}"
    retry_count ? retry_count += 1 : retry_count = 0
    retry if retry_count < 3
  else
    puts "success!"
  ensure
    # Ensure something is logged
  end
end
{% endhighlight %}

Finally, it is OK to raise your own errors, particularly if a dependency is acting improperly:

{% highlight ruby %}
def post
  begin
    puts "About to send"
    # response = HTTP Post logic
    raise BadResponseError unless response == 201
  rescue BadResponseError
    # Log bad response
  rescue => e
    puts "rescued from #{e.inspect}"
    retry_count ? retry_count += 1 : retry_count = 0
    retry if retry_count < 3
  else
    puts "success!"
  ensure
    # Ensure something is logged
  end
end
{% endhighlight %}

Here we are treating undesired responses as an error and rescuing that specific error before a general rescue. Note that if you want to handle certain errors differently than others you should rescue them first.
