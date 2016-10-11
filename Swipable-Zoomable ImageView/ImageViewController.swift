//
//  ImageViewController.swift
//  Swipable-Zoomable ImageView
//
//  Created by Tejas on 08/10/16.
//  Copyright © 2016 Tejas. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

    weak var imageViewControllerDelegate : ImageViewControllerDelegate?
    
    var images = [AnyObject]()
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var containerView: UIView!
    
    var imagePageViewController: ImagePageViewController? {
        didSet {
            imagePageViewController?.imagePageViewControllerDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageControl.addTarget(self, action: #selector(ImageViewController.didChangePageControlValue), forControlEvents: .ValueChanged)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let imagePageViewController = segue.destinationViewController as? ImagePageViewController {
            
            self.imagePageViewController = imagePageViewController
            
            for i in 0...images.count-1 {
                
                self.imagePageViewController?.imageViewControllers.append(newImageViewController(images[i] as! String,index: i))
                
            }
        }
    }
    
    //Check if image count > 0 then go forward
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        
        var shouldPerformSegueWithIdentifier = false
        
        if images.count > 0 {
            
            shouldPerformSegueWithIdentifier = true
        }
        
        print("ImageViewController->shouldPerformSegueWithIdentifier->images.count < 1")
        
        return shouldPerformSegueWithIdentifier
    }
    
    @IBAction func didTapNextButton(sender: UIButton) {
        imagePageViewController?.scrollToNextViewController()
    }
    
    /**
     Fired when the user taps on the pageControl to change its current page.
     */
    func didChangePageControlValue() {
        imagePageViewController?.scrollToViewController(index: pageControl.currentPage)
    }
    
    private func newImageViewController(url: String,index:NSInteger) -> UIViewController {
        
        let imageContentViewController = UIStoryboard(name: "SZImageView", bundle: nil) .
            instantiateViewControllerWithIdentifier("ImageContentViewController") as! ImageContentViewController
        
        imageContentViewController.image = url
        imageContentViewController.pageIndex = index
        return imageContentViewController
    }
}


extension ImageViewController: ImagePageViewControllerDelegate {
    
    func imagePageViewController(imagePageViewController: ImagePageViewController,
                                 didUpdatePageCount count: Int) {
        pageControl.numberOfPages = count
        self.imageViewControllerDelegate?.imageViewController(self, imagePageViewController: imagePageViewController, didUpdatePageCount: count)
        
    }
    
    func imagePageViewController(imagePageViewController: ImagePageViewController,
                                 didUpdatePageIndex index: Int) {
        pageControl.currentPage = index
         self.imageViewControllerDelegate?.imageViewController(self, imagePageViewController: imagePageViewController, didUpdatePageIndex: index)
    }
}

protocol ImageViewControllerDelegate : class {
    /**
     Called when the number of pages is updated.
     
     - parameter imageViewController: the ImageViewController instance
     - parameter imagePageViewController: the ImagePageViewController instance
     - parameter count: the total number of pages.
     */
    func imageViewController(imageViewController: ImageViewController,
                             imagePageViewController: ImagePageViewController,
                                 didUpdatePageCount count: Int)
    
    /**
     Called when the current index is updated.

     - parameter imageViewController: the ImageViewController instance
     - parameter imagePageViewController: the ImagePageViewController instance
     - parameter index: the index of the currently visible page.
     */
    func imageViewController(imageViewController: ImageViewController,
                             imagePageViewController: ImagePageViewController,
                                 didUpdatePageIndex index: Int)
    
}