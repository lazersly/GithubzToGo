//
//  GithubService.swift
//  GithubzToGo
//
//  Created by Brandon Roberts on 4/13/15.
//  Copyright (c) 2015 BR World. All rights reserved.
//

import UIKit

class GithubService {
  
  static let sharedInstance : GithubService = GithubService()
  
  let githubRepoURLString = "https://api.github.com/search/repositories"
  let githubUsersURLString = "https://api.github.com/search/users"
//  let localHost = "http://127.0.0.1:3000"
  
  func fetchReposWithSearchTerm(searchDescription : String, completionHandler: ([Repository]?, NSError?)->Void) {
    
    let fullURLString = self.githubRepoURLString + "?q=\(searchDescription)"
    let nsurl = NSURL(string: fullURLString)
    
    let request = NSMutableURLRequest(URL: nsurl!)
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let oAuth = appDelegate.oAuthService
    
    if let token = oAuth.githubAuthenticationToken() {
      request.setValue("token \(token)", forHTTPHeaderField: "Authorization")
    }
    
    let requestTask = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
      if error != nil {
        // Handle the error
      } else {
        if let httpResponse = response as? NSHTTPURLResponse {
          println("Request Status Code: \(httpResponse.statusCode)")
          if httpResponse.statusCode == 200 {
            let parsedRepos = RepositoryJSONParser.reposFromJSONData(data)
            
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
              completionHandler(parsedRepos, nil)
            })
          } else {
            // There was a problem with the response
          }
        }
      }
    })
    requestTask.resume()
  }
  
  func fetchUsersWithSearchTerm(searchTerm: String, completionHandler: ([User]?, NSError?)->Void) {
    let fullURL = self.githubUsersURLString + "q=\(searchTerm)"
    let nsurl = NSURL(string: fullURL)
    
    let request = NSMutableURLRequest(URL: nsurl!)
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let authService = appDelegate.oAuthService
    
    if let token = authService.githubAuthenticationToken() {
      request.setValue("token \(token)", forHTTPHeaderField: "Authorization")
    }
    
    let requestTask = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
      if error == nil {
        if let httpResponse = response as? NSHTTPURLResponse {
          if httpResponse.statusCode == 200 {
            let parsedUsers = UsersJSONParser.usersFromJSONData(data)
            
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
              completionHandler(parsedUsers, nil)
            })
          }
        }
      
      } else {
        // An error occurred, handle it
      }
    })
    requestTask.resume()
    
    
  }
  
}
