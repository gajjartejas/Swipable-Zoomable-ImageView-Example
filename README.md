## Swipable-Zoomable-ImageView-Example
An example of swipable and pinch to zoom or double tap to zoom using UIScrollview and UIPageviewController

## How to use?
Copy following files to your existing project:

1. SZImageView.storyboard
2. ImageScrollView.swift
3. ImageViewController.swift
4. ImageContentViewController.swift
5. ImagePageViewController.swift

add following code to your viewcontroller


``` swift
@IBAction func sdfsdh(sender: AnyObject) {

  let imageViewController = UIStoryboard(name:"SZImageView",bundle:nil).instantiateViewControllerWithIdentifier("ImageViewController") as! ImageViewController
  
  //Add your local images
  imageViewController.images = ["image1","image2"]
  
  let navigationController = UINavigationController.init(rootViewController: imageViewController)
  
  self.presentViewController(navigationController, animated: true) {
  }
}
```



## Possible features/TODO

- Remote Image Integration
- Show image at index
- Possible Delegates
- Documentations inside code 
- List of contents inside readme
- swift 3.0 support

## Sources/Tutorial used

- [Tutorial-appcoda](http://www.appcoda.com/uipageviewcontroller-storyboard-tutorial/)
- [ImageScrollView-Github](https://github.com/huynguyencong/ImageScrollView)
