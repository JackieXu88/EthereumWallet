#
# Be sure to run `pod lib lint EthereumWallet.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#
pod_name = "EthereumWallet"

Pod::Spec.new do |s|
  s.name             = "#{pod_name}"
  s.version          = '0.1.0'
  s.summary          = 'A short description of #{pod_name}.'
  s.swift_version    = '5.0'
  s.cocoapods_version = '>= 1.11.0'
# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/jackie.xu/EthereumWallet'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'jackie.xu' => 'jackie.xu@planetart.cn' }
  s.source           = { :git => 'https://github.com/jackie.xu/EthereumWallet.git', :tag => "#{pod_name}-" + s.version.to_s  }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '13.0'
  s.static_framework = true

  s.source_files = 'EthereumWallet/Classes/**/*.swift'
  
   s.resource_bundles = {
     "#{pod_name}" => ["#{pod_name}/Assets/**/*"]
   }
   s.dependency 'web3.swift'
   s.dependency 'URLNavigator'
   s.dependency 'RxSwift'
   s.dependency 'RxCocoa'
   s.dependency 'SnapKit'
   s.dependency 'SVProgressHUD'
end
