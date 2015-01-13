---
layout: post
title: Instance Variables in Rails
comments: true
---
Transitioning to Rails from plain ole Ruby can be disorienting. Not only is
there a whole new structure for you to learn, existing syntax starts to take on
new meaning.

One of the more fundamental shifts is the role of instance variables in Rails.
As you remember from Ruby, instance variables begin with @ and are scoped to the
instance of the class in which they reside. 

{% highlight ruby %}
class Game

  def initialize
    @score = 0
  end

end
{% endhighlight %}

In Rails, this is still true but the underlying structure that is providing in
essence cheats this distinction. As you have or (will) learn, Rails is an MVC
framework meaning that the three core components of a Rails application is a
model, view and controller. For every incoming http request you can think of the
controller as acting as the central hub in which all of the necessary ingridients
for the response are put together. These ingridients are then passed on to the
view (assuming there is one) to be presented to the user.

Rails preforms this magic by passing on the instance variables from the
controller and passing them to the controller. This is what allows a Rails app,
for instance, to insert logic and state into the view portion of an app without
actually preforming that logic in the view. 

{% highlight ruby %}
class GamesController < ApplicationController
  def index
    @games = Game.all
  end
end
{% endhighlight %}
app/views/games/index.html
{% highlight erb %}
<h1>All Games</h1>
<table>
  <tr>
    <th>Game</th>
  </tr>
  <% @games.each do |game| %>
      <td><%= game.now %></td>
  </tr>
  <% end %>
</table>
{% endhighlight %}

The last piece of the puzzle is that these instance variables live and die
in a single http request. Think of each time the user navigates to a new page as
an encapsulated new state for your application. This state ends once the
request is done, including the state of these instance variables. Now of course
there have been techniques to emulate state on web apps of course such as
storing session variables etc; however, by thinking of these requests as
isolated states of your app then the role that instance variables play in Rails
will begin to make sense.
thinking in these 
