//
//  UsersJSONParser.swift
//  GithubzToGo
//
//  Created by Brandon Roberts on 4/17/15.
//  Copyright (c) 2015 BR World. All rights reserved.
//

import Foundation

class UsersJSONParser {
  class func usersFromJSONData(jsonData: NSData) -> [User] {
    var users = [User]()
    var error : NSError?
    
    if let
      root = NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.allZeros, error: &error) as? [String : AnyObject],
      items = root["items"] as? [[String : AnyObject]]
    {
        for item in items
        {
          if let
            id = item["id"] as? NSNumber,
            htmlURL = item["html_url"] as? String,
            avatarURL = item["avatar_url"] as? String
          {
              let newUser = User(id: id.stringValue, htmlURL: htmlURL, avatarURL: avatarURL)
              users.append(newUser)
          }
        }
    }
    return users
  }
}
