WikiLocation
============

WikiLocation - A geolocation based wikipedia app written in Swift

This little app demonstrates how easy it is to create an iOS app with Swift and the new iOS frameworks.
What is this app about? As the name implies, it uses your current location and provides nearby Wikipedia articles. (Buildings, lakes and so on). Straight forward. Not too much magic.
This mini app covers ViewControllers, Views & Models in Swift and custom new iOS Frameworks :

###ViewControllers in Swift
TableViewController with an UITableView: Shows the Wiki articles nearby in a simple list.
WebViewController with an UIWebView: showing the selected article in a pushed webView
###New custom iOS Frameworks / modules
####GeoLocation Manager
Retrieves the user's location, stops after we got the coordinates. Stops updating location when going into background, refreshes the location when coming into foreground.
TableViewController observes the location property to load new articles when the location changes.
####Network Manager
Provides a model for the WikiArticles, fetches the Wiki articles from the API. Handles the JSON parsing and mapping with our model

### Some Swift patterns
When you start working with Swift you may notice that there are different patterns compared to Objective C.
####Singleton 
```  Swift
class var sharedInstace : GeoManager {
	struct SharedInstance {
        static let instance = GeoManager()
        }
        return SharedInstance.instance
    }
}
```
The singleton pattern changes a bit in Swift. We could use the dispatch_once pattern. But a shorter way in Swift is the struct and a static var. At this time Swift does not really provide class variables. XCode 6 says "Class variables not yet supported". Looks like that this will come later. But Swift provides type methods. Type methods are equivalent to the class methods + (void)method in Objective C. Structs and enumerations also provides type properties with the static keyword. Type properties can "store a value that is global to all instances of that type (like a static variable in C).” Excerpt From: Apple Inc. “The Swift Programming Language.” iBooks.
So we can go the way with a struct and a read only type property. Swift provides the static keyword in structs which we can use to create to a constant type variable in the struct 'SharedInstance'. The struct is little a helper to enable class typed variables like we know it from C with static. I think the type property and the pattern is still under little construction and will be changed in the near future.

####JSON Parsing 
```  Swift
var error:NSError?
var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error:&error) as Dictionary<String,AnyObject>
var articles = NSMutableOrderedSet()
if let jsonarticles = jsonResult["articles"] as? NSArray {
    for item : AnyObject in jsonarticles {
	var article = WikiArticle(json: item as Dictionary<String, AnyObject>)
    articles.addObject(article)
    }
}
```
Because Swift is strict about types, we need to check and cast a lot. This is one of the biggest differences to Objective C in this example app.
We access the ``jsonResult`` via the subscript ``articles`` and check with ``if let`` for the NSArray type (NSJSONSerialization uses Foundation objects).
In the for loop we initialize the model object ``WikiArticle`` with a casted Dictionary.

####Variable declaration, initialization and lazy loading
```  Swift
class ViewController: UITableViewController {
    
    @lazy var geoManager = GeoManager.sharedInstance
    var dataSource = WikiArticle[]()

	override func viewDidLoad() {
	    super.viewDidLoad()

	    self.geoManager.start()
	    self.geoManager.addObserver(self, forKeyPath: "location", options: NSKeyValueObservingOptions.New, context: nil)
	}
    .....
}
```
The ``geoManager`` will be initialized lazy. That means that the instance for the property will be created when we access the property the first time (in viewDidLoad).
The dataSource property will be initialized directly.
Initializing properties in the declaration is new to Objective C developers.
