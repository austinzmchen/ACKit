//
//  ACScrollViewDelegate.swift
//  SnackableTV
//
//  Created by Austin Chen on 2017-09-12.
//  Copyright © 2017 Austin Chen. All rights reserved.
//

import UIKit

public enum ACScrollDirection {
    case none
    case up
    case down
    case bounceUp
    case bounceDown
}

open class ACScrollViewDelegate: NSObject {
    
    open var scrollDirection: ACScrollDirection {
        return _scrollDirection
    }
    
    fileprivate var _scrollDirection: ACScrollDirection = .none
    fileprivate var _lastContentOffset: CGFloat = 0
}

extension ACScrollViewDelegate: UIScrollViewDelegate {
    
    open func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // ignore scrolling within bounce regions
        
        if scrollView.contentOffset.y <= 0 {
            // if bounce within top region
            if (_lastContentOffset < scrollView.contentOffset.y) {
                _scrollDirection = .bounceUp
            } else {
                _scrollDirection = .bounceDown
            }
        } else if scrollView.contentOffset.y >= scrollView.contentSize.height - scrollView.bounds.height {
            // if bounce within bottom region
            
            if (_lastContentOffset < scrollView.contentOffset.y) {
                _scrollDirection = .bounceUp
            }
            else {
                _scrollDirection = .bounceDown
            }
        } else {
            // set scroll direction
            if (_lastContentOffset < scrollView.contentOffset.y) {
                // scroll up
                _scrollDirection = .up
            } else if (_lastContentOffset > scrollView.contentOffset.y) {
                // scroll down
                _scrollDirection = .down
            }
        }
        
        // update the new position acquired
        _lastContentOffset = scrollView.contentOffset.y
    }
}
