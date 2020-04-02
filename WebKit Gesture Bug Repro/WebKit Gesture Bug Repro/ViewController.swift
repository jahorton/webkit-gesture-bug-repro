//
//  ViewController.swift
//  WebKit Gesture Bug Repro
//
//  Created by Joshua Horton on 4/2/20.
//  Copyright © 2020 Joshua Horton. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {
  @IBOutlet weak var webView: WKWebView!

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }

  @IBAction func longPressAction(_ sender: UILongPressGestureRecognizer) {
    if sender.state == .began {
      let alertController = UIAlertController(title: nil, message:
            "Long-Press Gesture Detected", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default,handler: nil))

        present(alertController, animated: true, completion: nil)
    }
  }

  public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                                shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
    return true
  }
}

