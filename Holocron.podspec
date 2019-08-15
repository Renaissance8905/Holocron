Pod::Spec.new do |s|

s.platform = :ios
s.ios.deployment_target = '12.0'
s.name = "Holocron"
s.summary = "Holocron is a Swift Library for accessing the Star Wars API."
s.requires_arc = true

s.version = "0.4.0"

s.license = { :type => "MIT", :file => "LICENSE" }

s.author = { "Chris Spradling" => "cjspradling@gmail.com" }

s.homepage = "https://github.com/Renaissance8905/Holocron"

s.source = { :git => "https://github.com/Renaissance8905/Holocron.git", 
             :tag => "#{s.version}" }

s.framework = "Foundation"

s.source_files = "Sources/**/*.{swift}"

s.swift_version = "5.1"

end
