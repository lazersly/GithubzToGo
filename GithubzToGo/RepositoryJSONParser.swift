//
//  RepositoryJSONParser.swift
//  GithubzToGo
//
//  Created by Brandon Roberts on 4/14/15.
//  Copyright (c) 2015 BR World. All rights reserved.
//

import Foundation

class RepositoryJSONParser {
  class func reposFromJSONData(jsonData: NSData) -> [Repository] {
    
    var repos = [Repository]()
    var jsonError : NSError?
    
    if let
      root = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: &jsonError) as? [String : AnyObject],
    items = root["items"] as? [[String : AnyObject]]
    {
      for itemDescription in items {
        if let
          name = itemDescription["name"] as? String,
          id = itemDescription["id"] as? NSNumber,
          ownerDescription = itemDescription["owner"] as? [String : AnyObject],
          author = ownerDescription["login"] as? String,
          htmlURL = itemDescription["html_url"] as? String,
          description = itemDescription["description"] as? String
        {
          let id_str = id.description
          let repo = Repository(id: id_str, name: name, author: author, description: description, htmlURL: htmlURL)
          repos.append(repo)
        }
      }
    }
    return repos
  }
}
