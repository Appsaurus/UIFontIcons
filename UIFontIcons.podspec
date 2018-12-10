Pod::Spec.new do |s|
  s.name             = "UIFontIcons"
  s.summary          = "A short description of UIFontIcons."
  s.version          = "0.0.1"
  s.homepage         = "github.com/brian/UIFontIcons"
  s.license          = 'MIT'
  s.author           = { "Brian Strobach" => "brian@appsaurus.io" }
  s.source           = {
    :git => "https://github.com/appsaurus/UIFontIcons.git",
    :tag => s.version.to_s
  }
  s.social_media_url = 'https://twitter.com/brian'

  s.swift_version = '4.2'
  s.requires_arc = true

  s.ios.deployment_target = '9.0'
  s.osx.deployment_target = '10.9'
  s.tvos.deployment_target = '9.2'
  s.watchos.deployment_target = "3.0"

  s.default_subspec = 'Core'

  s.subspec 'Core' do |c|
    c.ios.source_files = 'Sources/{iOS,Shared}/**/*.swift'
    c.tvos.source_files = 'Sources/{iOS,tvOS,Shared}/**/*.swift'
    c.osx.source_files = 'Sources/{macOS,Shared}/**/*.swift'
    c.watchos.source_files = 'Sources/{watchOS,Shared}/**/*.swift'
    c.resource = 'Sources/Shared/FontIconGenerator.py'
  end
  
  s.subspec 'MaterialIcons' do |m|
    m.dependency 'UIFontIcons/Core'
    m.source_files = 'Sources/Fonts/MaterialIcons/MaterialIcons.swift'
  end

  s.subspec 'Feather' do |f|
    f.dependency 'UIFontIcons/Core'
    f.source_files = 'Sources/Fonts/Feather/Feather.swift'
  end

  s.subspec 'FontAwesome' do |f|
    f.dependency 'UIFontIcons/Core'
    f.source_files = 'Sources/Fonts/FontAwesome/FontAwesome.swift'
  end

  s.ios.frameworks = 'UIKit', 'Foundation'
  # s.osx.frameworks = 'Cocoa', 'Foundation'

end
