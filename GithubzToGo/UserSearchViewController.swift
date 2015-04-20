//
//  UserSearchViewController.swift
//  GithubzToGo
//
//  Created by Brandon Roberts on 4/17/15.
//  Copyright (c) 2015 BR World. All rights reserved.
//

import UIKit

class UserSearchViewController: UIViewController, UISearchBarDelegate, UICollectionViewDataSource, UICollectionViewDelegate {

  @IBOutlet var searchBar: UISearchBar!
  @IBOutlet var collectionView: UICollectionView!
  
  var users = [User]() {
    didSet {
      self.collectionView.reloadData()
    }
  }
  let githubService = GithubService()
  let cellAnimationDuration : NSTimeInterval = 0.5
  let cellAnimationTransformScale : CGFloat = 0.1
  
  override func viewDidLoad() {
        super.viewDidLoad()
    self.searchBar.delegate = self
    self.collectionView.dataSource = self

  }
  
  //MARK:
  //MARK: UICollectionViewDelegate
  
  func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    
  }
  
  
  //MARK:
  //MARK: UICollectionViewDataSource
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return users.count
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = self.collectionView.dequeueReusableCellWithReuseIdentifier("UserCell", forIndexPath: indexPath) as! UserCollectionViewCell
    cell.imageView.image = nil
    
    let user = users[indexPath.row]
    
    if let userImage = user.avatarImage {
      cell.imageView.image = user.avatarImage
    } else {
      ImageFetcher.sharedImageFetcher.fetchImageAtURL(NSURL(string: user.avatarURL)!, size: cell.frame.size, completionHandler: { (returnedImage) -> Void in
        user.avatarImage = returnedImage
        cell.imageView.image = user.avatarImage
        
        self.animateCellOntoScreen(cell)
      })
    }
    
    return cell
  }
  
  //MARK:
  //MARK: Custom Animations
  
  func animateCellOntoScreen(cell: UserCollectionViewCell) {
    let imageView = cell.imageView
    
    imageView.alpha = 0
    imageView.transform = CGAffineTransformMakeScale(cellAnimationTransformScale, cellAnimationTransformScale)
    
    UIView.animateWithDuration(cellAnimationDuration, delay: NSTimeInterval.NaN, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
      imageView.alpha = 1
      imageView.transform = CGAffineTransformIdentity
    }) { (finished) -> Void in
      // Completion block
    }
    
//    UIView.animateWithDuration(cellAnimationDuration, animations: { () -> Void in
//      imageView.alpha = 1
//      imageView.transform = CGAffineTransformIdentity
//    })
    
//    UIView.animateWithDuration(cellAnimationDuration, delay: NSTimeInterval.NaN, options: UIViewAnimationOptions.Autoreverse, animations: { () -> Void in
//           imageView.transform = CGAffineTransformMakeScale(1.5, 1.5)
//    }) { (finished) -> Void in
//           imageView.transform = CGAffineTransformMakeScale(1.0, 1.0)
//    }
    
    
  }
  
  //MARK:
  //MARK: UISearchBarDelegate
  
  func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    self.githubService.fetchUsersWithSearchTerm(searchBar.text, completionHandler: { (returnedUsers, error) -> Void in
      if error == nil {
        self.users = returnedUsers!
      } else {
        // There was an error to handle
      }
    })
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "ShowUserDetail" {
      //TODO: Prepare next screen
    }
    
  }

}
