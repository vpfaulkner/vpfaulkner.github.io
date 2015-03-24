---
layout: post
title: Sets, The Other Collection in Ruby
---

Even if you've been using Ruby for a decent amount of time there is a good chance that you haven't really played with Sets. We have embraced Arrays and Hashes so much that, when a use-case for Sets comes up, we often forget they are even an option and go straight to one of those two.

Sets in Ruby are based on the concept of a [set in math](http://en.wikipedia.org/wiki/Set_(mathematics)) and are appropriate when you want to store a list of items, similar to that of an array, but only want to store unique items, similar to keys in a hash.

{% highlight ruby %}
require 'set'

set1 = Set['a', 'b', 'c']
#=> #<Set: {"a", "b", "c"}>
set1 << 'd'
#=> #<Set: {"a", "b", "c", "d"}>
set1 << 'a'
#=> #<Set: {"a", "b", "c", "d"}>
{% endhighlight %}

As you can see, adding an item feels just like an Array but a Set will not create duplicate items.

Sets also work well together allowing you to find the union, intersection, and more--just like you would in math class.

{% highlight ruby %}
set2 = Set['y', 'z', 'a']
#=> #<Set: {"y", "z", "a"}>
set1 || set2
#=> #<Set: {"a", "b", "c", "d"}>
set1 & set2
#=> #<Set: {"a"}>
set1 - set2
#=> #<Set: {"b", "c", "d"}>
{% endhighlight %}

So when would you use a set? I would recommend considering sets when 1) you don't want duplicates, 2) order doesn't matter, and 3) you might want to compare two lists for equality (of items included--not order of items), intersections, etc.

{% highlight ruby %}
require 'set'

participating_organizations = Set.new
employees.each do |employee|
  if employee.participating
    participating_organizations << employee.organization.id
  end
end
{% endhighlight %}

Here we consider an organization as participating if at least one employee is participating but don't want to create duplicate organizations. Moreover, if we were to decide to have multiple events that an organization could participate in, we could do so easily with just another Set and compare the two easily.

As you can see, Sets have several handy use-cases in Ruby but often get overlooked for an Array or Hash. Next time you find yourself in one of these use-cases, ask yourself if a Set would be a better fit.
