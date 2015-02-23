---
layout: post
title: Wrap Your Dependencies
comments: true
---
Properly wrapping and encapsulating parts of my code has come to feel like a kind of digital hygiene for my code not unlike regularly washing my hands to prevent sickness. You don't know when you might be about to get sick so you just build some habits into to protect yourself against this outcome. In software, your mindset should be analogous but with a focus on your software's potential to accommodate change.

At work we were dealing with the question of how we want to handle logging. We were told that our current tool for logging was Graylog but that we were considering moving to an [ELK stack](http://www.elasticsearch.org/overview/). Obviously we didn't want to go to far down one road only to then turn around and go another direction. So we committed to doing what we should have been doing regardless: wrapping our logging logic. For example:

{% highlight ruby %}
Class ShoppingCart

  def purchase
    # purchase logic
    Log.new(:info, "Sucessfull purchase: #{self.id}")
  end

end

Class Log

  def initialize(level, message)
    # Log logic
  end

end
{% endhighlight %}

Even if we decided to go with the default Ruby logger, by wrapping the logging logic in its own class we prepare ourselves for change. The result is cleaner, more adaptable code.
