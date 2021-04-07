#
#  Be sure to run `pod spec lint ZHTools.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#
Pod::Spec.new do |s|
  s.name         = "ZHTools"
  s.version      = "0.0.1"
 s.license = { :type => "MIT", :file => "LICENSE" }
  s.summary      = "tools browser for ios."
  s.homepage     = "https://github.com/liuzhenhan/LZHTools"
  s.author             = { "liuzhenhan" => "497108685@qq.com" }
  s.source       = { :git => "https://github.com/liuzhenhan/LZHTools.git", :tag => s.version }
  s.platform     = :ios, "13.0"
  s.source_files = "LZTool/*.{swift}"

 end
