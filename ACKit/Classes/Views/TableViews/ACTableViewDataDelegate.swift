//
//  ACTableViewDataDelegate.swift
//  ?<app>
//
//  Created by Austin Chen on 2017-05-20.
//  Copyright © 2017 Austin Chen. All rights reserved.
//

import UIKit

public enum ACScrollDirection {
    case none
    case up
    case down
    case bounce
    case unknown
}

open class ACTableViewDataDelegate: NSObject {
    
    open var scrollDirection: ACScrollDirection {
        return _scrollDirection
    }
    
    fileprivate var _scrollDirection: ACScrollDirection = .none
    fileprivate var _lastContentOffset: CGFloat = 0
    
    open weak var _tableView: UITableView? = nil
}

extension ACTableViewDataDelegate: UITableViewDataSource, UITableViewDelegate {
    
    open func numberOfSections(in tableView: UITableView) -> Int {
        if _tableView == nil {
            _tableView = tableView
        }
        return 1
    }
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell(style: .default, reuseIdentifier: "DataDelegateCell")
    }

    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ACTableViewDataDelegate: UIScrollViewDelegate {
    
    open func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // ignore scrolling within bounce regions
        guard scrollView.contentOffset.y >= 0,
            scrollView.contentOffset.y <= scrollView.contentSize.height - scrollView.bounds.height else
        {
            if (_lastContentOffset > scrollView.contentOffset.y) {
                _scrollDirection = .bounce
            }
            else {
                _scrollDirection = .unknown
            }
            return
        }
        
        // set scroll direction
        if (_lastContentOffset < scrollView.contentOffset.y) {
            // scroll up
            _scrollDirection = .up
        } else if (_lastContentOffset > scrollView.contentOffset.y) {
            // scroll down
            _scrollDirection = .down
        }
        // update the new position acquired
        _lastContentOffset = scrollView.contentOffset.y
    }
}
