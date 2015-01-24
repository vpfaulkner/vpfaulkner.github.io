---
layout: post
title: Make your Ruby Objects Single-Minded
comments: true
---

The easiest way I have found to ensure I am writing good object-oriented (OO)
code is to ask, "What should this object know and not know?" It makes the
objects a little more real and concrete for me, and forces me to write clean
and simple code because it is such an honest and simple question. 

The [Single Responsibility
Principle](http://en.wikipedia.org/wiki/Single_responsibility_principle) is a
fundamental idea in OO programming and should always be your first question when
you feel your code is starting to get out of hand. Take the following example:

{% highlight ruby %}
class Checkout

  def purchase(item)
    item_price = item.price
    tax = item_price * .07
    grand_total = item_price + tax 
  end

end
{% endhighlight %}

Here I've tried to isolate that moment when your gut is starting to feel a
little so-so about the code because you are introducing something into the
Checkout logic that feels a little out of its domain: knowledge of how to
appropriate tax to the checkout. 

Now this is a simple example where you might only care about local state tax, but
it is suddenly a leak in your airtight encapsulation of responsibility. What if
this logic suddenly has to accommodate multi-state purchases and know more than
one state tax rate? What if certain items are taxed at different rates? You can
see that trying to keep this logic in Checkout becomes a losing battle.

But the early signs of responsibility shift are not the difficult to see if you
are asking the right question. Should Checkout need to know about the taxing
rules for different states and different items? In any but the most
rudimentary, time-sensitive context, the answer should be no.
