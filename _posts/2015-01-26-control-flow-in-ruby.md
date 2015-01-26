---
layout: post
title: Control Flow in Ruby Pt. I
comments: true
---

Control flow is an important beginner concept in Ruby that you'll need to master
early on. Understanding the concepts can be difficult to someone new to
programming but, once the idea starts to sink in, you find yourself no longer
struggling with the syntax but instead with the overwhelming number of options
you could use to several your particular problem. In fact, many beginners
overuse the first control flow concept they really understood well and never
branch out to understand the others.

In light of this, I'm going to provide some general guidelines for how to think
through the various options you have when needing control flow.

##Use the if statement for two branches of logic or less

The if keyword verifies whether an expression is true. If it is, the next line
is executed. 

{% highlight ruby %}
if number < 100
  puts "x"
end
{% endhighlight %}

{% highlight ruby %}
if number < 100
  puts "x"
else
  puts "y"
end
{% endhighlight %}

{% highlight ruby %}
puts "x" if number < 100
{% endhighlight %}

These are generally the scenarios I use if statements for. Each one has a
maximum of two branches of logic, and I prefer the third single line syntax if
it feels more readable and can fit in an 80 character line.

##Use Unless over if !condition

I like the unless statement over awkward if !condition because I think it is
more readable.

{% highlight ruby %}
unless decimal
  puts "whole number"
end
{% endhighlight %}

As with if, I also prefer single-line syntax when possible

##Use the case statement for multiple branches

One could use a whole nest of elsif statements but it makes your code messier
and difficult to read. Prefer the case statement:

{% highlight ruby %}
case song
when "I Will"
  puts "White Album"
when "Tomorrow Never Knows"
  puts "Revolver"
when "Hello, Goodbye"
  puts "Magical Mystery Tour"
else
  puts "Don't know"
end
{% endhighlight %}

Sometimes you have multiple branches of logic but the conditions are a little
more complicated so you feel forced into a lot of complicated elsif statements.
This is a sign that you need to refactor the logic into separate methods.
Usually you can then create a new variable and use this in a case statement.
