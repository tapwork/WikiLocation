WikiLocation
============

WikiLocation - A geolocation based wikipedia app written in Swift

This little app demonstrates how easy it is to create an iOS app with Swift and the new iOS frameworks.
What is this app about? As the name implies, it uses your current location and provides nearby Wikipedia articles. (Buildings, lakes and so on). Straight forward. Not too much magic.
This mini app covers ViewControllers, Views & Models in Swift and custom new iOS Frameworks :

#ViewControllers in Swift
##TableViewController with an UITableView: Show the Wiki article nearby in a simple list
##WebViewController with an UIWebView: showing the selected article in a pushed webView
#GeoLocation Manager
##Retrieve the user's location, stop after we got the coordinates
##Stop update when going into background, refresh the location when coming into foreground
##TableViewController needs to observe the location property to load new articles
#Network Manger
##Provides a model for the WikiArticles
##Fetches the Wiki articles from the API
##JSON parsing and mapping with model
