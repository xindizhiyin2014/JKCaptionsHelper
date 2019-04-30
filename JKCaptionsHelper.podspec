#
# Be sure to run `pod lib lint JKCaptionsHelper.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'JKCaptionsHelper'
  s.version          = '0.1.2'
  s.summary          = 'this is a tool to help develop to play srt file or srt data.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
    this is a tool to help develop to play srt file or srt data,it will update with the need
                       DESC

  s.homepage         = 'https://github.com/xindizhiyin2014/JKCaptionsHelper'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'xindizhiyin2014' => '929097264@qq.com' }
  s.source           = { :git => 'https://github.com/xindizhiyin2014/JKCaptionsHelper.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'
  s.swift_version = '5'

  s.source_files = 'JKCaptionsHelper/Classes/**/*'
  
  # s.resource_bundles = {
  #   'JKCaptionsHelper' => ['JKCaptionsHelper/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
