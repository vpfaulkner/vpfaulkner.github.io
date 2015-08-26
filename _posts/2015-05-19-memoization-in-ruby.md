---
layout: post
title: Memoization in Ruby
---
Let's say you are relatively new to Rails and progressing through one of your first major Rails applications when you suddenly become conscious for the first time about performance. This happened to me when I was loading a large YAML file into memory and the app's performance on the free Heroku account began to suffer.

Caching is one of the most difficult tasks in software development but in practice it can take a variety of techniques. One such technique is memoization: this involves essentially eagerly doing some computation up front and storing the result of that computation for later use. The key here is that the result of that work should not change and therefore caching it will not lead to misleading values. To illustrate this idea:

{% highlight ruby %}
def pi_squared
  Math::PI**2
end
{% endhighlight %}

This is an overly simplified example but gets to the advantage of eagerly doing some work. If your program needed PI squared (for whatever reason, I do not know), then why would you want to compute that every time since it shouldn't change?

{% highlight ruby %}
def pi_squared
  @pi_squared ||= Math::PI**2
end
{% endhighlight %}

For those that haven't used this technique before in Ruby, it basically is shorthand for:

{% highlight ruby %}
 @pi_squared = @pi_squared || Math::PI**2
{% endhighlight %}

Essentially that Math::PI**2 will only be executed the first time with the result saved to memory for later use.

Although this will technically save you time, real savings will come in queries to a database or external service:

{% highlight ruby %}
def us_senators
  @us_senators ||= SenatorAPIWrapper.get_senators
end
{% endhighlight %}

Here, you may be using an external service to query for all US Senators which can be expensive if you query multiple times. Moreover, the collection of senators rarely changes meaning it is very safe to assume what is saved in memory will remain correct. In other words, this is data that is perfect to cache because it is expensive to gather and rarely changes.

If you had to do some multiline queries you could accommodate that as well:

{% highlight ruby %}
def congress
  @congress ||= begin
    senators = SenatorAPIWrapper.get_senators
    representatives = RepresentativeAPIWrapper.get_representatives
    senators.merge representatives
  end
end
{% endhighlight %}

These examples are very stripped down use-cases and only begin to get into the wide variety of caching techniques. Next on the list of things to research should be [gem's to memoize](https://github.com/dkubb/memoizable), [sessions in Rails](http://guides.rubyonrails.org/security.html), and consideration also of when you should store something in a database vs in memory. However, the tradeoffs of caching are the same meaning you will always be trading how old data is versus how expensive it is to gather.

