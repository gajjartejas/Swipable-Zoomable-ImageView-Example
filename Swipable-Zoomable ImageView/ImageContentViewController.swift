//
//  ImageContentViewController.swift
//  Swipable-Zoomable ImageView
//
//  Created by Tejas on 08/10/16.
//  Copyright © 2016 Tejas. All rights reserved.
//

import UIKit

class ImageContentViewController: UIViewController {

    @IBOutlet weak var imageScrollView: ImageScrollView!
    
    var pageIndex = NSInteger()
    var image = NSString()
    
    @IBAction func loadaction(sender: AnyObject) {
        
        dispatch_async(dispatch_get_main_queue()) { 
            self.imageScrollView.displayImage(UIImage.init(named: self.image as String)!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackgroundColour(UIColor.blackColor())
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        dispatch_async(dispatch_get_main_queue()) {
            self.imageScrollView.displayImage(UIImage.init(named: self.image as String)!)
        }

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

    }
    
    func setBackgroundColour(colour:UIColor) {
        imageScrollView.backgroundColor = colour
        view.backgroundColor = colour
    }
}
