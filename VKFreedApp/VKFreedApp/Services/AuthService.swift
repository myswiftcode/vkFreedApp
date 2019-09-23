//
//  AuthService.swift
//  VKFreedApp
//
//  Created by V.Sergeev on 23/09/2019.
//  Copyright © 2019 v.sergeev.m@icloud.com. All rights reserved.
//

import Foundation
import VKSdkFramework

protocol AuthServiceDelegate {
    func authServiceShouldShow(_ viewController: UIViewController)
    // SignIn
    func authServiceSignIn()
    // Fail
    func authServiceDidSignInFail()
}

// Модификатор класса, нет наследования и т.д...
final class AuthService: NSObject, VKSdkDelegate, VKSdkUIDelegate {
    
    // App Id
    private let appId = "7144696"
    private let vkSdk: VKSdk
    
    var myDelegate: AuthServiceDelegate?
    
    override init() {
        
        vkSdk = VKSdk.initialize(withAppId: appId)
        super.init()
        print("VKSdk.init")
        // Протоколы
        vkSdk.register(self)
        vkSdk.uiDelegate = self
    }
    
    func wakeUpSession() {
        let scope = ["Offile"]
        
        VKSdk.wakeUpSession(scope) { (state, Error) in
            if state == VKAuthorizationState.authorized {
                print("VKAuthorizationState.authorized")
                self.myDelegate?.authServiceSignIn()
            } else if state == VKAuthorizationState.initialized {
                print("VKAuthorizationState.initialized")
                VKSdk.authorize(scope)
            } else {
                print("auth problem, state \(state) error \(String(describing: Error))")
                self.myDelegate?.authServiceDidSignInFail()
            }
        }
    }
    
    // Методы
    // MARK: VKSdkDelegate
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        print(#function)
        // fix bug done ->
        if result.token != nil {
            myDelegate?.authServiceSignIn()
        }
    }
    
    func vkSdkUserAuthorizationFailed() {
        print(#function)
    }
    
    // MARK: VKSdkUIDelegate
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        print(#function)
        myDelegate?.authServiceShouldShow(controller)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print(#function)
    }
}
