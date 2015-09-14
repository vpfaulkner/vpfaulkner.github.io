---
layout: post
title: Keyword Arguments in Ruby
---

Beginning with Ruby 2.0 developers can take advantage of the new keyword argument syntax:

{% highlight ruby %}
def greet(name: 'friend')
  puts "Hello #{name}!!!"
end

greet(name: 'Vance') # => 'Hello Vance!!!'
greet # => 'Hello friend!!!'
{% endhighlight %}

A few things of note:

1) Unlike an options hash, we no longer have to pull out the variables from a hash early on in the method

2) As you can see, the name keyword argument will default to friend when not supplied anything.

If you wanted to use this syntax without making the argument optional simply don't provide a default value:

{% highlight ruby %}
def greet(name:)
  puts "Hello #{name}!!!"
end

greet # => ArgumentError: missing keyword: name
{% endhighlight %}

As you would guess with Ruby, this syntax was introduced to provide yet another way to define and call a method in keeping with the language's pattern of offering many ways of doing the same thing. Once more, as you might expect from such a pattern, choosing the right way to do something depends on tradeoffs and context.

The previous example actually provides a better illustration to me of using the standard positional argument syntax because it only asks for a single argument:

{% highlight ruby %}
def greet(name)
  puts "Hello #{name}!!!"
end

greet('Vance') # => 'Hello Vance!!!')
{% endhighlight %}

If you were told that you would be supplied an interface for a method that will provide a greeting, this is almost exactly what you might image. And in keeping with my personal preference for having lots of small, simple methods many of which take a single argument, the positional argument syntax works fine.

However, for cases where you might be tempted to use a hash parameter I find this syntax works much better:

{% highlight ruby %}

# Positional syntax
song_descriptor("Getting Better", "Sgt. Pepper's Lonely Hearts Club Band", "The Beatles", 1967)

# Keyword syntax
song_descriptor(song: "Getting Better",
                album: "Sgt. Pepper's Lonely Hearts Club Band",
                band: "The Beatles",
                year: 1967)
{% endhighlight %}

