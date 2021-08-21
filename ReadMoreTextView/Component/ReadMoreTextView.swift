//
//  ReadMoreTextView.swift
//  ReadMoreTextView
//
//  Created by Rajesh Thangaraj on 21/08/21.
//

import UIKit

class ReadMoreTextView: UITextView, UITextViewDelegate {
    private let moreLink = "readmore://moreaction"
    private let lessLink = "readmore://lessaction"
    
    var maxLength: Int?
    var readMoreIdentifier: String?
    var readLessIdentifier: String?
    
    var totalText: String?
    private var readMoreAttributedString: NSMutableAttributedString?
    private var readLessAttributedString: NSMutableAttributedString?
    
    func setText(_ totalText: String) {
        self.totalText = totalText
        delegate = self
        isEditable = false
        isScrollEnabled = false
        
        guard let maxLength = maxLength, let readMoreIdentifier = readMoreIdentifier, let readLessIdentifier = readLessIdentifier, totalText.count > maxLength else {
            return text = totalText
        }
        let minimumText = String(totalText.prefix(maxLength))
        let readMoreString = (minimumText + readMoreIdentifier) as NSString
        let readMoreRange =  readMoreString.range(of: readMoreIdentifier)
        readMoreAttributedString = NSMutableAttributedString(string: readMoreString as String, attributes: [NSAttributedString.Key.font: font ?? UIFont.systemFont(ofSize: 15)])
        readMoreAttributedString?.addAttributes([NSAttributedString.Key.link: moreLink], range: readMoreRange)
        attributedText = readMoreAttributedString
        
        let readLessString = (totalText + readLessIdentifier) as NSString
        let readLessRange =  readLessString.range(of: readLessIdentifier)
        
        readLessAttributedString = NSMutableAttributedString(string: readLessString as String, attributes: [NSAttributedString.Key.font: font ?? UIFont.systemFont(ofSize: 15)])
        readLessAttributedString?.addAttributes([NSAttributedString.Key.link: lessLink], range:readLessRange)
        
    }
    
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        if URL.absoluteString == moreLink {
            attributedText = readLessAttributedString
            return false
        } else if URL.absoluteString == lessLink {
            attributedText = readMoreAttributedString
            return false
        }
        return true
    }
}


