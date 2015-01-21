---
layout: post
title: How Big Should Methods Be?
comments: true
---

I love rules of thumb because they easily and clearly communicates a best practice but in a non-standoffish way that could overpower the true intent of that best practice. One that I always return to is that methods should be no longer than five lines of code (see [Sandi Metz's blogpost](http://robots.thoughtbot.com/sandi-metz-rules-for-developers) on the Thoughtbot blog). 

Now to be honest, I take this as more of a rule of thumb than an unbreakable law
but perhaps that is because I bend more towards pragmatism than purist although
I (like you) try to walk that in that in-between. This means I'm not going
through my code or my coworkers code hellbent on conforming it to meet this
standard, but I am usually advocating for smaller methods, particular if the
method is 10 lines or more. The reasons I like this are:

1. [Readability of
   code](/2014/01/14/write-code-worth-reading/) is the ultimate test of good code for me and I think
   small methods with good names make a huge difference in readability. 
2. I am forced to make large public methods much smaller which in turn
   forces me to make a lot of these methods private to [limit that class' public
interface](/2014/01/21/private-methods-in-ruby/). The result is more readable public interface and me having to spend more
time actually thinking about what kind of public interface I want to have.
3. Small things are simply easier to work with and more accommodating to change. 

Again, this is a rule of thumb that should push you in the right direction but
not at the expense of more important things (such as just getting started).
Using it to your discretion, you should be on your way to much more readable,
flexible code.
