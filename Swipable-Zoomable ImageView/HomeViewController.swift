//
//  HomeViewController.swift
//  Swipable-Zoomable ImageView
//
//  Created by Tejas on 08/10/16.
//  Copyright © 2016 Tejas. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    static let cellIdentifier = "cell"
    
    let arrayItems = ["Single Image","Multiple Image"]
    
    var images = [AnyObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI()  {
        tableView.delegate = self
        tableView.dataSource = self
    }
}


extension HomeViewController :UITableViewDataSource {
    
    //MARK: UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(HomeViewController.cellIdentifier, forIndexPath: indexPath)
        
        cell.textLabel?.text = arrayItems[indexPath.row]
        
        return cell
    }
}

extension HomeViewController : UITableViewDelegate{
    
    //MARK: UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let vc = UIStoryboard(name: "SZImageView", bundle: nil).instantiateViewControllerWithIdentifier("ImageViewController") as! ImageViewController
        
        vc.imageViewControllerDelegate = self
        
        //pass image name here
        if indexPath.row == 0 {
            images = ["IMG_1"]
        } else if (indexPath.row == 1) {
            images = ["IMG_1","IMG_2","IMG_3"]
        }
        
        vc.images = images as! [String]
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController : ImageViewControllerDelegate {
    func imageViewController(imageViewController: ImageViewController,
                             imagePageViewController: ImagePageViewController,
                             didUpdatePageCount count: Int){
        
        print("count : \(count)")
        
    }
    
    func imageViewController(imageViewController: ImageViewController,
                             imagePageViewController: ImagePageViewController,
                             didUpdatePageIndex index: Int){
        print("index : \(index)")
    }
}
