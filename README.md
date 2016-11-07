# Movie Picker

![](http://i.imgur.com/uwpkJG8.jpg?1)

# Story

Every Friday evening at your house is movie night. There's only one problem.. no-one can _ever_ agree on a movie. But.. you being the best iOS dev there is have a solution.

In this story, imagine that you have a baby girl named Laura. Your brilliant idea is to make an iOS app  that will allow for Laura to make the decision for the group.

The group has come up with the following four movies:
* Titanic
* Toy Story
* Spirited Away
* Wall-E

The app will display these four movies on screen. There will be a red transparent circle Laura will be able to move around the screen. If this circle is hovering over one of these movie titles displayed on screen when she taps the circle then that will be the movie we watch.

Demo:

[![](http://img.youtube.com/vi/T6D8n_Y8Uqo/0.jpg)](https://www.youtube.com/watch?v=T6D8n_Y8Uqo "Movie Picker Demo")


# Instructions

The demo above is the finished product. If you were to run the app from the current .xcodeproj you have, it doesn't look the same as the finished product. It's running very very slow, why is that?

You have one instruction for this lab.

De-bug the problem. Look through the code and look to resolve the problem.

Before writing any code, run the app as it currently stands so you can _see_ what it is I'm referring to when I say that it's running very slow.

If you need a nudge in the right direction, ask an instructor for a hint. All of the code is written in the `ViewController.swift` file. Without much direction with how it was written, take some time to step through the various methods to get an understanding as to what's calling what. It's important to be able to read other peoples code.

**Advanced**:
* When the red `UIButton` is hovering over any `UILabel`, have that text appear in a _new_ `UILabel` you should make in the center of the screen. The font should be fairly large. When the red `UIButton` is no longer hovering over a `UILabel`, that center `UILabel` should be hidden.
* Create an initial view that asks the user for input. Four movies need to be entered in before we head over to this `ViewController` which will display them along with the red `UIButton`.
* Look to expand the app. When a user taps the red `UIButton` while its hovering over a `UILabel`, it should bring up another `UIView` which will display details of the movie in a pretty way. This will require you saving more information then we currently are from the API request. Here's [link](http://www.smashbros.com/images/og/link.jpg). Sorry, I couldn't resist--here's the actual [link](http://static.comicvine.com/uploads/original/11118/111188772/4290612-heres%2Ba%2Bpretty%2Bcool%2Blink%2Bwallpaper%2Bfor%2Banyone%2Bwho%2Bmight%2B_5bad7f2d034643bc4059ae814cb067c6.jpg).

https://www.omdbapi.com


