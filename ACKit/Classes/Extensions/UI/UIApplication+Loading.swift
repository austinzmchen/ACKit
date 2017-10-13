//
//  UIApplication+Loading.swift
//  SnackableTV
//
//  Created by Austin Chen on 2017-10-04.
//  Copyright © 2017 Austin Chen. All rights reserved.
//

import UIKit

/*
protocol ACLoaderType {
    static var shared: (ACLoaderType & UIViewController)? {get set}
}

extension UIApplication {
    static func showLoader<T: ACLoaderType & UIViewController>(byType type: T.Type) {
        // check & create alias
        guard let loaderVC = T.shared else {
            return
        }
        
        if loaderVC.view.superview != nil { // reset to initial state
            loaderVC.view.removeFromSuperview()
        }
        UIApplication.shared.keyWindow?.addSubview(loaderVC.view)
    }
    
    static func hideLoader<T: ACLoaderType>(byType type: T.Type) {
        guard let loaderVC = T.shared else {
            return
        }
        
        if loaderVC.view.superview != nil {
            loaderVC.view.removeFromSuperview()
            T.shared = nil // dealloc
        }
    }
}
*/
let kLoaderDismissTimeoutInSeconds = 1.5
