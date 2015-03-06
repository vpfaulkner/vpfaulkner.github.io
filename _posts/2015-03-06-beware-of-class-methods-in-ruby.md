---
layout: post
title: Beware of Class Methods in Ruby
---

It is so easy to resort to class methods in Ruby. The behavior you are trying to implement seems to be stateless and writing a class method just seems easier.

{% highlight ruby %}
class FileCompressor

  def self.compress(file)
    # compressing...
  end

end
{% endhighlight %}

You think to yourself here: the idea of state does not seem that attractive here. This compression should be completely stateless as the only needed in our case is what we are passing in as its argument, the file.

However, let's say your compression logic begins to grow a little bit:

{% highlight ruby %}
class FileCompressor

  def self.compress(file)
    determine_file_type
    # compressing...
  end

  def self.determine_file_type(file)
    # determining...
  end

end
{% endhighlight %}

OK, no big deal right? Well, suddenly the complexity of your compression logic is growing and each individual method must use only its argument(s) as context. You are navigating a slippery slope here that will make your code not only harder to read and write but also more resistant to refactoring. The key idea is that that with each addition of behavior you add via a new method your class is becoming more and more state-like yet it has no way to store state because you never instantiated it. Your code is becoming more and more procedural and resisting that natural advantages offered by an object-oriented design. At this point I would recommend rethinking your class:

{% highlight ruby %}
class FileCompressor

  def initialize(file)
    @file = file
  end

  def compress
    determine_file_type
    # compressing...
  end

  def determine_file_type
    # determining...
  end

end
{% endhighlight %}

This design rethink will give you a more natural way to accommodate change in behavior and prevent class method "feature envy" here.
