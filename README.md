## Swipable-Zoomable-ImageView-Example
An example of swipable and pinch to zoom or double tap to zoom using UIScrollview and UIPageviewController

## Usage
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
## ImageViewController

### Properties
``` swift
//An array contain images
var images = [AnyObject]()

//UIPageControl displayed in botton
@IBOutlet weak var pageControl: UIPageControl!

//ContainerView of UIPageController
@IBOutlet weak var containerView: UIView!
```
### Delegates
``` swift
//ImageViewControllerDelegate
//Called when the number of pages is updated.
func imageViewController(imageViewController: ImageViewController,
                             imagePageViewController: ImagePageViewController,
                                 didUpdatePageCount count: Int)

//Called when the current index is updated.
func imageViewController(imageViewController: ImageViewController,
                             imagePageViewController: ImagePageViewController,
                                 didUpdatePageIndex index: Int)
```

## ImagePageViewController
### Actions
**NOTE: To access this action use the imageViewController.imagePageViewController properties**
``` swift
// Scrolls to the view controller at the given index. Automatically calculates the direction.
func scrollToViewController(index newIndex: Int)

//Scrolls to the next view controller.
func scrollToNextViewController() 
```
## Possible features/TODO
- Landscape orientation support
- Remote Image Integration
- swift 3.0 support
- ~~Show image at index~~
- ~~Possible Delegates~~
- Documentations inside code
- List of contents inside readme


## Sources/Tutorial used

- [Tutorial-appcoda](http://www.appcoda.com/uipageviewcontroller-storyboard-tutorial/)
- [ImageScrollView-Github](https://github.com/huynguyencong/ImageScrollView)
