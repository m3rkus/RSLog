
Pod::Spec.new do |s|

  s.name = "RSLog"
  s.version = "0.1.0"
  s.summary = "Lightweight thread-safe logging framework implemented in Swift (OSLog supported)."
  s.description = <<-DESC
  Features:
  - OSLog support
  - Emoji and text log levels for visual perception
  - Filename and line number logging
  - Function name logging
  - Three log levels: Info, Debug, Error
  - Works only for debug builds
                   DESC
  s.homepage = "https://github.com/m3rkus/RSLog"
  s.license = { :type => "MIT", :file => "LICENSE" }
  s.author = { "m3rkus" => "roma4271@gmail.com" }
  s.platform = :ios
  s.ios.deployment_target = '8.0'
  s.swift_version = '5'
  s.source = { :git => "https://github.com/m3rkus/RSLog.git", :tag => "#{s.version}" }
  s.source_files  = "RSLog", "RSLog/RSLog/**/*.{h,m,swift}"

end
