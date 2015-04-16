//
//  LoginViewController.swift
//  GithubzToGo
//
//  Created by Brandon Roberts on 4/15/15.
//  Copyright (c) 2015 BR World. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
  
  let transitionDuration = 0.5
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    
  }
  
  
  @IBAction func loginButtonPressed(sender: AnyObject) {
    
    //TODO: Use OAuthService to retrieve the token
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let delegateOAuthService = appDelegate.oAuthService
    
    delegateOAuthService.fetchGithubToken { [weak self] (tokenAuthenticated) -> Void in
      if self != nil {
        if tokenAuthenticated == true {
          let window = appDelegate.window
          let navController = self?.storyboard?.instantiateViewControllerWithIdentifier("MainMenuNav") as! UINavigationController
          
          UIView.transitionFromView(self!.view, toView: navController.view, duration: self!.transitionDuration, options: UIViewAnimationOptions.TransitionFlipFromRight, completion: { (completed) -> Void in
            window?.rootViewController = navController
          })
        } else {
          // Present alert saying Github wasn't authenticated
        }
      }
    }
  }
  
}
