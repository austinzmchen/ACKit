//
//  UICollectionViewExtension.swift
//  <?>App
//
import UIKit

// reuseIdentifier: MyCollectionViewCell -> kMyCollectionViewCell
public extension UICollectionView {
    
    public func registerCellClass(_ cellClass: AnyClass) {
        let identifier = String.className(cellClass)
        register(cellClass, forCellWithReuseIdentifier: "k\(identifier)")
    }
    
    public func registerCellNib(_ cellClass: AnyClass) {
        let identifier = String.className(cellClass)
        let nib = UINib(nibName: identifier, bundle: nil)
        register(nib, forCellWithReuseIdentifier: "k\(identifier)")
    }
    
    public func registerHeaderFooterViewClass(_ viewClass: AnyClass) {
        let identifier = String.className(viewClass)
        register(viewClass, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "k\(identifier)")
    }
    
    public func registerHeaderFooterViewNib(_ viewClass: AnyClass) {
        let identifier = String.className(viewClass)
        let nib = UINib(nibName: identifier, bundle: nil)
        register(nib, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "k\(identifier)")
    }
    
    public func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: "k\(String(describing: T.self))", for: indexPath) as! T
    }
}

