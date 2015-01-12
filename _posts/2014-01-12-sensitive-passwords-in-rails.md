---
layout: post
title: What to do with Sensitive Information in Rails?
comments: true
---
If you are just starting with Rails you will probably run into a moment where
you need to incorporate some sensitive information that you don't want to expose
to the world via Github.

There are multiple approaches but the easiest I've run into is with the [dotenv
gem](https://github.com/bkeepers/dotenv). Per the instructions:

{% highlight ruby %}
gem 'dotenv-rails', :groups => [:development, :test]
{% endhighlight %}

Execute:

{% highlight sh %}
$ bundle
{% endhighlight %}

This will allow you to have consistent syntax in your Rails code with a
centralized place to keep your sensitive information in. Add a .env
[dot-file](http://en.wikipedia.org/wiki/Dot-file) to the root of your project
(directly under the project folder) formatted like the following:

{% highlight ruby %}
SECRET_KEY=SECRETKEYHERE
{% endhighlight %}

This will allow you to access these keys through the following syntax:

{% highlight ruby %}
my_key = ENV['SECRET_KEY']
{% endhighlight %}

Finally, you probably want to ensure this document does not get included in
source control so add it to your
[.gitignore](https://help.github.com/articles/ignoring-files), also to be stored
in the root of your project.

{% highlight ruby %}
.env
{% endhighlight %}

If you are working in a group, you should then document that this .env file is
necessary (along with any other dependencies) and securely deliver it to them
along with any other necessary but sensitive files such as a
[seeds](http://railscasts.com/episodes/179-seed-data?view=asciicast) file.
