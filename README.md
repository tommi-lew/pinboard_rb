Pinboard Ruby (pinboard-rb) [![Build Status](https://secure.travis-ci.org/cslew/pinboard_rb.png?branch=master)](http://travis-ci.org/cslew/pinboard)
===========
Thin Ruby API Wrapper for Pinboard API V1

##NOTICE

This gem is not usable yet. There are a couple of things I've yet to do - error handling for 429 too many requests, 'something is wrong' error.

##Installation
`gem install pinboard_rb` or add to Gemfile `gem 'pinboard_rb'`

##Usage
I'm working towards getting all the API methods listed in `http://pinboard.in/api` to work.

Add following to your .rb

    require 'pinboard'

Initialize

    pinboard = Pinboard.new('username', 'password')

###Examples
Most requests should return a hash.
However, if the username and password are invalid, the gem will raise an `InvalidCredentialsError`.

Get all posts (https://api.pinboard.in/v1/posts/get)

    pinboard.posts.req

Get all posts with parameters

    pinboard.posts.params({tag: 'tag_name'}).req

Get recent posts (https://api.pinboard.in/v1/posts/recent)

    pinboard.posts.recent.req

Get recent posts with parameters

    pinboard.posts.recent.params({count: 1}).req
    
Reset method calls without doing an actual request.

    pinboard.clear


