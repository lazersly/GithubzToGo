//
//  StringExtension.swift
//  GithubzToGo
//
//  Created by Brandon Roberts on 4/19/15.
//  Copyright (c) 2015 BR World. All rights reserved.
//

import Foundation

extension String {
  func validForGithubSearch() -> Bool {
    let noElements = count(self)
    let range = NSMakeRange(0, noElements)
    let pattern = "[^0-9a-zA-Z\n]"
    let regex = NSRegularExpression(pattern: pattern, options: NSRegularExpressionOptions.allZeros, error: nil)
    
    let matches = regex?.numberOfMatchesInString(self, options: NSMatchingOptions.allZeros, range: range)
    
    if matches > 0 {
      return false
    } else {
      return true
    }
  }
}
