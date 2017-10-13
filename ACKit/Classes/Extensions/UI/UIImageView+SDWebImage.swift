////
////  UIImageViewPlus.swift
////  <?>App
////
////  Created by Austin Chen on 2016-11-15.
////  Copyright © 2016 10.1. All rights reserved.
////
//
//import Foundation
//import SDWebImage
//
//fileprivate var kPlaceHolderImageName = "imgPlaceholder"
//
//extension UIImageView {
//    
//    func sdSetImage(withString string: String?) {
//        self.sdSetImage(withString: string, placeholderName: kPlaceHolderImageName)
//    }
//    
//    func sdSetImage(withString string: String?, placeholderName pl: String) {
//        guard let str = string
//            else { return }
//        
//        let phImage = UIImage(named: pl)
//        self.sd_setImage(with: URL(string: str), placeholderImage: phImage)
//    }
//    
//    func sdSetImage(withString string: String?,
//                    scaleToFillWhenFinished: Bool? = false,
//                    options: SDWebImageOptions = [])
//    {
//        self.sdSetImage(withString: string, scaleToFillWhenFinished: scaleToFillWhenFinished, options: options, completed: nil)
//    }
//    
//    func sdSetImage(withString string: String?,
//                         scaleToFillWhenFinished: Bool? = false,
//                         options: SDWebImageOptions = [],
//                         completed completedBlock: SDWebImage.SDExternalCompletionBlock? = nil)
//    {
//        sdSetImage(withString: string, placeholderName: kPlaceHolderImageName, contentModeUponCompletion: .scaleToFill, options: options, completed: completedBlock)
//    }
//    
//    func sdSetImage(withString string: String?,
//                    placeholderName pl: String?,
//                    contentModeUponCompletion: UIViewContentMode? = nil,
//                    options: SDWebImageOptions = [],
//                    completed completedBlock: SDWebImage.SDExternalCompletionBlock? = nil)
//    {
//        guard let str = string
//            else { return }
//        
//        let phi = pl != nil ? UIImage(named: pl!) : nil
//        
//        self.sd_setImage(with: URL(string: str), placeholderImage: phi, options: options)
//        { (image, error, cacheType, url) in
//            if let cm = contentModeUponCompletion {
//                self.contentMode = cm
//            }
//            
//            if let c = completedBlock {
//                c(image, error, cacheType, url)
//            }
//        }
//    }
//}
