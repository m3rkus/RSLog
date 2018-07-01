
Pod::Spec.new do |s|

  s.name         = "RSLog"
  s.version      = "0.0.1"
  s.summary      = "Lightweight thread-safe logging framework implemented in Swift."
  s.description  = <<-DESC
  Features:
  - Emoji and text log levels for visual perception
  - Filename and line number logging
  - Function name logging
  - Three log levels: Info, Warning, Error
  - Works only for debug builds
                   DESC
  s.homepage     = "https://github.com/m3rkus/RSLog"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "m3rkus" => "roma4271@gmail.com" }
  s.platform = :ios
  s.ios.deployment_target = '8.0'
  s.swift_version = '4.1'
  s.source       = { :git => "https://github.com/m3rkus/RSLog.git", :tag => "#{s.version}" }
  s.source_files  = "RSLog", "RSLog/RSLog/**/*.{h,m,swift}"

end
