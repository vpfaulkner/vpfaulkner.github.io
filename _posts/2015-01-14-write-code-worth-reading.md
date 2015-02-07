---
layout: post
title: Write Code worth Reading
comments: true
---
Coding is full of a lot of gray decisions. There is a ambiguous spectrum between
design choices and stylistic choices and no easy sense of where one ends and
the other begins.

For more stylistic choices that tend to be more syntactically focused I  rely on
the [Ruby Style Guide](https://github.com/bbatsov/ruby-style-guide) and try to
always rely on the same question for ultimately making my decision: Which choice
is easiest for me to read?

For example, the following choices achieve the same functionality in your code:

{% highlight ruby %}
# Choice A
if x % 2 == 0
end

# Choice B
if x.even?
end
{% endhighlight %}

Every design choice involves tradeoffs and so your first instinct should always
be to look for the tradeoffs of different options. Yet, this syntactic choice is
less about tradeoffs and more about what stylistic choice you prefer. I defer to
the question of readability here simply because most of my (and your) time will
be spent reading code rather than writing it. For me, I consider Choice B to be
vastly more readable and so it is the one I would go with. 

Comprehensible code makes an incredible difference in productivity, much more so I would argue than what editor you use, what flavor of agile you subscribe to, or even how efficient your code is, and it should be your top priority in writing code when it comes to stylistic questions. 
