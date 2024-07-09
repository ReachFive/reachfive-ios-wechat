<p align="center">
 <img src="https://www.reachfive.com/hubfs/5399904/Logo-ReachFive.svg" alt="Reach5 Logo" width="700" height="192"/>
</p>

[![CircleCI](https://circleci.com/gh/ReachFive/identity-ios-sdk/tree/master.svg?style=svg)](https://circleci.com/gh/ReachFive/identity-ios-sdk/tree/master)
[![Download](https://img.shields.io/cocoapods/v/IdentitySdkCore.svg?style=flat) ](https://cocoapods.org/pods/IdentitySdkCore)

# ReachFive Identity iOS SDK

## Cocoapods pods

- [IdentitySdkCore](https://cocoapods.org/pods/IdentitySdkCore)
- [IdentitySdkFacebook](https://cocoapods.org/pods/IdentitySdkFacebook)
- [IdentitySdkGoogle](https://cocoapods.org/pods/IdentitySdkGoogle)
- [IdentitySdkWeChat](https://cocoapods.org/pods/IdentitySdkWeChat)

## Installation

Refer to the [public documentation](https://developer.reachfive.com/sdk-ios/index.html) to install the SDKs and to initialize your ReachFive client.

The basics are:
- Add this SDK to your project in your Cocoapods Podfile: 


    pod 'IdentitySdkCore'

- Configure the SDK:


    let reachfive: ReachFive = ReachFive(sdkConfig: SdkConfig(domain: "DOMAIN", clientId: "CLIENT_ID"))

- Initialize the SDK using this method (makes a network call) to be called inside the corresponding method of `UIApplicationDelegate`


    reachfive.application(application, didFinishLaunchingWithOptions: launchOptions)


## Demo application

In addition to the libraries, we provide in the `Sandbox` directory a simple iOS application which integrates the ReachFive SDKs.

To configure this demo application and learn how to use this SDK, refer to [contributing](CONTRIBUTING.md#running-the-demo-application)

## Documentation

You'll find the documentation of the methods exposed on https://developer.reachfive.com/sdk-ios/index.html.

## Changelog

Please refer to [changelog](CHANGELOG.md) to see the descriptions of each release.

## Development

Please refer to [contributing](CONTRIBUTING.md#development)

## License

[MIT](LICENSE) © [ReachFive](https://reachfive.co/)
