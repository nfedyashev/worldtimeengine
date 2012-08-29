[![Build Status](https://secure.travis-ci.org/nfedyashev/worldtimeengine.png?branch=master)](http://travis-ci.org/nfedyashev/worldtimeengine)

#  The WorldTimeEngine.com Ruby gem

Convert any IP address to current local time.

http://worldtimeengine.com/api/ip

### Installation

Install the gem:

``` bash
$ gem install worldtimeengine
```

Add it to your Gemfile:

``` ruby
gem 'worldtimeengine'
```

### Configuration

    WorldTimeEngine.configure do |config|
      config.api_key = YOUR_API_KEY
    end


### Synopsis

    response = WorldTimeEngine.api('193.174.32.100')

    response.version
    => '1.1'
    response.location.region
    => 'Germany'
    response.location.latitude
    => 53.25
    response.location.longitude
    => 10.4
    
    response.time.utc
    => 2012-08-25 14:10:29 UTC
    response.time.local
    => 2012-08-25 16:10:29 +0200
    
    response.time.zone.has_dst
    => true
    response.time.zone.current.abbreviation
    => "CEST"
    response.time.zone.current.description
    => "Central European Summer Time"
    response.time.zone.current.utc_offset
    => '+02:00'
    response.time.zone.current.is_dst
    => true
    response.time.zone.current.effective_until
    => 2012-10-28 03:00:00 +0200
    
    response.time.zone.next.abbreviation
    => 'CET'
    response.time.zone.next.description
    => "Central European Time"
    response.time.zone.next.utc_offset
    => "+01:00"
    response.time.zone.next.is_dst
    => false
    response.time.zone.next.effective_until
    => 2013-03-31 02:00:00 +0100


## Copyright
Copyright (c) 2012 Nikita Fedyashev.
See [LICENSE][] for details.

[license]: https://github.com/nfedyashev/worldtimeengine/blob/master/LICENSE.md
