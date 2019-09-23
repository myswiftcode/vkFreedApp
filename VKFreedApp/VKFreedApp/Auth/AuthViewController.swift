//
//  AuthViewController.swift
//  VKFreedApp
//
//  Created by V.Sergeev on 23/09/2019.
//  Copyright © 2019 v.sergeev.m@icloud.com. All rights reserved.
//  Button color #4F9CE0

import UIKit

class AuthViewController: UIViewController {

    private var authService: AuthService!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //authService = AuthService()
        authService = AppDelegate.shared().authService
    }

    @IBAction func signInTouch() {
        authService.wakeUpSession()
    }
}
