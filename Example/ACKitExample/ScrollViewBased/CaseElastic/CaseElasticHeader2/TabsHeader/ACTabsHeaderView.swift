//
//  ACTabsHeaderView.swift
//  ?<App>
//
//  Created by Austin Chen on 2017-04-03.
//  Copyright © 2017 Austin Chen. All rights reserved.
//

import UIKit

public struct ACTabInfo {
    var title: String
    var normalImageName: String
    var selectedImageName: String
}

public protocol ACTabsHeaderViewDelegate: class {
    func didSelectTab(_ tabsHeader: ACTabsHeaderView, atIndex idx: Int, animated: Bool)
}

public protocol ACTabsHeaderCollectionViewDataDelegateType: class, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var tabsCount: Int { get }
    unowned var tabsHeaderView: ACTabsHeaderView { get set }
}

extension ACTabsHeaderCollectionViewDataDelegateType {
    var headerWidthForCenterTabStyle: CGFloat {
        return tabsHeaderView.headerWidthForCenterTabStyle
    }
}

@IBDesignable
open class ACTabsHeaderView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet open var collectionView: UICollectionView!
    
    // constants
    open var cellWidth: CGFloat = UIScreen.main.bounds.width / 5.0 // 180 //UIScreen.main.bounds.width / 2.0 // custom set
    
    // use tabInfos for this project
    open var selectedIndex: Int = 0
    open var allowBounce: Bool = false
    open var style: ACTabsHeaderViewStyle = .leftTab
    open var isSnapToPositionEnabled = false
    
    var tabMinX: CGFloat = 0
    
    open weak var delegate: ACTabsHeaderViewDelegate?
    open var dataDelegate: ACTabsHeaderCollectionViewDataDelegateType? {
        didSet {
            collectionView.delegate = dataDelegate
            collectionView.dataSource = dataDelegate
            
            dataDelegate?.tabsHeaderView = self
            collectionView.reloadData()
        }
    }
    
    // MARK: life cycles
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }
    
    func loadNib() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let contentView = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        insertSubview(contentView, at: 0)
    }
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        
        // add the missing contrainst between xib contentView to self
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

        /* set up default */
        // set up default datasource
        dataDelegate = ACTabsHeaderCollectionViewDataDelegate(fromTabsHeaderView: self)
        
        collectionView.register(UINib(nibName: "ACTabHeaderCollectionCell", bundle: Bundle(for: type(of: self))),
                                forCellWithReuseIdentifier: "kACTabHeaderCollectionCell")
        
        if isSnapToPositionEnabled {
            collectionView.decelerationRate = UIScrollViewDecelerationRateFast // control speed for
        }
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = self.bounds
    }
}

extension ACTabsHeaderView: UIScrollViewDelegate {
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                   withVelocity velocity: CGPoint,
                                   targetContentOffset: UnsafeMutablePointer<CGPoint>)
    {
        // Auto snapping of cells to tbaleview top
        // assume first cell's width represent all cell width
        guard isSnapToPositionEnabled else { return }
        
        let x = targetContentOffset.pointee.x + scrollView.contentInset.top + (cellWidth / 2)
        let cellIndex = floor(x / cellWidth)
        targetContentOffset.pointee.x = cellIndex * cellWidth - scrollView.contentInset.top
    }
}
