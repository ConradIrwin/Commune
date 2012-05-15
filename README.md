A little app that reimplements the web-interface from http://commune.jelzo.com/.

The plan was to use it to come up with a way to share code between iPad and iPhone apps, but I don't know how feasible that actually will end up being.

Installation in 50 easy steps!
------------------------------

Step 0 -> 10. Install latest OS X, iOS, Xcode (app store) and Ruby Motion (licence in the passwords file, download at  http://www.rubymotion.com/files/RubyMotion%20Installer.zip )

Step 11. Run `rake` to compile and build the app for the simulator.

Step 12 -> 46. Get a valid provisioning profile for `"com.rapportive.Commune"` (`"com.rapportive.*"` or just `"*"` will also work) that includes a developer key you have installed on your laptop and also the device you want to deploy it on.

Step 47. Remove my configuration from the Rakfile

Step 48. `rake device`

Step 49. (if step 12 didn't work) Add your configuration to the Rakefile

Step 50. `rake device`

TODO
----

* Split the layout code out of the controller
* Make the person chooser view a UIView subclass

* Add an awesome background texture
* Add an awesome animation for selection

* Robustify the HTTP call
