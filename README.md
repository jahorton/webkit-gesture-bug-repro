# webkit-gesture-bug-repro
Minimal (or near-minimal) repro of longpress gesture bug with WKWebViews and HTML touch events

Discovered during investigation of https://github.com/keymanapp/keyman/issues/2716.

Long story short:  `UILongPressGestureRecognizer` fails to trigger on `WKWebView`s when the loaded HTML page has a
`touchStart` event handler that calls `e.preventDefault()` within iOS 13.4.  This was discovered for `WKWebView`s within
an `InputViewController`, hence the structure of the reproduction.

In earlier versions of iOS before 13.4, longpress handlers would still trigger in this scenario, as seen by running
this against iOS 13.3 (or before) in the Simulator.
