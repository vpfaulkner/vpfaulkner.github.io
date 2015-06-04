---
layout:post
title: Inheritance in Ruby
---

Inheritance is a little different in Ruby if you've come from other languages. Unlike other languages, you can only inherit from one (and only one) class in Ruby which has resulted in the technique being used comparatively less but also caused the result to be a little cleaner when it is used. To begin, we can include some simple examples of what inheritance actually is:

{% highlight ruby %}
class Parent

  def shared_method
    "I am shared"
  end
end

class Child < Parent
end

Parent.new.shared_method   # => "I am shared"
Child.new.shared_method    # => "I am shared"
{% endhighlight %}

As you can see, the behavior from Parent is endowed to Child. Think of it almost as if everything between {% highlight ruby %}class Parent{% endhighlight %} and {% highlight ruby %}end{% endhighlight %} is copied and pasted to the Child class.

Let's say you wanted to inherit some more functionality. You could do so but only through a longer line of inheritance:

{% highlight ruby %}
class Parent

  def shared_method
    "I am shared"
  end
end

class Child < Parent
end

class GrandChild < Child
end

Parent.new.shared_method        # => "I am shared"
Child.new.shared_method         # => "I am shared"
Grandchild.new.shared_method    # => "I am shared"
{% endhighlight %}

In example this seems like a perfectly clear cut and obvious design choice but in reality the messy gray will come when you know to objects will have shared behavior but perhaps not perfectly shared behavior. Almost always, you should only use inheritance if the two objects in question have a hierarchical relationship, that is one object is a more specialized version of another object. One scenario I've run into where inheritance makes sense more is when you are having to deal with lots of increasingly specialized categories. Say, for example you had a massive online store with lots of categories of products:

{% highlight ruby %}
class Product

  def purchase
    # purchase logic
  end
end

class DigitalMovie < Produce

  def purchase
    super
    download
  end

  def download
    # download logic
  end
end
{% endhighlight %}

Here it is clear that a DigitalMovie is a type of product and thus embodies that hierarchical relationship. Now if this were a real life application that you were starting from scratch you first instinct should be to stick with just the Product class and perhaps have a category attribute with DigitialMovie being a category. Keeping your design as simple as possible is your first priority and if the required behavior for every type of product is nearly identical, then this would make sense.

The {% highlight ruby %}super{% endhighlight %} you see here is a technique to call the purchase method on the Product class. This allows you to easily include the generic purchase behavior and add the more specialized download behavior, both as part of purchase.

The problem of increasingly divergent behavior will take you to a design crossroads however. In this example, a DigitalMovie requires very unique download behavior once it is purchased (vs say a table which cannot be downloaded). Trying to cram this specialized behavior into Product will begin to bloat that class and put increasing pressure on the type field you might have originally included. With the design choice to have a generic product class with specialized subclasses, you now have a clear and clean path forward when asked to implement more complex and specialized behavior.

A final word of caution however: inheritance can snowball quickly and lead big problems down the road if the two objects in question do not cleanly fit into that hierarchical relationship mentioned earlier. A good rule of thumb to help you navigate this uncertainty is to ask whether two objects are merely *doing* the same thing are if they actually *are* the same thing. If they are merely doing the same thing then you should consider the use of another object to thing or perhaps a module to hold that behavior. And if you decide they actually are the same thing, then consider inheritance.


