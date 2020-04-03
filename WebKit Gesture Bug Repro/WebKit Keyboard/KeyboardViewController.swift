//
//  KeyboardViewController.swift
//  WebKit Keyboard
//
//  Created by Joshua Horton on 4/2/20.
//  Copyright © 2020 Joshua Horton. All rights reserved.
//

import UIKit
import WebKit

class KeyboardViewController: UIInputViewController, UIGestureRecognizerDelegate, WKScriptMessageHandler {
  func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
    guard let fragment = message.body as? String, !fragment.isEmpty else {
      return
    }

    NSLog("Message received: \(fragment)")
  }

  var webView: WKWebView?
  var longPressRecognizer: UILongPressGestureRecognizer?

  @objc func longPressHandler(_ sender: UILongPressGestureRecognizer) {
    if sender.state == .began {
      let alertController = UIAlertController(title: nil, message:
            "Long-Press Gesture Detected", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default,handler: nil))

        NSLog("longPressHandler has seen .began")

        //present(alertController, animated: true, completion: nil)
    }
  }

  public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                                shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
    return true
  }

  override func updateViewConstraints() {
    super.updateViewConstraints()

    // Add custom view sizing constraints here
    let heightConstraint = self.inputView!.heightAnchor.constraint(equalToConstant: 250)
    //heightConstraint.priority = UILayoutPriority(rawValue: 999)
    heightConstraint.isActive = true
  }

  override func loadView() {
    super.loadView()

    let config = WKWebViewConfiguration()
    let prefs = WKPreferences()
    prefs.javaScriptEnabled = true
    config.preferences = prefs
    config.suppressesIncrementalRendering = false

    let userContentController = WKUserContentController()
    userContentController.add(self, name: "keyman")
    config.userContentController = userContentController

    webView = WKWebView(frame: CGRect.zero, configuration: config)
    webView!.isOpaque = false
    webView!.translatesAutoresizingMaskIntoConstraints = false
    webView!.backgroundColor = UIColor.red
    webView!.scrollView.isScrollEnabled = false

    view.addSubview(webView!)
    view.translatesAutoresizingMaskIntoConstraints = false
    view.autoresizingMask = UIView.AutoresizingMask.flexibleHeight.union(.flexibleWidth)
    view.backgroundColor = UIColor.green
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    webView!.topAnchor.constraint(equalTo: view!.safeAreaLayoutGuide.topAnchor).isActive = true
    webView!.heightAnchor.constraint(equalTo: view!.safeAreaLayoutGuide.heightAnchor).isActive = true
    webView!.leftAnchor.constraint(equalTo: view!.safeAreaLayoutGuide.leftAnchor).isActive = true
    webView!.widthAnchor.constraint(equalTo: view!.safeAreaLayoutGuide.widthAnchor).isActive = true

    view.heightAnchor.constraint(greaterThanOrEqualToConstant: 200).isActive = true

    longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.longPressHandler))
    longPressRecognizer!.minimumPressDuration = 0.5
    longPressRecognizer!.delegate = self
    webView!.addGestureRecognizer(longPressRecognizer!)

    let webBundle = Bundle(path: Bundle.main.path(forResource: "webview-contents", ofType: "bundle")!)!
    let page = webBundle.url(forResource: "index", withExtension: "html")!

    webView!.loadFileURL(page, allowingReadAccessTo: webBundle.resourceURL!)
  }

  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
  }
}
