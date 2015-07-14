---
layout: post
title: Ruby on Rack
---

What does Rails, Sinatra and several other popular Ruby frameworks have in common? They are all built on Rack, a Ruby webserver interface. My interest in Rack came recently as I was decided how I wanted to build a very simple application for which Rails would be overkill. I thought about Sinatra and in the end Sinatra would have been fine but I wanted to go as minimal as possible so I stuck to Rack.

Rack is about as bare-bones as you can get with the simplest of examples found on their website:

{% highlight ruby %}
# my_rack_app.rb
 
require 'rack'
 
app = Proc.new do |env|
    ['200', {'Content-Type' => 'text/html'}, ['A barebones rack app.']]
end
 
Rack::Handler::WEBrick.run app
{% endhighlight %}

What you need is something that will respond to call with the environment passed in as a hash parameter and that will return an array with three things: the HTTP response code, a Hash of headers, and the response body, "which must respond to each."

This implementation would work if you want to call the app yourself such as through your own executable. A second implementation that I took was to enable the rackup command by providing a config.ru file. Yes, this is the same type of file that you see in Rails applications and serves the same purpose. All you need here is to run the thing (in this case app) that responds to call and returns those three items:

{% highlight ruby %}
# config.ru
require_relative "app"

run App
{% endhighlight %}


{% highlight ruby %}
# app.rb
class App
  def self.call(env)
    # Process the request
  end
end
{% endhighlight %}

Running the application can be done simply with:

{% highlight sh %}
rackup config.ru
{% endhighlight %}

I prefer this setup because it starts to separate your app configuration from your app processing. Note it is standard to provide the App class itself as the object to receive call rather than an instantiation of that object. This helps promote the idea that each request is "stateless" and discourages you from setting up instance variables to share state between requests.

In terms of configuration, striking the right balance between too much complexity and too little is an art and I would encourage you to keep dependencies down as much as possible. As you can see below, I do include Ruby Gems and Bundler to manage the Gemfile, using the RACK_ENV env variable to take advantage of Gemfile groups.

{% highlight ruby %}
# config.ru
require 'rubygems'
require 'bundler/setup'
Bundler.require(:default, ENV["RACK_ENV"].to_sym)
require_relative "app"

run App
{% endhighlight %}

As you fill out your application from here there are many directions to take. The one guiding principle I would recommend is to maintain your minimal approach to the application. Keeping its responsibilities and dependencies simple your should be able to provide and maintain a much more stable and dependable service for your consumers.
