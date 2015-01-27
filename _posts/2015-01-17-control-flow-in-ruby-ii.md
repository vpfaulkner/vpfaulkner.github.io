---
layout: post
title: Control Flow in Ruby Pt. II
comments: true
---

This is a follow up on an [earlier post](/2015/01/26/control-flow-in-ruby/) on
control flow in Ruby.

##If you must repeatedly loop over code, use While or Until

Introducing with the condition for a code loop upfront is much more readable
than having a break statement buried in a loop statement.

{% highlight ruby %}
# Bad
number = 0
sum = 0
loop do
  number +=1
  sum += number
  break if sum >= 100
end

# Good
number = 0
sum = 0
while number < 100
  number += 1
  sum += number
end
{% endhighlight %}

Avoid the for method which is even less readable

##Use collect for building a new array from a collection

I used to create a blank array and then fill it with the each method. Now I
prefer the collect method:

{% highlight ruby %}
# Bad
standardized_scores = []
percentage_scores.each do |s|
  standardized_score = s * 100
  scores.push(standardize_score)
end

# Good
standardized_scores = students.collect do |s|
  s * 100
end
{% endhighlight %}

##Use each or select for iterating through a hash
 
The each method is very readable and gets the job done most of the time for
iterating over a hash. 

{% highlight ruby %}
students_birthdays = { "jack" => "July 12", "jill" => "November 1", "joe" => "March 12" }
students_birthdays.each do |student, birthday|
  puts "#{student}'s birthday is #{birthday}"
end
{% endhighlight %}

For more complex cases, feel free to use select. This returns a hash consisting
of entries for which the block returns true.

{% highlight ruby %}
students_ages = { "jack" => 10, "jill" => 11, "joe" => 12}
older_students = students_ages.select do |s, a|
  s >= 11
end
{% endhighlight %}
