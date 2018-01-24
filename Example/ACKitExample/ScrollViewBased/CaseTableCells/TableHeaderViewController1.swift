//
//  TableHeaderViewController1.swift
//  ACKit
//
//  Created by Austin Chen on 2017-09-21.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

class TableHeaderViewController1: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var headerView: SampleHeaderView1!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
}

extension TableHeaderViewController1: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "kCell")
        cell.textLabel?.text = "cell\(indexPath.row)"
        return cell
    }
}
