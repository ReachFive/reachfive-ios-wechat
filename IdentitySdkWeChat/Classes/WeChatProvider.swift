import Foundation
import IdentitySdkCore
import BrightFutures
import WechatSwiftPod

public class WeChatProvider: ProviderCreator {
    public static var NAME: String = "wechat"
    
    public var name: String = NAME
    
    public init() {}
    
    public func create(
        sdkConfig: SdkConfig,
        providerConfig: ProviderConfig,
        reachFiveApi: ReachFiveApi,
        clientConfigResponse: ClientConfigResponse
    ) -> Provider {
        ConfiguredWeChatProvider(
            sdkConfig: sdkConfig,
            providerConfig: providerConfig,
            reachFiveApi: reachFiveApi,
            clientConfigResponse: clientConfigResponse
        )
    }
}

public class ConfiguredWeChatProvider: NSObject, Provider {
    public var name: String = WeChatProvider.NAME
    
    var sdkConfig: SdkConfig
    var providerConfig: ProviderConfig
    var reachFiveApi: ReachFiveApi
    var clientConfigResponse: ClientConfigResponse
    var state: String
    var origin: String
    var scope: [String]?
    var promise: Promise<AuthToken, ReachFiveError>
    
    public init(sdkConfig: SdkConfig, providerConfig: ProviderConfig, reachFiveApi: ReachFiveApi, clientConfigResponse: ClientConfigResponse) {
        self.sdkConfig = sdkConfig
        self.providerConfig = providerConfig
        self.reachFiveApi = reachFiveApi
        self.clientConfigResponse = clientConfigResponse
        self.state = "state"
        self.origin = ""
        self.promise = Promise()
    }
    
    public func login(
        scope: [String]?,
        origin: String,
        viewController: UIViewController?
    ) -> Future<AuthToken, ReachFiveError> {
        promise = Promise()
        guard WXApi.isWXAppInstalled() else {
            promise.failure(.RequestError(apiError: ApiError(errorUserMsg: "WeChat is not installed", errorMessageKey: "error.provider.wechat.notInstalled")))
            return promise.future
        }
        
        self.origin = origin
        self.scope = scope
        
        state = Pkce.generate().codeVerifier
        
        let req = SendAuthReq()
        req.scope = "snsapi_userinfo"
        req.state = state
        WXApi.send(req)
        
        return promise.future
    }
    
    public func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any]) -> Bool {
        return WXApi.handleOpen(url, delegate: self)
    }
    
    public func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return true
    }
    
    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if let clientId = providerConfig.clientId, let link = providerConfig.universalLink {
            let registerApp = WXApi.registerApp(clientId, universalLink: link)
        }
        
        return true
    }
    
    public func applicationDidBecomeActive(_ application: UIApplication) {
    }
    
    public func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        return WXApi.handleOpenUniversalLink(userActivity, delegate: self)
    }
    
    public func logout() -> Future<(), ReachFiveError> {
        return Future(value: ())
    }
    
    public override var description: String {
        "Provider: \(name)"
    }
}

extension ConfiguredWeChatProvider: WXApiDelegate {
    open func onResp(_ resp: BaseResp) {
        if let authResp = resp as? SendAuthResp {
            guard let code = authResp.code else {
                self.promise.failure(.TechnicalError(reason: "No code delivered by WeChat"))
                return
            }
            guard authResp.state == self.state else {
                self.promise.failure(.TechnicalError(reason: "Invalid state"))
                return
            }
            
            let loginProviderRequest = LoginProviderRequest(
                provider: "\(self.providerConfig.provider):ios",
                providerToken: nil,
                code: code,
                origin: origin,
                clientId: self.sdkConfig.clientId,
                responseType: "token",
                scope: scope?.joined(separator: " ") ?? self.clientConfigResponse.scope
            )
            self.promise.completeWith(
                self.reachFiveApi
                    .loginWithProvider(loginProviderRequest: loginProviderRequest)
                    .flatMap({ AuthToken.fromOpenIdTokenResponseFuture($0) })
            )
        }
    }
}
