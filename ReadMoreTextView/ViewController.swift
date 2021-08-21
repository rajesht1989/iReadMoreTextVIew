//
//  ViewController.swift
//  ReadMoreTextView
//
//  Created by Rajesh Thangaraj on 21/08/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textView: ReadMoreTextView! {
        didSet {
            textView.readMoreIdentifier = "..Read more"
            textView.readLessIdentifier = " Read less"
            textView.maxLength = 100
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.setText("Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.")
        
    }


}

