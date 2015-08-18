---
layout:post
title: Module Configuration in Ruby
---

Recently I wanted to introduce an object store wrapper to my application with a simple, singleton interface like the one below:

{% highlight ruby %}
ObjectStore.write(id, object)
ObjectStore.retrieve(id)
{% endhighlight }

This object would not be instantiated and thus I started out with a module defining the two methods on the singleton instance:

{% highlight ruby %}
module ObjectStore
  class << self
    def write(id, object)
      # write logic
    end

    def retrieve(id)
      # retrieve logic
    end
  end
end
{% endhighlight %}

This allowed me to offer such an interface and for a while all seemed well. However, there soon became a need to ever-so-slightly configure this module. We wanted to be able to configure the connection to our object store service including the API keys required as part of that connection. Moreover, we wanted to be able to configure based on ENV variables and put the configuration code in our config.ru file that would be run upon booting up the app (this was a bare bones rack app that used rackup). We were picturing something like this:

{% highlight ruby %}
# config.ru
ObjectStore.configure do |config|
  config.username = ENV['SL_USERNAME']
  config.api_key  = ENV['API_KEY']
end
{% endhighlight %}

How could we accommodate this? Well the first thing we had to do is provide a configure method that yielded self to this block:

{% highlight ruby %}
module ObjectStore
  class << self
    def configure
      yield self
    end
  end
end
{% endhighlight %}

The self of course is the ObjectStore singleton and by yielding it we can provide it to the given block (as we do with config in the example above) to do any configurations it deems necessary. Finally, we need to offer the configurable attributes as methods:

{% highlight ruby %}
module ObjectStore
  class << self
    attr_accessor :username, :api_key

    def configure
      yield self
    end
  end
end
{% endhighlight %}

This cleanly allows us to both provide a singleton interface to the rest of the app as well as a way to the configure this object from the outside.
