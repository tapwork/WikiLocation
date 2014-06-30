WikiLocation
============

WikiLocation - A geolocation based wikipedia app written in Swift

This little app demonstrates how easy it is to create an iOS app with Swift and the new iOS frameworks.
What is this app about? As the name implies, it uses your current location and provides nearby Wikipedia articles. (Buildings, lakes and so on). Straight forward. Not too much magic.
This mini app covers ViewControllers, Views & Models in Swift and custom new iOS Frameworks :

###ViewControllers in Swift
TableViewController with an UITableView: Shows the Wiki articles nearby in a simple list.
WebViewController with an UIWebView: showing the selected article in a pushed webView
###New iOS Frameworks
####GeoLocation Manager
Retrieves the user's location, stops after we got the coordinates. Stops updating location when going into background, refreshes the location when coming into foreground.
TableViewController observes the location property to load new articles when the location changes.
####Network Manger
Provides a model for the WikiArticles, fetches the Wiki articles from the API. Handles the JSON parsing and mapping with our model
