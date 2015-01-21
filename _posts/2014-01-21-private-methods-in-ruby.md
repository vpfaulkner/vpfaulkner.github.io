---
layout: post
title: Private Methods in Ruby
comments: true
---

"Why does anyone use private methods?", you might ask as a beginner to Ruby. In
some ways the question makes sense: you are only hiding this method from
yourself or someone else whom you trust enough already to be working along the
project with you. So what gives?

Let's start with an example:

{% highlight ruby %}
class Concert

  def initialize(band, time, number_of_attendees)
    @band = band
    @time = time
    @number_of_attendees = number_of_attendees
  end

  def prepare
    open_venue
    # other preperations
  end

  private # Every method below this is private

  def open_venue
    # open venue logic
  end

end

concert = Concert.new
concert.prepare
concert.open_venue #NoMethodError: private method 'open_venue'
{% endhighlight %}

Here you can see that we are able to see that open_venue is defined under
private in the class, that open_venue can be called within the class, but it cannot
be called outside of the class. This is because in Ruby private methods cannot have an explicit receiver. When we call concert.open_venue our explicit receiver is concert, but when it is called in the prepare method it is called implicitly within the calling object.

Knowing how it works, however, doesn't get back to the original question of "Why
ever use it?"

I advocate private methods as a means of clearly defining the public interface
for a class. Public interfaces are a very important concept and allow you the
signal to other developers that some of these things are publicly available to you and
will remain relatively stable while other things are not and may be subject to
change. This is particularly relevant in Rails controllers where I suggest
keeping only the methods associated with controller actions public while making 
any others private. This separation of concerns frees you up to continually rework the
"how" methods that contain must of the logic without fear of breaking external
code and gives developers working with your class from the outside an ease of mind that they are working with a reliable public interface.
