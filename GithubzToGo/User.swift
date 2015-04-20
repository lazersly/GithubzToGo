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
  var score : String!
  var avatarURL : String!
  var avatarImage : UIImage?
  
  init(id : String!, avatarURL : String!, htmlURL : String!, score: String!) {
    self.id = id
    self.avatarURL = avatarURL
    self.htmlURL = htmlURL
    self.score = score
  }
}
