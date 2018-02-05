# Delegation-In-Swift
This is a project (Xcode 9) demonstrating delegates/delegation in iOS with Swift 4. I use delegation to get notified and do whatever I want when a file has finished downloading.

Go to my article, [Tutorial: delegates and delegation in Swift 4](http://iosbrain.com/blog/2018/02/05/tutorial-delegates-and-delegation-in-swift-4), and we'll discuss the following: 

I'm going to talk about "delegates" and "delegation." I’ll lead you through a simple example of implementing the delegation design pattern in Swift 4, with full source code. My intent here is to show you how delegation works without getting bogged down in some crazy complex example. To help you become the best of the best, I'm going to introduce you to one of the greatest design tools to aid in object-oriented software development, UML. I'll show you a UML diagram that I drew up to design and document the implementation of the delegation design pattern used in the sample app we'll build together. Here’s the app we'll build:

![alt text][logo1]

[logo1]: http://iosbrain.com/wp-content/uploads/2018/02/SwiftDelegation.gif "App demonstrating delegation"

Here's the UML diagram for the app's code:

![alt text][logo2]

[logo2]: http://iosbrain.com/wp-content/uploads/2018/02/UML-Delegation.png "UML for app demonstrating delegation"

![alt text][logo3]

[logo3]: http://iosbrain.com/wp-content/uploads/2018/02/UML-Legend.png "UML for app demonstrating delegation"

## Xcode 9 project settings
**To get this project running on the Simulator or a physical device (iPhone, iPad)**, go to the following locations in Xcode and make the suggested changes:

1. Project Navigator -> [Project Name] -> Targets List -> TARGETS -> [Target Name] -> General -> Signing
- [ ] Tick the "Automatically manage signing" box
- [ ] Select a valid name from the "Team" dropdown
  
2. Project Navigator -> [Project Name] -> Targets List -> TARGETS -> [Target Name] -> General -> Identity
- [ ] Change the "com.yourDomainNameHere" portion of the value in the "Bundle Identifier" text field to your real reverse domain name (i.e., "com.yourRealDomainName.Project-Name").
