---
layout: post
title: When to use modules in Ruby
comments: True
---

When should you use modules in Ruby? 

###Question 1: Do you need to it to carry state?

If so, then you should probably use a class. In fact, for most use-cases,
particularly if you are new to object-oriented programming, if what you are
trying to do should be done with a class.

When thinking of your program, think first in terms of what objects are
necessary for you to create the interactions required. Methods that for whatever
reason do not form an object that should be instantiated can be contained within
a class.

###Question 2: Could this be done with a few singleton class methods on an existing class?

While oftentimes overused, class methods can be a better alternative.

{% highlight ruby %}
class Document

  def self.find_pdf
    #...
  end

end
{% endhighlight %}

###Question 3: Will this be helpful in multiple classes?

Modules provide mixin functionality and allow you to extend the same logic to
multiple classes.

{% highlight ruby %}
module Converter 

  def convert_to_pdf
    #...
  end

end

def class Document
  include Converter

  #...
end

document = Document.new
document.convert_to_pdf
{% endhighlight %}

###Question 4: Do I need it for namespacing?

I generally don't think namespacing is the best reason to create a module but
there are certain use-cases (such as with building APIs that might need
namespacing for versioning) when it becomes appropriate.

{% highlight ruby %}
module Math
  PI = 3.14
end

def circle
  def circumference(radius)
    2 * Math::PI * radius
  end
end
{% endhighlight %}
