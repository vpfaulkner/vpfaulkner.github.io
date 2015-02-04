---
layout: post
title: Sidekiq in Rails
comments: true
---
If you're looking to run a background job in Ruby, one tool that I have found very easy to work with is Sidekiq. First off, how to use it:

Begin by adding it to your Gemfile:

{% highlight ruby %}
gem 'sidekiq'
{% endhighlight %}

Install:

{% highlight sh %}
bundle install
{% endhighlight %}

Define the job you need done with a perform method:

{% highlight ruby %}
# app/workers/email_worker.rb
class EmailWorker
  include Sidekiq::Worker

  def perform(email)
    # Email logic
  end
end
{% endhighlight %}

And call the worker where appropriate

{% highlight ruby %}
class RegistrationController < ApplicationController

  def register
    # Registation Logic
    EmailWorker.perform_async(current_user.email)
  end
end
{% endhighlight %}

Get the Sidekiq process going from the shell in your root directory:

{% highlight sh %}
bundle exec sidekiq
{% endhighlight %}

Beyond knowing how to do Sidekiq for background processing, the question remains for when to use it. 

For me Sidekiq (or any background job) is a trade-off of control and reliability for speed. Testing workers can be very difficult and trying to incorporate a complex workflow where certain actions must be kickedoff after the completion of multiple asynchronous processes can be unstable. Furthermore, it has an issue of thread saftey meaning you must use libraries in Sidekiq that are considered thread safe. For those whom this is a deal-breaker by the way, one other alternative is, [Resque](https://github.com/resque/resque) which is a little slower but doesn't require thread-safe code.

However, for a lot of situations such as the one here that involves sending an email in the background after registration, using a background job such as Sidekiq is perfect. In this case, any additional registration logic you want done does not have to wait for the email to be sent; furthermore, if you need to several things at once (such as emailing a larger mailing list) than doing that work in the background will allow you to make huge gains in speed.
