//
//  CaseEmbedViewController.swift
//  ACKit
//
//  Created by Austin Chen on 2017-09-28.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

class CaseEmbedViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

}

extension CaseEmbedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = nil
        if let c = tableView.dequeueReusableCell(withIdentifier: "kCell") {
            cell = c
        } else {
            cell = UITableViewCell(style: .default, reuseIdentifier: "kCell")
        }
        
        switch indexPath.row {
        case 0:
            cell?.textLabel?.text = "Init from storyboard"
        case 1:
            cell?.textLabel?.text = "Init by code"
        case 2:
            cell?.textLabel?.text = "Embedded"
        default:
            break
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            performSegue(withIdentifier: "kInitFromSBSegue", sender: nil)
        case 1:
            let vc = CaseEmbedVCByCode()
            self.navigationController?.pushViewController(vc, animated: true)
        case 2:
            let vc = CaseEmbedSubVCByCode()
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
}
