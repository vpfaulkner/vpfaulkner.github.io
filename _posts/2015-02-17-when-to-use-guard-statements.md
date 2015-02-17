---
layout: post
title: When to use Guard Statements
comments: true
---

What are guard statements and when should I use them? If you are starting out on Ruby you might run into a line like the one below and be a little confused:

{% highlight ruby %}
return unless user
{% endhighlight %}

It reads well enough to get an sense of what is going on but you might be more comfortable with a nested if else statement:

{% highlight ruby %}
if user
  # ...
else
  return nil
end
{% endhighlight %}

While they do the same thing, the guard statement is 1) it avoids a level of indentation 2) it is more readable 3) it is more concise. It takes advantage of the trailing conditional if as well as the implicit return nil (same as return unless).

There are a few liabilities with the techniques however. The first is that you may be suppressing and thus perpetuating a critical bug in your code by not allowing a NoMethodError to be raised. An alternative is in fact to raise an exception of your own? Secondly, you are forcing whatever object called this method to [respond to two different](http://www.sandimetz.com/blog/2014/12/19/suspicions-of-nil) types of object.

Overall, I prefer using guard statements when I need to prevent accepting invalid data and only if I have determined the exact circumstance of the bug. If you are having a mysterious bug pop up for some unknown reason, spend your time investigating and remedying that bug rather than smothering it with a line like this.
