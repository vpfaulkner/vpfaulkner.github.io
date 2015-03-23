---
layout: post
title: The Inject Method in Ruby
---

Sometimes you need to do a lot of work on an array and think to yourself, "Is there anyway I could get this done with a single method?" For example, if you are trying to find the longest word in a collection or are trying to downcase the values in an array. Chances are, this is a moment when you should look at inject.

The enumerable mixin provides some especially useful methods to collection classes (arrays, hashes, sets, etc) in Ruby that can take handle these cases easily. Let's start with a classic example, summing a range of numbers:

{% highlight ruby %}
(1..100).inject { |running_total, number| running_total + number }
{% endhighlight %}

To understand what's going, let's also include how you might tackle this without inject:

{% highlight ruby %}
running_total = 0
(1..100).each do |n|
  running_total += n
end
{% endhighlight %}

Here you realize that you need to iterate through every member of the collection with an each loop and also to persist something through every iteration that is updated each time. These requirements for both iterating through a collection and the need to persist something through each of these iterations are flashing red lights for an enumerable method, the most powerful being inject. Whereas the local variable running_total acts as the object being passed through each iteration, inject provides this to us automatically. This object is then set from what is returned from each iteration.

Moreover, if you wanted to start with a value other than the first one of the collection, you could do so by providing an argument:

{% highlight ruby %}
(1..100).inject(1) { |running_product, number| running_product * number }
{% endhighlight %}

With this ability to condense a lot of logic to a relatively few number of lines, however, should come a word of caution. Your primary goal should be to [write code worth reading](/2015/01/14/write-code-worth-reading/) and being too fancy with some enumerable methods can be an easy way to write code that looks good but actually difficult to debug and interpret. Moreover, as you refactor you should also heavily consider pulling these out to their own methods so that a thoughtful method name will clarify your intention to other developers.
