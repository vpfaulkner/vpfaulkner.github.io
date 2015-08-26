---
layout: post
title: RSpec Basics
---
If you are going to embrace testing in Ruby you need to know RSpec, even if you prefer another testing tool such as MiniTest. RSpec is used widely and at many places testing is such a core part of the development process that knowing the basics of RSpec is essential.

That being said, RSpec provides a DSL (domain specific language) that is pretty extensive. The first thing you'll notice if seeing an RSpec file for the first time is that everything seems to be divided into separate blocks of code starting with some kind of describe block:

{% highlight ruby %}
describe #my_method do
  # some tests
end
{% endhighlight %}

So let's start with the basics: the describe block here is not a test but a place to explicitly state what you are testing. Think about it as about it as a bucket of behavior for you to group tests in.

You might ask what the # is for. This is doing nothing special or behind the scenes; it is simply ruby convention for signifying an instance method. If you were testing a class method you could use a . instead.

Secondly, it is common to have describe blocks nested within each other:

{% highlight ruby %}
describe MyClass do
  describe #my_method do
    # some tests
  end
end
{% endhighlight %}

Again, no tests yet, just a useful organizational framework to hold your tests.

Within a describe block you will often see a context block:

{% highlight ruby %}
describe Song do
  describe #download do

    context 'when logged in' do
      # some tests
    end

    context 'when not logged in' do
      # some tests
    end

  end
end
{% endhighlight %}

Oftentimes desired behavior changes with context--that's why we have context blocks. Context blocks are useful because we need to create the right context in order to test specific behavior we have to do some setup.

{% highlight ruby %}
describe Song do
  describe #download do

    context 'when logged in' do
      before do
        @user = User.new("Joe")
        @user.login
        @song = Song.new
      end

      # some tests

    end

    context 'when not logged in' do
      before do
        @user = User.new("Joe")
        @song = Song.new
      end

      # some tests

    end

  end
end
{% endhighlight %}

As you can see here, we setup the test with another before block. Before blocks run before each test; this may seem silly here because we don't have a lot of tests or setup but they quickly become useful as you add lots of tests that require the same context. The context for our to-be-written tests will be slightly different as written in the context block: the user will be logged in for one context and not logged in for another.

Finally, let's add the actual tests:

{% highlight ruby %}
describe Song do
  describe #download do

    context 'when logged in' do
      before do
        @user = User.new("Joe")
        @user.login
        @song = Song.new
      end

      it 'downloads song' do
        expect(@song.download).to change{@user.songs}.by(1)
      end

    end

    context 'when not logged in' do
      before do
        @user = User.new("Joe")
        @song = Song.new
      end

      it 'raises an error' do
        expect(@song.download).to raise_error(LoginError)
      end

    end

  end
end
{% endhighlight %}

The it block here is where the actual tests are. We are using the expect syntax over the older should syntax but both are valid. You can find ways to test a lot of different behavior which we will not go into here, but, as you can see, the expected behavior should be highlighted in the it block and appropriate for the given context.

There is a lot to learn with RSpec but with that learning curve comes flexibility to create very effective tests. Hopefully with these fundamental concepts you begin to understand the basics of what's going on and easily incorporate TDD into your workflow.
