$:.unshift("/Library/RubyMotion/lib")
require 'motion/project'

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'Commune'
  app.identifier = 'com.rapportive.Commune'
  app.device_family = :ipad
  app.provisioning_profile = "/Users/cirwin/Library/MobileDevice/Provisioning Profiles/9A88F26F-4889-4AFD-9847-0D2405ABE28E.mobileprovision"
  app.codesign_certificate = "iPhone Developer: Conrad Vohra (G444LA5FCL)"
  app.seed_id = "8A7KL9F8AZ"

  dirs = %w(lib core_extensions style app/helpers app/views app)

  app.files = dirs.map{ |dir|
                Dir.glob(File.join(app.project_dir, "#{dir}/**/*.rb"))
              }.flatten
end
