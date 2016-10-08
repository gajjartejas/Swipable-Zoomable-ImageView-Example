//
//  ImageViewController.swift
//  Swipable-Zoomable ImageView
//
//  Created by Tejas on 08/10/16.
//  Copyright © 2016 Tejas. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

    var images = [AnyObject]()
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var containerView: UIView!
    
    var tutorialPageViewController: ImagePageViewController? {
        didSet {
            tutorialPageViewController?.tutorialDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageControl.addTarget(self, action: #selector(ImageViewController.didChangePageControlValue), forControlEvents: .ValueChanged)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let tutorialPageViewController = segue.destinationViewController as? ImagePageViewController {
            
            self.tutorialPageViewController = tutorialPageViewController
            
            for i in 0...images.count-1 {
                
                self.tutorialPageViewController?.imageViewControllers.append(newImageViewController(images[i] as! String,index: i))
                
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
        tutorialPageViewController?.scrollToNextViewController()
    }
    
    /**
     Fired when the user taps on the pageControl to change its current page.
     */
    func didChangePageControlValue() {
        tutorialPageViewController?.scrollToViewController(index: pageControl.currentPage)
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
    
    func tutorialPageViewController(tutorialPageViewController: ImagePageViewController,
                                    didUpdatePageCount count: Int) {
        pageControl.numberOfPages = count
        
    }
    
    func tutorialPageViewController(tutorialPageViewController: ImagePageViewController,
                                    didUpdatePageIndex index: Int) {
        pageControl.currentPage = index
    }
    
}