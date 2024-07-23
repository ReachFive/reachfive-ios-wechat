require_relative './version'

Pod::Spec.new do |spec|
  spec.name                  = "Reach5WeChat"
  spec.version               = $VERSION
  spec.summary               = "Reachfive Identity SDK for WeChat Login"
  spec.description           = <<-DESC
      Reachfive Identity SDK for iOS integrating with WeChat Login
  DESC
  spec.homepage              = "https://github.com/ReachFive/reachfive-ios-wechat"
  spec.license               = { :type => "MIT", :file => "LICENSE" }
  spec.author                = "ReachFive"
  spec.authors               = { "François" => "francois.devemy@reach5.co", "Pierre" => "pierre.bar@reach5.co" }
  spec.swift_versions        = ["5"]
  spec.source                = { :git => "https://github.com/ReachFive/reachfive-ios-wechat.git", :tag => "#{spec.version}" }
  spec.source_files          = "IdentitySdkWeChat/Classes/**/*.*"
  spec.platform              = :ios
  spec.ios.deployment_target = $IOS_DEPLOYMENT_TARGET
  spec.resource_bundle = {
    'Reach5' => ['IdentitySdkWeChat/PrivacyInfo.xcprivacy']
  }

  spec.static_framework = true

  spec.dependency 'Reach5', '7.0.0.beta.2'
  spec.dependency 'WechatSwiftPod', '~> 1'

end
