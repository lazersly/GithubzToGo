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
  
  let githubURLString = "https://api.github.com/search/repositories"
//  let localHost = "http://127.0.0.1:3000"
  
  func fetchReposWithSearchTerm(searchDescription : String, completionHandler: ([Repository]?, NSError?)->Void) {
    
    let fullURLString = self.githubURLString + "?q=\(searchDescription)"
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
  
}
