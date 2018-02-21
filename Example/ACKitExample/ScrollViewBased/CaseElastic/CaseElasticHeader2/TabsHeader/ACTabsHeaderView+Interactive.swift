//
//  ACTabsHeaderView+Interactive.swift
//  ?<App>
//
//  Created by Austin Chen on 2017-09-26.
//  Copyright © 2017 ACCodeworks Inc. All rights reserved.
//

import UIKit

public enum ACTabsHeaderViewStyle {
    case leftTab
    case centerTab
}

public enum ACCardScrollDirection: Int {
    case scrollLeft
    case scrollRight
}

public protocol ACTabsHeaderViewType {
    weak var delegate: ACTabsHeaderViewDelegate? {get set}
    
    var leftTabScrollDistance: CGFloat {get}
    var rightTabScrollDistance: CGFloat {get}
    func animateTabOffsetX(_ x: CGFloat)
    func setTabs(deltaOffsetX x: CGFloat, direction: ACCardScrollDirection)
    func animateScroll(direction: ACCardScrollDirection)
}

extension ACTabsHeaderView {
    
    var tabOffsetX: CGFloat {
        get {
            return collectionView.contentOffset.x
        }
        set {
            // check newValue is within content size
            var n: CGFloat = 0.0
            
            if !allowBounce {
                if tabOffsetX < newValue { // scroll left
                    n = min(newValue, self.collectionView.contentSize.width - self.bounds.size.width)
                } else { // scroll right
                    n = max(newValue, 0.0)
                }
            }
            
            // set content offset
            var point = self.collectionView.contentOffset
            point.x = n
            self.collectionView.contentOffset = point
        }
    }
    
    var currentTabMidX: CGFloat {
        return tabMinX + viewBoundHalfWidth
    }
    
    var minScrollableMaxX: CGFloat {
        return self.bounds.width
    }
    
    var minScrollableMidX: CGFloat {
        return viewBoundHalfWidth
    }
    
    var maxScrollableMinX: CGFloat {
        return self.collectionView.contentSize.width - self.bounds.width
    }
    
    var maxScrollableMidX: CGFloat {
        return self.collectionView.contentSize.width - viewBoundHalfWidth
    }
    
    var viewBoundHalfWidth: CGFloat {
        return self.bounds.width * 0.5
    }
    
    var headerWidthForCenterTabStyle: CGFloat {
        // have header wide just enough to put first cell in the middle of the screen's X
        return UIScreen.main.bounds.width / 2.0 - cellWidth / 2.0
    }
}

fileprivate let kAnimateDuration = 0.4

extension ACTabsHeaderView: ACTabsHeaderViewType {
    
    public func animateTabOffsetX(_ x: CGFloat) {
        self.animateTabOffsetX(x, completion: nil)
    }
    
    func animateTabOffsetX(_ x: CGFloat,
                           completion: ((Bool) -> ())? = nil ) {
        UIView.animate(withDuration: kAnimateDuration, delay: 0, options: .curveEaseOut, animations: {
            self.tabOffsetX = x
        }, completion: { (finished) in
            self.tabMinX = self.tabOffsetX
            
            guard let c = completion else { return }
            c(finished)
        })
    }
    
    func resetSelectedIndex() {
        selectedIndex = 0
        self.collectionView.reloadData()
        self.collectionView.contentOffset = CGPoint()
    }
    
    public var leftTabScrollDistance: CGFloat {
        guard selectedIndex - 1 >= 0 else { return 0 }
        
        let leftTabMidX = CGFloat(selectedIndex - 1) * cellWidth + cellWidth * 0.5
        let scrollToX = min(maxScrollableMidX, currentTabMidX)
        if scrollToX > leftTabMidX {
            return scrollToX - leftTabMidX
        } else {
            return 0 // should not scroll
        }
    }
    
    public var rightTabScrollDistance: CGFloat {
        guard selectedIndex + 1 < (dataDelegate?.tabsCount ?? 0) else { return 0 }
        
        let rightTabMidX = CGFloat(selectedIndex + 1) * cellWidth + cellWidth * 0.5
        let scrollToX = max(minScrollableMidX, currentTabMidX)
        if scrollToX < rightTabMidX {
            return rightTabMidX - scrollToX
        } else {
            return 0 // should not scroll
        }
    }
    
    public func setTabs(deltaOffsetX x: CGFloat, direction: ACCardScrollDirection) {
        switch style {
        case .leftTab:
            // only allow skip for leftTab style
            if (direction == .scrollLeft && x >= self.rightTabScrollDistance) ||
                (direction == .scrollRight && x >= self.leftTabScrollDistance)
            {
                return // don't over scroll
            }
        default:
            break
        }
        
        let d: CGFloat = direction == .scrollLeft ? 1 : -1
        self.tabOffsetX = self.tabMinX + x * d
    }
    
    public func animateScroll(direction: ACCardScrollDirection) {
        let idx = direction == .scrollLeft ? selectedIndex + 1 : selectedIndex - 1
        self.animateScroll(toIndex: idx)
    }
    
    public func animateScroll(toIndex idx: Int) {
        guard idx >= 0, idx < (dataDelegate?.tabsCount ?? 0) // check bound
            else { return }
        
        guard idx != selectedIndex // check redundancy
            else { return }
        
        switch style {
        case .leftTab:
            let tabsInBetweenCount = abs(idx - selectedIndex) - 1
            
            if idx > selectedIndex {
                // animate scroll left
                let neightborX = min(self.maxScrollableMinX, tabMinX + rightTabScrollDistance)
                let totalD = min(self.maxScrollableMinX, neightborX + CGFloat(tabsInBetweenCount) * cellWidth)
                
                self.animateTabOffsetX(totalD)
                /*
                 self.isUserInteractionEnabled = false
                 self.animateTabOffsetX(totalD, completion: { (_) in
                 self.selectedIndex = idx
                 self.collectionView.reloadData() // adding BOlD text focus
                 self.isUserInteractionEnabled = true
                 })
                 */
            } else {
                // animate scroll right
                let neightborX = max(0, tabMinX - leftTabScrollDistance)
                let totalD = max(0, neightborX - CGFloat(tabsInBetweenCount) * cellWidth)
                
                self.animateTabOffsetX(totalD)
            }
        case .centerTab:
            var screenMidX = UIScreen.main.bounds.width / 2.0
            screenMidX -= self.cellWidth / 2.0
            self.animateTabOffsetX(CGFloat(idx) * cellWidth)
        }
        
        self.selectedIndex = idx
        self.collectionView.reloadData() // adding BOlD text focus
    }
}
