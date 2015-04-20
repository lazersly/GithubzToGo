//
//  ImageResizeService.swift
//  ImageFilterz
//
//  Created by Brandon Roberts on 4/7/15.
//  Copyright (c) 2015 BR World. All rights reserved.
//

import UIKit

class ImageResizeService {
  class func resizeImage(originalImage: UIImage, size: CGSize) -> UIImage? {
    
    UIGraphicsBeginImageContext(size)
    originalImage.drawInRect(CGRect(origin: CGPoint(x: 0.0, y: 0.0), size: size))
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return newImage
  }
}
