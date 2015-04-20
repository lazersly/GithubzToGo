//
//  UserSearchViewController.swift
//  GithubzToGo
//
//  Created by Brandon Roberts on 4/17/15.
//  Copyright (c) 2015 BR World. All rights reserved.
//

import UIKit

class UserSearchViewController: UIViewController, UISearchBarDelegate, UICollectionViewDataSource {

  @IBOutlet var searchBar: UISearchBar!
  @IBOutlet var collectionView: UICollectionView!
  
  var users = [User]()
  let githubService = GithubService()
  
  override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
  
  
  //MARK:
  //MARK: UICollectionViewDataSource
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return users.count
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = self.collectionView.dequeueReusableCellWithReuseIdentifier("UserCell", forIndexPath: indexPath) as! UserCollectionViewCell
    
    let user = users[indexPath.row]
    
    if let userImage = user.avatarImage {
      cell.imageView.image = user.avatarImage
    } else {
      // TODO: Fetch image
    }
    
    return cell
  }
  
  //MARK:
  //MARK: UISearchBarDelegate
  
  func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    self.githubService.fetchUsersWithSearchTerm(searchBar.text, completionHandler: { (returnedUsers, error) -> Void in
      if error != nil {
        self.users = returnedUsers!
      } else {
        // There was an error to handle
      }
    })
  }

}
