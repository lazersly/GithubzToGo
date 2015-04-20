//
//  ImageFetcher.swift
//  GithubzToGo
//
//  Created by Brandon Roberts on 4/19/15.
//  Copyright (c) 2015 BR World. All rights reserved.
//

import UIKit

class ImageFetcher {
  static let sharedImageFetcher = ImageFetcher()
  let imageQueue = NSOperationQueue()
  
  func fetchImageAtURL(imageURL: NSURL, size: CGSize, completionHandler: (returnedImage: UIImage?)->Void) {
    
    imageQueue.addOperationWithBlock { () -> Void in
      
      var fetchedResizedImage : UIImage?
      
      if let imageData = NSData(contentsOfURL: imageURL) {
        let image = UIImage(data: imageData)
        let fetchedResizedImage = ImageResizeService.resizeImage(image!, size: size)
      }
      
      NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
        completionHandler(returnedImage: fetchedResizedImage)
      })
    }
  }
  
}
