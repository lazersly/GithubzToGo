//
//  User.swift
//  GithubzToGo
//
//  Created by Brandon Roberts on 4/17/15.
//  Copyright (c) 2015 BR World. All rights reserved.
//

import UIKit

class User {
  var id : String!
  var htmlURL : String!
  var avatarURL : String!
  var avatarImage : UIImage?
  
  init(id : String!, htmlURL : String!, avatarURL : String!) {
    self.id = id
    self.htmlURL = htmlURL
    self.avatarURL = avatarURL
  }
}
