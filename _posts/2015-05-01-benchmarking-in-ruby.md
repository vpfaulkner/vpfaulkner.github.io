---
layout: post
title: Benchmarking in Ruby
---

Benchmarking, [like logging](/2015/04/08/basic-logging-in-ruby/), deserves more attention than it currently gets. Unless your application is just getting off the ground with little or no usage, performance testing should accompany other functional tests (such as unit, and integration tests) as part of your continuous integration infrastructure.

Luckily, basic benchmarking is easy in Ruby via the built-in Benchmark module:

{% highlight ruby %}
require 'benchmark'

puts Benchmark.measure { 10_000_000.times { |i| i ** 2 } }
{% endhighlight %}

This returns:

{% highlight Bash shell script %}
 0.900000   0.000000   0.900000 (  0.902290)
{% endhighlight %}

 These represent (all in seconds):
* user CPU time
* system CPU time
* the sum of the user and system CPU times
* the elapsed real time

The last one is probably most important for you, the elapsed real time.

This syntax is ideal for very simple benchmarking where you might for example want to see how long a single method takes. However, a much more common need is to compare multiple approaches to the same problem to see which performs better:

{% highlight ruby %}
require 'benchmark'

array = Array (1..1000)
set = Set.new (1..1000)

Benchmark.bm do |x|
  x.report { array.include? 999 }
  x.report { set.include? 999 }
end
{% endhighlight %}

This returns:

{% highlight Bash shell script %}
       user     system      total        real
   0.000000   0.000000   0.000000 (  0.000226)
   0.000000   0.000000   0.000000 (  0.000006)
{% endhighlight %}

As you can see, the Array include? is a lot slower than the Set include? (a Set does not preserve original order so a binary search technique can be used when looking up items).

There are a number of more advanced options all available as part of the standard module and can be found [here](http://ruby-doc.org/stdlib-1.9.3/libdoc/benchmark/rdoc/Benchmark.html).
