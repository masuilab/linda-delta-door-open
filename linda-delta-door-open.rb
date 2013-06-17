#!/usr/bin/env ruby
require 'rubygems'
require 'eventmachine'
require 'em-rocketio-linda-client'
require 'arduino_firmata'
$stdout.sync = true

EM::run do
  arduino = ArduinoFirmata.connect ENV["ARDUINO"], :eventmachine => true

  url   = ENV["LINDA_BASE"]  || ARGV.shift || "http://localhost:5000"
  space = ENV["LINDA_SPACE"] || "test"
  puts "connecting.. #{url}"
  linda = EM::RocketIO::Linda::Client.new url
  ts = linda.tuplespace[space]

  linda.io.on :connect do  ## RocketIO's "connect" event
    puts "connect!! <#{linda.io.session}> (#{linda.io.type})"
    last_at = Time.now
    ts.watch ["door", "open"] do |tuple|
      p tuple
      next if tuple.size != 2
      next if last_at + 5 > Time.now
      arduino.servo_write 9, 0
      sleep 2
      arduino.servo_write 9, 180
      tuple << "success"
      ts.write tuple
      last_at = Time.now
    end
  end

  linda.io.on :disconnect do
    puts "RocketIO disconnected.."
  end
end
