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
  @IBOutlet weak var inputField: UITextField!
  @IBOutlet weak var inputField2: UITextField!

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    inputField.inputView = KeyboardViewController().inputView
    inputField.reloadInputViews()
  }
}

