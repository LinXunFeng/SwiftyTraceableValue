#
# Be sure to run `pod lib lint SwiftyTraceableValue.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SwiftyTraceableValue'
  s.version          = '0.0.1'
  s.summary          = 'A short description of SwiftyTraceableValue.'
  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/LinXunFeng/SwiftyTraceableValue'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'LinXunFeng' => 'linxunfeng@yeah.net' }
  s.source           = { :git => 'https://github.com/LinXunFeng/SwiftyTraceableValue.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/xunfenghellolo'

  s.ios.deployment_target = '9.0'
  
  s.subspec "Base" do |t|
      t.source_files  = 'SwiftyTraceableValue/Classes/**/*'
  end
  
  s.subspec 'Rx' do |t|
      t.source_files = 'SwiftyTraceableValue/Classes/Rx/**/*.{swift}'
      t.dependency 'RxSwift', '>= 6'
      t.dependency "SwiftyTraceableValue/Base"
  end
  
end
