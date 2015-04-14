//
//  GithubService.swift
//  GithubzToGo
//
//  Created by Brandon Roberts on 4/13/15.
//  Copyright (c) 2015 BR World. All rights reserved.
//

import Foundation

class GithubService {
  
//  let githubURLString = "http://api.github.com/search/repositories"
  let localHost = "http://127.0.0.1:3000"
  
  func fetchReposWithSearchTerm(searchString : String) {
    
    let fullURLString = self.localHost + "q=\(searchString)"
    let nsurl = NSURL(string: fullURLString)
    
    let request = NSURLRequest(URL: nsurl!)
    let requestTask = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
      if error != nil {
        // Handle the error
      } else {
        response
      }
    })
    
  }
  
}
