//
//  ACTableViewDataDelegate.swift
//  ?<app>
//
//  Created by Austin Chen on 2017-05-20.
//  Copyright © 2017 Austin Chen. All rights reserved.
//

import UIKit

open class ACTableViewDataDelegate: ACScrollViewDelegate {
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
