//
//  OAuthService.swift
//  GithubzToGo
//
//  Created by Brandon Roberts on 4/15/15.
//  Copyright (c) 2015 BR World. All rights reserved.
//

import Foundation

class OAuthService {
  
  let userDefaultGithubTokenKey = "githubToken"
  
  func fetchGithubToken(completionHandler: (tokenAuthenticated: Bool)->Void) {
    
    if self.isAuthenticated() {
      completionHandler(tokenAuthenticated: true)
    } else {
      //TODO: send request for token
      //TODO: send completion handler
    }
    
  }
  
  func isAuthenticated() -> Bool {
    if NSUserDefaults.standardUserDefaults().objectForKey(self.userDefaultGithubTokenKey) != nil {
      return true
    } else {return false}
  }
  
  func setGithubAuthenticationToken(token: String?) {
    if token != nil {
      NSUserDefaults.standardUserDefaults().setObject(token, forKey: self.userDefaultGithubTokenKey)
    } else {
      NSUserDefaults.standardUserDefaults().removeObjectForKey(self.userDefaultGithubTokenKey)
    }
    
    NSUserDefaults.standardUserDefaults().synchronize()
  }
  
}
