//
//  TableHeaderViewController3.swift
//  ACKit
//
//  Created by Austin Chen on 2017-09-21.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

class TableHeaderViewController3: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableView.register(UINib(nibName: "SampleHeaderView2", bundle: nil), forHeaderFooterViewReuseIdentifier: "kSampleHeaderView2")
    }
}

extension TableHeaderViewController3: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "kSampleHeaderView2") as! SampleHeaderView2
//        headerView.label.text = "Top"
//        headerView.button.setTitle("bottom", for: .normal)
//        headerView.backgroundColor = UIColor.red
        
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
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
