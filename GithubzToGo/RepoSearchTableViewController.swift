//
//  RepoSearchTableViewController.swift
//  GithubzToGo
//
//  Created by Brandon Roberts on 4/14/15.
//  Copyright (c) 2015 BR World. All rights reserved.
//

import UIKit

class RepoSearchTableViewController: UITableViewController, UISearchBarDelegate {

  //MARK:
  //MARK: Instance Variables
  
  var repoResults = [Repository]() {
    didSet {
      self.tableView.reloadData()
    }
  }
  let githubService = GithubService()
  @IBOutlet var searchBar: UISearchBar!
  
  //MARK:
  //MARK: UIViewController Methods
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.searchBar.delegate = self
  }
  
  //MARK:
  //MARK: UITableViewDataSource
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.repoResults.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = self.tableView.dequeueReusableCellWithIdentifier("SearchRepoCell") as! UITableViewCell
    let rowRepo = self.repoResults[indexPath.row]
    cell.textLabel?.text = rowRepo.name
    
    return cell
  }
  
  //MARK:
  //MARK: UISearchBarDelegate
  
  func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    let searchText = searchBar.text
    
    self.githubService.fetchReposWithSearchTerm(searchText, completionHandler: { (repos, error) -> (Void) in
      if repos != nil {
        self.repoResults = repos!
      } else if error != nil {
        // Handle the error
      }
    })
  }
  
}
