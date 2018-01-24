//
//  CaseScrollViewController.swift
//  ACKit
//
//  Created by Austin Chen on 2017-09-05.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import ACKit

class CaseScrollViewController: UITableViewController {
    
    lazy var dataDelegate: SampleTableViewDataDelegate = {
        return SampleTableViewDataDelegate(viewController: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.dataSource = dataDelegate
        tableView.delegate = dataDelegate
    }
}

class SampleTableViewDataDelegate: ACTableViewDataDelegate {
    let viewController: CaseScrollViewController
    
    init(viewController: CaseScrollViewController) {
        self.viewController = viewController
        super.init()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "kcell")
        cell?.textLabel?.text = "Title"
        return cell!
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        super.scrollViewDidScroll(scrollView)
        
        switch scrollDirection {
        case .up:
            print("up")
        case .down:
            print("down")
        case .bounceUp:
            print("bounceUp")
        case .bounceDown:
            print("bounceDown")
        default:
            break
        }
    }
}

