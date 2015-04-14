//
//  Repository.swift
//  GithubzToGo
//
//  Created by Brandon Roberts on 4/13/15.
//  Copyright (c) 2015 BR World. All rights reserved.
//

import Foundation

class Repository {
  var id : String
  var name : String
  var author : String
  var description : String
  var htmlURL : String
  
  init(id: String, name: String, author: String, description: String, htmlURL: String) {
    self.id = id
    self.name = name
    self.author = author
    self.description = description
    self.htmlURL = htmlURL
  }
}
