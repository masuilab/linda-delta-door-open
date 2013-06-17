Linda Delta Door Open
=====================
open door-lock with RocketIO::Linda and Servo-motor on Arduino

* https://github.com/masuilab/linda-delta-door-open
* watch tuple ["door", "open"] and open door
* then write tuple ["door", "open", "success"]


Video
-----
http://www.youtube.com/watch?v=mHJhTMvtmPQ


Dependencies
------------
- [Servo Motor](http://akizukidenshi.com/catalog/g/gM-01794/)
- [Arduino Firmata](https://github.com/shokai/arduino_firmata)
- Ruby 1.8.7 ~ 2.0.0
- [LindaBase](https://github.com/shokai/linda-base)


Install Dependencies
--------------------

Install Rubygems

    % gem install bundler foreman
    % bundle install


Setup Arduino
-------------

Install Arduino Firmata v2.2

    Arduino IDE -> [File] -> [Examples] -> [Firmata] -> [StandardFirmata]

put servo motor

Run
---

set ENV var "LINDA_BASE", "LINDA_SPACE" and "ARDUINO"

    % export ARDUINO=/dev/tty.usb-device-name
    % export LINDA_BASE=http://linda.example.com
    % export LINDA_SPACE=test
    % bundle exec ruby linda-door-phidgets-servo.rb


oneline

    % LINDA_BASE=http://linda.example.com LINDA_SPACE=test  bundle exec ruby linda-delta-door-open.rb


Install as Service
------------------

for launchd (Mac OSX)

    % sudo foreman export launchd /Library/LaunchDaemons/ --app linda-delta-door -u `whoami`
    % sudo launchctl load -w /Library/LaunchDaemons/linda-delta-door-open-1.plist


for upstart (Ubuntu)

    % sudo foreman export upstart /etc/init/ --app linda-delta-door -d `pwd` -u `whoami`
    % sudo service linda-delta-door start
