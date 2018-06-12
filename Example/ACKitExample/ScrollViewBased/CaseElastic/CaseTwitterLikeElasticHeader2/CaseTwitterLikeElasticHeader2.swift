//
//  CaseTwitterLikeElasticHeader2.swift
//
//  Created by Austin Chen on 2018-03-09.
//  Copyright © 2018 Austin Chen. All rights reserved.
//

import UIKit

private let kHeight: CGFloat = 100
private let kMinHeight: CGFloat = 70

private let kHeight2: CGFloat = 250
private let kMinHeight2: CGFloat = 50

class CaseTwitterLikeElasticHeader2: UIViewController {
    @IBAction func backButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var headerView: UIView! // image is set to AspectFit, to zoom in/out according to height
    @IBOutlet weak var hv1Title: UILabel!
    @IBOutlet weak var hv1Subtitle: UILabel!
    @IBOutlet weak var blurView: UIVisualEffectView!
    
    @IBOutlet var headerView2: UIView!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var hv2Title: UILabel!
    
    // MARK: - View Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        var f = headerView.frame
        f.origin = CGPoint(x: 0, y: -(kHeight + kHeight2))
        f.size = CGSize(width: view.bounds.width, height: kHeight)
        headerView.frame = f
        tableView.addSubview(headerView)
        
        var f2 = headerView2.frame
        f2.origin = CGPoint(x: 0, y: -kHeight2)
        f2.size = CGSize(width: view.bounds.width, height: kHeight2)
        headerView2.frame = f2
        tableView.addSubview(headerView2)
        
        // set contentInset top, makes contentOffset y to start -kHeight
        tableView.contentInset = UIEdgeInsets(top: kHeight + kHeight2, left: 0, bottom: 0, right: 0)
    }
}

extension CaseTwitterLikeElasticHeader2: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 25
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Row: \(indexPath.row)"
        cell.backgroundColor = UIColor.blue
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // print(scrollView.contentOffset.y)
        
        var f = headerView.frame
        f.origin.y = scrollView.contentOffset.y // make header view stay at top flushed
        f.size.height = max(-scrollView.contentOffset.y-kHeight2, kMinHeight)
        headerView.frame = f
        
        if -scrollView.contentOffset.y-kHeight2 < kMinHeight {
            headerView2.clipsToBounds = true
            
            
            // print(hv2Title.frame.minY)
            headerView.constraints.first{$0.identifier == "kTitleCstTop"}?.constant =
                min(-hv2Title.frame.minY,
                    (headerView.bounds.height + hv1Title.bounds.height) / 2.0 ) // + because kTitleCstTop is relative from the label top to superview bottom
            
            blurView.alpha = headerView.constraints.first{$0.identifier == "kTitleCstTop"}!.constant /
                ((headerView.bounds.height + hv1Title.bounds.height) / 2.0)
        }
        else if -scrollView.contentOffset.y-kHeight2 >= kMinHeight,
            kHeight >= -scrollView.contentOffset.y-kHeight2
        {
            let scale:CGFloat = (100 - (kHeight2+kHeight + scrollView.contentOffset.y)) / 100
            profileView.transform = CGAffineTransform(scaleX: scale, y: scale)
            headerView2.clipsToBounds = false
        } else {

        }
        
        var f2 = headerView2.frame
        f2.origin.y = scrollView.contentOffset.y + headerView.frame.height // make header view stay at top flushed
        if -scrollView.contentOffset.y-kHeight2 <= kMinHeight {
            f2.size.height = max(-scrollView.contentOffset.y - kMinHeight, kMinHeight2)
        } else {
            f2.size.height = kHeight2
        }
        headerView2.frame = f2
    }
}
