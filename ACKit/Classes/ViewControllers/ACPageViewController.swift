//
//  ACPageViewController.swift
//  <?>App
//
//  Created by Austin Chen on 2018-01-23.
//  Copyright © 2018 Austin Chen. All rights reserved.
//

import UIKit

public protocol ACPageViewControllerDelegate: class {
    
    /**
     Called when the number of pages is updated.
     
     - parameter tutorialPageViewController: the TutorialPageViewController instance
     - parameter count: the total number of pages.
     */
    func didUpdate(pageCount: Int, viewController: ACPageViewController)
    
    /**
     Called when the current index is updated.
     
     - parameter tutorialPageViewController: the TutorialPageViewController instance
     - parameter index: the index of the currently visible page.
     */
    func willUpdate(pageIndex: Int, viewController: ACPageViewController)
    func didUpdate(pageIndex: Int, viewController: ACPageViewController)
    
}

open class ACPageViewController: UIPageViewController {
    @IBInspectable open var allowsLoopBack: Bool = true
    
    open weak var apDelegate: ACPageViewControllerDelegate?
    open var orderedViewControllers: [UIViewController] = []
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        delegate = self
        
        if let initialViewController = orderedViewControllers.first {
            scrollToViewController(initialViewController)
        }
        apDelegate?.didUpdate(pageCount: orderedViewControllers.count, viewController: self)
    }
    
    func pageIndex() -> Int {
        if let firstViewController = viewControllers?.first,
            let index = orderedViewControllers.index(of: firstViewController)
        {
            return index
        } else {
            return -1
        }
    }
    
    /**
     Scrolls to the next view controller.
     */
    func scrollToNextViewController() {
        if let visibleViewController = viewControllers?.first,
            let nextViewController = pageViewController(self,
                                                        viewControllerAfter: visibleViewController) {
            scrollToViewController(nextViewController)
        }
    }
    
    /**
     Scrolls to the view controller at the given index. Automatically calculates
     the direction.
     
     - parameter newIndex: the new index to scroll to
     */
    func scrollToViewController(index newIndex: Int) {
        if let firstViewController = viewControllers?.first,
            let currentIndex = orderedViewControllers.index(of: firstViewController) {
            let direction: UIPageViewControllerNavigationDirection = newIndex >= currentIndex ? .forward : .reverse
            let nextViewController = orderedViewControllers[newIndex]
            scrollToViewController(nextViewController, direction: direction)
        }
    }
    
    fileprivate func newColoredViewController(_ color: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil) .
            instantiateViewController(withIdentifier: "\(color)ViewController")
    }
    
    /**
     Scrolls to the given 'viewController' page.
     
     - parameter viewController: the view controller to show.
     */
    fileprivate func scrollToViewController(_ viewController: UIViewController,
                                            direction: UIPageViewControllerNavigationDirection = .forward)
    {
        _ = viewController.view
        willUpdateIndex(for: viewController)  // will update
        setViewControllers([viewController],
                           direction: direction,
                           animated: true,
                           completion: { (finished) -> Void in
                            // Setting the view controller programmatically does not fire
                            // any delegate methods, so we have to manually notify the
                            // 'tutorialDelegate' of the new index.
                            self.notifyDelegateOfNewIndex()
        })
    }
    
    /**
     Notifies '_tutorialDelegate' that the current page index was updated.
     */
    fileprivate func willUpdateIndex(for viewController: UIViewController) {
        if let index = orderedViewControllers.index(of: viewController)
        {
            apDelegate?.willUpdate(pageIndex: index, viewController: self)
        }
    }
    
    fileprivate func notifyDelegateOfNewIndex() {
        if let firstViewController = viewControllers?.first,
            let index = orderedViewControllers.index(of: firstViewController) {
            apDelegate?.didUpdate(pageIndex: index, viewController: self)
        }
    }
    
}

// MARK: UIPageViewControllerDataSource

extension ACPageViewController: UIPageViewControllerDataSource {
    
    public func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        // User is on the first view controller and swiped left to loop to
        // the last view controller.
        if previousIndex < 0 {
            if allowsLoopBack {
                // if allowsLoopBack
                return orderedViewControllers.last
            } else {
                return nil
            }
        }
        
        guard previousIndex < orderedViewControllers.count else {
            return nil
        }
        return orderedViewControllers[previousIndex]
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        // User is on the last view controller and swiped right to loop to
        // the first view controller.
        if nextIndex == orderedViewControllersCount {
            if allowsLoopBack {
                // if allowsLoopBack
                return orderedViewControllers.first
            } else {
                return nil
            }
        }
        
        guard nextIndex < orderedViewControllersCount else {
            return nil
        }
        return orderedViewControllers[nextIndex]
    }
    
}

extension ACPageViewController: UIPageViewControllerDelegate {
    public func pageViewController(_ pageViewController: UIPageViewController,
                            willTransitionTo pendingViewControllers: [UIViewController])
    {
        pendingViewControllers.first.map{ willUpdateIndex(for: $0) }
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool)
    {
        self.notifyDelegateOfNewIndex()
    }
}
