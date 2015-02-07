---
layout: post
title: Why Naming Matters
comments: true
---

One of the more subtle lessons I've learned since I started developing was how
much object names both guide and reveal your thought process as you are building
an application. Consider a few rules of thumb:

###Stick with real world objects as much as possible. Don't be cute

{% highlight ruby %}
class Song
  def initialize(name, artist, album, duration)
    @name     = name
    @artist   = artist
    @album    = album
    @duration = duration
  end
end
{% endhighlight %}
instead of:
{% highlight ruby %}
class SongMaker
  def initialize(name, artist, album, duration)
    @name     = name
    @artist   = artist
    @album    = album
    @duration = duration
  end
end
{% endhighlight %}
###Use is_attribute? for Booleans

{% highlight ruby %}
user.update(is_connected?: true)
{% endhighlight %}
instead of:
{% highlight ruby %}
user.update(connected: true)
{% endhighlight %}

###Don't include object type
 
{% highlight ruby %}
class Song
  def initialize(name, artist, album, duration)
    @name     = name
    @artist   = artist
    @album    = album
    @duration = duration
  end

  def split
    # split logic
  end
end
{% endhighlight %}
instead of:
{% highlight ruby %}
class Song
  def initialize(name, artist, album, duration)
    @name     = name
    @artist   = artist
    @album    = album
    @duration = duration
  end

  def split_method
    # split logic
  end
end
{% endhighlight %}
If you haven't also checked out the [Ruby Style
Guide](https://github.com/bbatsov/ruby-style-guide) you should do so. 
