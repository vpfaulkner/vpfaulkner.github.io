---
layout:posts
title: The Law of Demeter
---

You have already almost certainly felt the pain that the Law of Demeter tries to save you from so in introducing it here we should start with an example of code gone wrong.

Let's say you were building a shopping cart application and wanted their default billing address to be displayed:

{% highlight ruby %}
class ShoppingCart
  def checkout
    billing_address = default_billing_address
  end

  def default_billing_address
    @user.credit_cards.billing_address
  end
end
{% endhighlight %}

This might work fine for a while but then we realize that not every user has a credit card. Perhaps a short-term solution is to guard against this outcome right here:

{% highlight ruby %}
class ShoppingCart
  def checkout
    billing_address = default_billing_address
  end

  def default_billing_address
    @user.credit_cards.billing_address if @user.credit_cards
  end
end
{% endhighlight %}

This will now protect you in the case of no credit card on file and it seems to work for a while until the developer who owns the user credit card related code decides to add the ability to maintain multiple credit cards on record including a preferred card:

{% highlight ruby %}
class ShoppingCart
  def checkout
    billing_address = default_billing_address
  end

  def default_billing_address
    @user.credit_cards.preferred.billing_address if @user.credit_cards
  end
end
{% endhighlight %}

OK, at this point you are starting to realize that your ShoppingCart class might know a little bit too much about the user. Recent changes to an unknown object, CreditCard, is already having unforeseen consequences in ShoppingCart and any proposed future changes will be difficult to anticipate and prevent.

This is the beginning of spaghetti code and the moment when you start to realize the Law of Demeter. The Law of the Demeter mandates that objects only talk to other objects that are closely related, or immediately available. The tell-tale sign in Ruby is the multiple dots (.) to represent a reaching across of objects. In this case, a method in ShoppingCart reaches across the User object to a CreditCard object to get its billing_address. The moment the interface of CreditCard changes, your ShoppingCart code breaks just as in the example above with storing multiple credit cards.

Code that respects the Law of Demeter does not make any assumptions about objects it only can access via an intermediary object, in this case User. Instead it must either talk directly to that 3rd object or the interface of the intermediary object must change in order to wrap the necessary request. As the interface and desired behavior of distance objects change, the only objects you must focus on updating are those immediately surrounding it:

{% highlight ruby %}
class ShoppingCart
  def checkout
    billing_address = @user.default_billing_address
  end
end

class User
  def default_billing_address
    if credit_cards.preferred
      credit_cards.preferred.billing_address
    else
      default_shipping_address
    end
  end
end
{% endhighlight %}

While the Law of Demeter is more of a guiding principle than unbreakable law, you should stop and consider object responsibilities the moment you are tempted to break the Law of Demeter. It is there to help you stay disciplined in writing clean objected oriented code that is accommodating to change rather than resistant to it.


