---
layout: post
title: Debugging Ruby with Pry
comments: true
---

There is nothing worse than trying to fix code without a debugger. Since
starting with Ruby, Pry has become perhaps the most essential tool for me to
be productive and happy. [Pry](http://pryrepl.org/) is the de facto standard for
Ruby and acts as a debugger and alternative to IRB.

Install the Gem:
{% highlight sh %}
gem install pry
{% endhighlight %}

Ensure pry is available in your Ruby file and drop binding.pry in:
{% highlight ruby %}
# test.rb
require 'pry'

class A
  def hello() puts "hello world!" end
end

a = A.new

# start a REPL session
binding.pry

# program resumes here (after pry session)
puts "program resumes here.
{% endhighlight %}

This will open up a Pry session where you can investigate the program state at
that point and begin debugging. 

{% highlight sh %}
pry(main)> a.hello
hello world!
=> nil
pry(main)> puts x
10
=> nil
{% endhighlight %}

The closer you get to your code the smaller your feedback loops, the more
quickly you'll be productive. Instead of trying to guess what a variable is at
that point in the program, just drop a pry in and find out for sure. 

I prefer to use this approach most with a test driven development workflow where
I am constantly invoking the debugging session by running the particular
test I am working on. 
