# webkit-gesture-bug-repro
Minimal (or near-minimal) repro of longpress gesture bug with WKWebViews and HTML touch events

Discovered during investigation of https://github.com/keymanapp/keyman/issues/2716.

Long story short:  `UILongPressGestureRecognizer` fails to trigger on `WKWebView`s when the loaded HTML page has a
`touchStart` event handler that calls `e.preventDefault()` within iOS 13.4.  This was discovered for `WKWebView`s within
an `InputViewController`, hence the structure of the reproduction.

In earlier versions of iOS before 13.4, longpress handlers would still trigger in this scenario, as seen by running
this against iOS 13.3 (or before) in the Simulator.

The offending `e.preventDefault()` lines may be seen within `WebKit Gesture Bug Repro/WebKit Gesture Bug Repro/resources/webview-contents.bundle/index.html`, the page embedded within the WKWebView.  Simply comment the noted lines out and 13.4 will generate an alert for longpresses within the 'keyboard', matching the behavior of either case when within 13.3 or before.

Compare that HTML file against `WebKit Gesture Bug Repro/WebKit Keyboard/KeyboardViewController.swift`, the class that embeds the HTML file within a `WKWebView`.  Those two files should be enough to diagnose whatever internal changes must have happened between 13.3 and 13.4.
