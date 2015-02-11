---
layout: post
title: What is Heroku Exactly?
comments: true
---

We know your secret: you're a very new web developer still trying to get down the basics and you don't want to admit to anyone that you're still not exactly sure what Heroku is and why you need it. Your secret is safe with us but, yes, this would be a good time to get this figured out.

At some point or another you might have wondered how you are going to take what you've been working on, probably locally on your Macbook laptop, and expose it to the outside world? When you run rails server for instance you are able to see the fruit of your work by navigating a browser to local host, but if you want to show it so someone else you have no idea. What you need is something else besides your own computer to host your application and make it available over the web.

What Heroku is might be called a Platform as a Service. The idea of a platform probably makes sense because you need your application to stand on something. What you may not realize at first, however, is what needs to go into that platform to allow it to run the same way as on your conputer. This introduces the idea of your "stack" or the componenets and technologies that sit ontop of each other to support your program. For example, what operating system are you running locally? Is it, or something close enough, going to be availble to the platform that hosts your program? How about the same database or language or even specific version of that language? The good and bad thing about being able to easily spin up an application today and run it locally is that you don't know what all is happening in the background and thearfore don't realize how much work it would be to set that up somewhere else. 

That is where a service like Heroku comes in. Heroku takes care of most of that work for you and, if you are in the open source community, works well with a lot of common tools. First, it works well with Git allowing you to deploy almost instantly, is extremely common in the Rails community so there is plenty of help available, and makes scalling your easy. Heroku also provides a free Dyno (think computing power for your app) which means for many simple apps you can deploy it to the web for nothing.

Heroku certainly has some downsides, most notably its cost as you scale, but it is an easy way to begin deploying your app, is a extremely valuable technology to know because of its ubiquity, and is free to get started. Finally if you are getting started there are plenty of resources to help you get up in running including an excellent set of [tutorials](https://devcenter.heroku.com/articles/getting-started-with-rails4) for most of the more popular langagues.
