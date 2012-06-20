Pinboard Ruby (pinboard-rb) [![Build Status](https://secure.travis-ci.org/cslew/pinboard_rb.png?branch=master)](http://travis-ci.org/cslew/pinboard)
===========
Thin Ruby API Wrapper for Pinboard API V1

##NOTICE

This gem is not usable yet. There are a couple of things I've yet to do - error handling for invalid credentials, 429 too many requests, 'something is wrong' error. And most importantly, parsing the response.

##Installation
`gem install pinboard_rb` or add to Gemfile `gem 'pinboard_rb'`

##Usage
All the API methods listed in `http://pinboard.in/api` should work.

Add following to your .rb

    require 'pinboard'
    
Initialize

    pinboard = Pinboard.new('username', 'password')
    
###Examples

Get all posts (https://api.pinboard.in/v1/posts/get)

    pinboard.posts.get

Get all posts with parameters

    pinboard.posts.get.params({tag: 'tag_name'})
    
Get recent posts (https://api.pinboard.in/v1/posts/recent)

    pinboard.posts.recent({tag: 'tag_name'})

Get recent posts with parameters

    pinboard.posts.recent({count: 1})


