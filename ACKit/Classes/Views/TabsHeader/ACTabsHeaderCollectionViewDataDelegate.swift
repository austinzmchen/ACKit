//
//  ACTabsHeaderCollectionViewDataDelegate.swift
//  ?<App>
//
//  Created by Austin Chen on 2018-01-11.
//  Copyright © 2018 Austin Chen. All rights reserved.
//

import UIKit

open class ACTabsHeaderCollectionViewDataDelegate: NSObject, ACTabsHeaderCollectionViewDataDelegateType {
    
    unowned public var tabsHeaderView: ACTabsHeaderView
    
    init(fromTabsHeaderView tView: ACTabsHeaderView) {
        tabsHeaderView = tView
        super.init()
    }
    
    public var tabsCount: Int {
        return tabTitles.count
    }
    
    open var tabTitles: [String] = [] {
        didSet {
            if tabTitles.count > 0 {
                tabsHeaderView.cellWidth = UIScreen.main.bounds.width / CGFloat(tabTitles.count) }
            tabsHeaderView.collectionView.reloadData()
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabTitles.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "kACTabHeaderCollectionCell", for: indexPath) as! ACTabHeaderCollectionCell
        cell.tag = indexPath.row
        
        // hight light selected cell
        if tabsHeaderView.selectedIndex == indexPath.row {
            cell.headerTitleLabel.textColor = UIColor.white
            cell.underlineView.isHidden = false
        } else {
            cell.headerTitleLabel.textColor = UIColor.blue
            cell.underlineView.isHidden = true
        }
        cell.headerTitleLabel.text = tabTitles[indexPath.row]
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        tabsHeaderView.animateScroll(toIndex: indexPath.row)
        
        if indexPath.row >= 0 && indexPath.row < tabTitles.count {
            tabsHeaderView.delegate?.didSelectTab(tabsHeaderView, atIndex: indexPath.row, animated: true)
        }
        collectionView.reloadData() // refresh selectedIndex
    }
}


extension ACTabsHeaderCollectionViewDataDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize
    {
        switch tabsHeaderView.style {
        case .leftTab:
            return CGSize.zero
        case .centerTab:
            return CGSize(width: headerWidthForCenterTabStyle, height: tabsHeaderView.bounds.size.height)
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize
    {
        switch tabsHeaderView.style {
        case .leftTab:
            return CGSize.zero
        case .centerTab:
            return CGSize(width: headerWidthForCenterTabStyle, height: tabsHeaderView.bounds.size.height)
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: tabsHeaderView.cellWidth, height: tabsHeaderView.bounds.size.height);
    }
}
