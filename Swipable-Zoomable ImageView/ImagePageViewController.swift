//
//  ImagePageViewController.swift
//  Swipable-Zoomable ImageView
//
//  Created by Tejas on 08/10/16.
//  Copyright © 2016 Tejas. All rights reserved.
//

import UIKit

class ImagePageViewController: UIPageViewController {
    
    weak var imagePageViewControllerDelegate: ImagePageViewControllerDelegate?
    
    var imageViewControllers: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        delegate = self
        
        if let initialViewController = imageViewControllers.first {
            scrollToViewController(initialViewController)
        }
        
        imagePageViewControllerDelegate?.imagePageViewController(self,
                                                     didUpdatePageCount: imageViewControllers.count)
    }
    
    /**
     Scrolls to the next view controller.
     */
    func scrollToNextViewController() {
        if let visibleViewController = viewControllers?.first,
            let nextViewController = pageViewController(self,
                                                        viewControllerAfterViewController: visibleViewController) {
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
            let currentIndex = imageViewControllers.indexOf(firstViewController) {
            let direction: UIPageViewControllerNavigationDirection = newIndex >= currentIndex ? .Forward : .Reverse
            let nextViewController = imageViewControllers[newIndex]
            scrollToViewController(nextViewController, direction: direction)
        }
    }
    
    /**
     Scrolls to the given 'viewController' page.
     
     - parameter viewController: the view controller to show.
     */
    private func scrollToViewController(viewController: UIViewController,
                                        direction: UIPageViewControllerNavigationDirection = .Forward) {
        setViewControllers([viewController],
                           direction: direction,
                           animated: true,
                           completion: { (finished) -> Void in
                            // Setting the view controller programmatically does not fire
                            // any delegate methods, so we have to manually notify the
                            // 'imagePageViewControllerDelegate' of the new index.
                            self.notifyImagePageViewControllerDelegateOfNewIndex()
        })
    }
    
    /**
     Notifies 'imagePageViewControllerDelegate' that the current page index was updated.
     */
    private func notifyImagePageViewControllerDelegateOfNewIndex() {
        if let firstViewController = viewControllers?.first,
            let index = imageViewControllers.indexOf(firstViewController) {
            imagePageViewControllerDelegate?.imagePageViewController(self,
                                                         didUpdatePageIndex: index)
        }
    }
    
}

// MARK: UIPageViewControllerDataSource

extension ImagePageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(pageViewController: UIPageViewController,
                            viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = imageViewControllers.indexOf(viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        // User is on the first view controller and swiped left to loop to
        // the last view controller.
        guard previousIndex >= 0 else {
            return imageViewControllers.last
        }
        
        guard imageViewControllers.count > previousIndex else {
            return nil
        }
        
        return imageViewControllers[previousIndex]
    }
    
    func pageViewController(pageViewController: UIPageViewController,
                            viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = imageViewControllers.indexOf(viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = imageViewControllers.count
        
        // User is on the last view controller and swiped right to loop to
        // the first view controller.
        guard orderedViewControllersCount != nextIndex else {
            return imageViewControllers.first
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return imageViewControllers[nextIndex]
    }
    
}

extension ImagePageViewController: UIPageViewControllerDelegate {
    
    func pageViewController(pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                                               previousViewControllers: [UIViewController],
                                               transitionCompleted completed: Bool) {
        notifyImagePageViewControllerDelegateOfNewIndex()
    }
    
}

protocol ImagePageViewControllerDelegate: class {
    
    /**
     Called when the number of pages is updated.
     
     - parameter imagePageViewController: the ImagePageViewController instance
     - parameter count: the total number of pages.
     */
    func imagePageViewController(imagePageViewController: ImagePageViewController,
                                    didUpdatePageCount count: Int)
    
    /**
     Called when the current index is updated.
     
     - parameter imagePageViewController: the ImagePageViewController instance
     - parameter index: the index of the currently visible page.
     */
    func imagePageViewController(imagePageViewController: ImagePageViewController,
                                    didUpdatePageIndex index: Int)
    
}

