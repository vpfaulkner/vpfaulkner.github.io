---
layout:posts
title: What is the Enumerable Module in Ruby?
---
If you are looking for a method to do some fairly complex logic on a collection in Ruby, the first place you should look is the Enumerable module. As you might recall, modules allow methods and constants to be included in a class as part of a mixin. This allows you to share code without relying on inheritance which is limited to one class in Ruby. Oftentimes modules then tend to [play the role of container](/2015/01/11/when-to-use-modules-in-ruby/) for common logic between somewhat unrelated classes.

Any class that implements an #each method can use Enumerable although the classes you are probably most familiar with that use it are Array and Hash. In fact, if you are particularly new at Ruby you may be using Enumerable methods already (Map for instance) on an instance of Array or Hash and not even realize that the method is available via the Enumerable mixin.

To see all of the Enumerable methods:

{% highlight ruby %}
Enumerable.instance_methods
=> [:to_a, :entries, :to_h, :sort, :sort_by, :grep, :count, :find, :detect, :find_index, :find_all, :select, :reject, :collect, :map, :flat_map, :collect_concat, :inject, :reduce, :partition, :group_by, :first, :all?, :any?, :one?, :none?, :min, :max, :minmax, :min_by, :max_by, :minmax_by, :member?, :include?, :each_with_index, :reverse_each, :each_entry, :each_slice, :each_cons, :each_with_object, :zip, :take, :take_while, :drop, :drop_while, :cycle, :chunk, :slice_before, :lazy]
{% endhighlight %}

Enumerable provides a ton of useful methods (all of which are explained fully [here](http://ruby-doc.org/core-2.2.2/Enumerable.html#method-i-map)) but some of the main ones you will see are below:

# Sort

{% highlight ruby %}
[3, 1, 2].sort
=> [1, 2, 3]

[3, 1, 2].sort { |a, b| b <=> a }
=> [3, 2, 1]
{% endhighlight %}

As you can see, Sort will iterate through each item and either use a given <=> (spaceship) operator or standard means of determining less than, equal to, or greater than. A sorted array will be returned.

# Select

{% highlight ruby %}
[3, 1, 2].select { |i| i.even? }
=> [2]
{% endhighlight %}

Similar to sort, select takes a collection and a block. It item that returns true from the block will be returned as part of an array.

# All? and Any?

{% highlight ruby %}
[3, 1, 2].all? { |i| i.odd? }
=> false

[3, 1, 2].any? { |i| i.odd? }
=> true
{% endhighlight %}

Pretty self-explanatory, right?

There are many more useful methods but this will give you a good sense of what you can do with Enumerable methods. One in particular worth checking out is the #inject method of which you can find a [whole blog post here](/2015/03/23/the-inject-method-in-ruby/).




