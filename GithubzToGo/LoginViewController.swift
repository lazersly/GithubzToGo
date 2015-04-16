//
//  LoginViewController.swift
//  GithubzToGo
//
//  Created by Brandon Roberts on 4/15/15.
//  Copyright (c) 2015 BR World. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  @IBAction func loginButtonPressed(sender: AnyObject) {
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    appDelegate.oAuthService.fetchGithubToken()
    
  }
  
}
