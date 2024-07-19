require_relative './version'

Pod::Spec.new do |spec|
  spec.name                  = "IdentitySdkWeChat"
  spec.version               = $VERSION
  spec.summary               = "ReachFive IdentitySdkWeChat"
  spec.description           = <<-DESC
      ReachFive Identity Sdk WeChat
  DESC
  spec.homepage              = "https://github.com/ReachFive/reachfive-ios-wechat"
  spec.license               = { :type => "MIT", :file => "LICENSE" }
  spec.author                = "ReachFive"
  spec.authors               = { "François" => "francois.devemy@reach5.co", "Pierre" => "pierre.bar@reach5.co" }
  spec.swift_versions        = ["5"]
  spec.source                = { :git => "https://github.com/ReachFive/reachfive-ios-wechat.git", :tag => "#{spec.version}" }
  spec.source_files          = "IdentitySdkWeChat/**/*.*"
  spec.platform              = :ios
  spec.ios.deployment_target = $IOS_DEPLOYMENT_TARGET

  spec.static_framework = true

  spec.dependency 'IdentitySdkCore'
  spec.dependency 'WechatSwiftPod', '~> 1'

end
