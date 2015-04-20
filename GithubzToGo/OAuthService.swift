//
//  OAuthService.swift
//  GithubzToGo
//
//  Created by Brandon Roberts on 4/15/15.
//  Copyright (c) 2015 BR World. All rights reserved.
//

import UIKit

class OAuthService {
  
  let userDefaultGithubTokenKey = "githubToken"
  let initialRequestURL = "https://github.com/login/oauth/authorize?client_id=\(kGithubClientID)&scope=user,public_repo"
  
  func fetchGithubToken() {
    
    UIApplication.sharedApplication().openURL(NSURL(string: (self.initialRequestURL))!)
    
  }
  
  func handleRedirect(url: NSURL, completionHandler:(tokenGranted: Bool)->Void) {
    let code = url.query
    let url = "https://github.com/login/oauth/access_token"
    let query = "\(code!)&client_id=\(kGithubClientID)&client_secret=\(kGithubClientSecret)"
    var error : NSError?
    
    let queryData = query.dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion: true)

    let request = NSMutableURLRequest(URL: NSURL(string: url)!)
    request.HTTPMethod = "POST"
    request.HTTPBody = queryData
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    request.setValue("\(queryData!.length)", forHTTPHeaderField: "Content-Length")
    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    
    let dataTask = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
      if error == nil {
        let httpResponse = response as! NSHTTPURLResponse
        if httpResponse.statusCode == 200 {
          if let responseInfo = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.allZeros, error: nil) as? [String:AnyObject] {
            let token = responseInfo["access_token"] as! String
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
              self.setGithubAuthenticationToken(token)
            })
          }
        }
      } else {
        // There was an error to be handled
      }
      
      NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
        completionHandler(tokenGranted: self.isAuthenticated())
      })

    })
    dataTask.resume()
  }
  
  func isAuthenticated() -> Bool {
    if NSUserDefaults.standardUserDefaults().objectForKey(self.userDefaultGithubTokenKey) != nil {
      return true
    } else {return false}
  }
  
  func githubAuthenticationToken() -> String? {
    if let token = NSUserDefaults.standardUserDefaults().objectForKey(self.userDefaultGithubTokenKey) as? String {
//      println("Github Token: \(token)")
      return token
    } else {
      println("No Github Token")
      return nil
    }
  }
  
  private func setGithubAuthenticationToken(token: String?) {
    println(token)
    if token != nil {
      NSUserDefaults.standardUserDefaults().setObject(token, forKey: self.userDefaultGithubTokenKey)
    } else {
      NSUserDefaults.standardUserDefaults().removeObjectForKey(self.userDefaultGithubTokenKey)
    }
    
    NSUserDefaults.standardUserDefaults().synchronize()
  }
  
}
