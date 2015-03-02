---
layout: post
title: Structs in Ruby
comments: true
---

What is a Struct anyway? That's what I thought for the longest time until I started to see the benefits of them. First, how they work:

If you have a scenario where you would like to pull out an extremely simple class then using a Struct instead might be the way to go:

{% highlight ruby %}
class Birthday < Struct.new(:day, :month, :year)
end

joes_birthday = Birthday.new(1, 2, 2003)
{% endhighlight %}

If you were working on a Person or User class and wanted to abstract out some of the birthday logic which you know will be relatively stable and simple then a Struct makes sense. Here are some characteristics I look for when considering a Struct:

* It has stable, fixed data attributes

* It is in fact a separate data object but is still very small.

* I know I will always have all of its attributes upon instantiation (otherwise NoMethodErrors)

* I feel certain that the needs of this object will not soon merit a full on class

To summarize, Structs usually hold that in-between territory of needing more than an in-memory hash and less than a regular class.

One more note on OStructs or OpenStructs: OStructs are very similar to regular Structs although they allow you to arbitrarily change attributes.

{% highlight ruby %}
joes_birthday < OpenStruct.new
joes_birthday.year = 2003
{% endhighlight %}

I tend to use OStructs less because for me they are already starting to feel class-worthy, particularly since I like small classes anyways. If your data merits an object, and you can't be sure that this might not grow in terms of complexity and importance then I usually go straight to creating a new class.
