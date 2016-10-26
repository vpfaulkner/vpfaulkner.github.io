---
layout: post
title: Introducing Rails Sandbox
---

Introducing [Rails Sandbox](http://rails-sandbox.com). This is an open source project currently in Beta whose source code can be found on Github at [https://github.com/vpfaulkner/rails_sandbox](https://github.com/vpfaulkner/rails_sandbox).

# Why?

Perhaps more than any other aspect in Rails, the commitment to "convention over configuration" to me has been its best design choice. I believe in it because it:

1. Allows you to benefit from the work and research of others
2. Allows you to get a new project up and running quickly
3. Allows novices to quickly learn the technology
4. Encourages simplicity by requiring you to continually ask, "Can I follow a convention here?"

That final point is often overlooked in my opinion because sticking to convention is harder than you would think. Oftentimes when you are solving a problem you focus first on what's _unconventional_ about the problem and go at it from a new angle. In my experience, however, with discipline and after reworking the problem through several iterations you can begin to reign it in with some conventional approach. For example, you might have difficulty applying unconventional behavior to an existing resource and realize that perhaps this is an indication that you need to create a new resource and, bam, you are back to conventions.

In addition to be harder to stick to, conventions can also be harder to simply remember. I have found myself Googling the same questions over and over again and finding the same StackOverflow answers before. "What should the routes file look like I want to make this resource singular and namespace it under this"" I'll even resort to the Rails generator to remind me of a lot of typical patterns in Rails. Finally, even if I've managed to get these conventions to stick I still remember being new to Rails and wanted to refer again and again to conventional code, let's say a controller file, to use a guardrails for my work.

That's why I started this project.

## Goals

There were a few goals I had in mind when starting this:

1. To build something that promoted Rails conventions
2. To deploy this app myself using Docker and DigitalOcean or AWS
3. To play around with Rails 5 and ActionCable

## The Stack

Here is what the app looks like from a technical perspective: a single page app built with Rails 5 primarily relying ActionCable, using **SemanticUI**, deployed to **DigitalOcean** using **Docker** (specifically, Docker, Docker-Compose, and Docker-Machine), and sitting behind an **Nginx** load balancer.

## Modeling Challenges

I wanted to get outside my comfort zone for a lot of this app. The first thing that was uncomfortable was the amount of frontend work. At Validic, most of my work has been in the back-end so I am constantly thinking through the database layer and issues like concurrency and data integrity. This app has no database (besides Redis for ActionCable) and, being a single-page app, required that I focus much more on the user-experience than the data. The natural "pull" of this app was much stronger to the views and the Javascript. In fact, I could have easily put all of the domain logic in Javascript or even gone with a Javascript framework. The core issue was that there was not as clear of an answer to what my core models were because the line between models and their representations was very gray. Ultimately I landed with modeling a Resource with attributes such as Name, Attributes, Namepspace, etc. and also modeling the core rails components including the controller, the model, the routes, etc. It was all quite meta and I even at one point considering taking a meta-programming approach where I would actually instantiate a Controller class and dynamically define the typical methods such as `show` or the strong params method. However, after a lot of thought I realized the typical approach of putting the code-representations of these components in the views was a lot more straightforward and extensible. The only metaprogramming I attempted was recreating the Rails routes block to take advantage of the built in routes drawer used in `rake routes`.

## Deployment

Another set of challenges were involved with deployment. I knew I wanted to deploy the hard way and get more experience there. But I didn't realize how much work was involved. I had to brush back up on Docker which seems to change every few months. Below are the Docker related files I ended up with:

```
# Dockerfile
FROM ruby:2.3.1
MAINTAINER Vance Faulkner | vpfaulkner@gmail.com

# Install essentials
RUN apt-get update -qq && apt-get install -y build-essential

# Install for nokogiri
RUN apt-get install -y libxml2-dev libxslt1-dev

# Install for capybara-webkit
RUN apt-get install -y libqt5webkit5-dev qt5-default xvfb

# Instal for a JS runtime
RUN apt-get install -y nodejs

# Setup home directory
ENV APP_HOME /rails_sandbox
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

# Install Gems
ADD Gemfile* $APP_HOME/
RUN bundle install

# Copy app
ADD . $APP_HOME

# Precompile Rails assets
RUN bundle exec rake assets:precompile

# Setup a volume so that nginx can read in the assets from
# the Rails Docker image without having to copy them to the Docker host.
VOLUME ["$APP_HOME/public"]
```

```
# Dockerfile-nginx
FROM nginx

# Install essentials
RUN apt-get update -qq && apt-get install -y build-essential

# establish where Nginx should look for files
ENV APP_HOME /rails_sandbox
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

# create log directory
RUN mkdir log

# copy our Nginx config template
COPY config/containers/nginx.conf /tmp/rails_sandbox.nginx

# substitute variable references in the Nginx config template for real values from the environment
# put the final config in its place
RUN envsubst '$APP_HOME' < /tmp/rails_sandbox.nginx > /etc/nginx/conf.d/default.conf

# Use the "exec" form of CMD so Nginx shuts down gracefully on SIGTERM (i.e. `docker stop`)
CMD [ "nginx", "-g", "daemon off;" ]
```

```
# docker-compose.yml

version: '2'

services:
  app:
    build: .
    command: bin/rails server --port 3000 --binding 0.0.0.0
    expose:
      - "3000"
    env_file:
      - '.env'
    logging:
      driver: json-file
      options:
        max-size: "30m"
        max-file: "10"

  redis:
    image: 'redis:3.2'
    command: "redis-server --requirepass ${REDIS_PASS}"
    volumes:
      - 'redis:/var/lib/redis/data'
    logging:
      driver: json-file
      options:
        max-size: "30m"
        max-file: "10"

  nginx:
    build:
      context: .
      dockerfile: Dockerfile-nginx
    ports:
      - "80:80"
    depends_on:
      - 'app'
    volumes_from:
      - app
    logging:
      driver: json-file
      options:
        max-size: "30m"
        max-file: "10"

volumes:
    redis:
    app:
```

As you can see, I have a somewhat typical Dockerfile for a Rails project relying on environment variables for secret management a la the Twelve Factor app. In addition to spinning up the Rails app, I also spin up Nginx and Redis required by ActionCable. There are a couple of other things in there including some log rotation logic built into Docker and setting up a volume for the Rails public folder in order for Nginx to serve those assets directly.

Lastly, I choose to use DigitalOcean for its simplicity over AWS although I would like to get more experience with AWS for personal projects in the future. I'm using an Ubuntu Droplet and deploying via Docker-Machine at the moment although will soon integrate a CI. This project required me to brush up on my Linux Sys. Admin skills, particularly involved with securing the app. For example, I had to setup a firewall with **ufw** as well as **fail2ban** for protection.

Setting up Nginx was also a learning experience, particularly getting it to work with ActionCable. Here is the config file:

```
# config/containers/nginx.conf
upstream puma {
  server app:3000;
}

server {
  listen 80 default deferred;
  server_name rails-sandbox.com;

  root   $APP_HOME/public;

  access_log $APP_HOME/log/nginx.access.log;
  error_log $APP_HOME/log/nginx.error.log;

  location ~ /\. {
   deny all;
  }

  location ~* ^.+\.(rb|log)$ {
   deny all;
  }

  location /assets {
    gzip_static on; # to serve pre-gzipped version
    expires max;
    add_header Cache-Control public;
  }

  location /cable {
    proxy_pass http://puma;
    proxy_http_version 1.1;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection "upgrade";
  }

  location / {
    try_files $uri @rails;
  }

  location @rails {
    proxy_set_header  X-Real-IP  $remote_addr;
    proxy_set_header  X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header Host $http_host;
    proxy_redirect off;
    proxy_pass http://puma;
  }

  error_page 500 502 503 504 /500.html;
  keepalive_timeout 10;
}
```

## Project Management

A final area that I learned a lot was simply project management. Simply put, I am not very good at practicing what I preach. On my blog and to my coworkers I talk a lot about an iterative approach. I love Agile and pride myself on taking seriously the importance of an MVP.

But taking that approach takes discipline and it's a lot easier to cheat at this if you are your own project manager. There were plenty of times where I justified going on major tangents, prematurely optimizing only to rip that code out later, because this was a side project where part of the goal was to simply learn some new technologies. Learning is great and I more than most am convinced of the importance of continually learning. But learning new technologies, just like everything else, needs to fall inline with the overall rhythm of improving through iterations. You will learn this new technology just like you will improve this code but that doesn't mean you should read the entire online guide before trying it out. Take an experimental, iterative approach, focused strongly on getting the behavior out of the technology before taking a second iteration to improve and get a broader understanding of how the technology works.

## Next Steps

Like I said, the project is in Beta. My biggest goals are: getting more feedback on what I have so far, implementing a CI like TravisCI or Codeship, and adding the ability to have multiple resources (I have found it particularly hard to follow conventions when there are multiple resources involved).

In the meantime please check it out, let me know any feedback you have (vpfaulkner@gmail.com), open a Issue, or submit a PR if you have an idea on how to improve it.
