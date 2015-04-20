//
//  RepoWebViewController.swift
//  GithubzToGo
//
//  Created by Brandon Roberts on 4/19/15.
//  Copyright (c) 2015 BR World. All rights reserved.
//

import UIKit
import WebKit

class RepoWebViewController: UIViewController {
  
  var webView : WKWebView!
  var selectedRepo : Repository!

    override func viewDidLoad() {
        super.viewDidLoad()
      
      let urlRequest = NSURLRequest(URL: NSURL(string: selectedRepo.htmlURL)!)
      self.webView = WKWebView(frame: self.view.frame)
      self.webView.loadRequest(urlRequest)
      
      self.view.addSubview(self.webView)

        // Do any additional setup after loading the view.
    }

}
