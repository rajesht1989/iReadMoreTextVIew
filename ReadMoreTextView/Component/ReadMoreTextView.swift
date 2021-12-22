//
//  ReadMoreTextView.swift
//  ReadMoreTextView
//
//  Created by Rajesh Thangaraj on 21/08/21.
//

import UIKit

enum ReadMoreActionType {
    case readMore
    case readLess
}

protocol ReadMoreDelegate {
    func readMoreTextView(_ textView: ReadMoreTextView, type: ReadMoreActionType)
}

class ReadMoreTextView: UITextView, UITextViewDelegate {
    private let moreLink = "readmore://moreaction"
    private let lessLink = "readmore://lessaction"

    private var readMoreAttributedString: NSMutableAttributedString?
    private var readLessAttributedString: NSMutableAttributedString?
    
    var readMoreDelegate: ReadMoreDelegate?
    
    var linkFont: UIFont?
    var maxLength: Int?
    var readMoreIdentifier: String?
    var readLessIdentifier: String?
    var totalText: String?
    
    func setText(_ totalText: String) {
        self.totalText = totalText
        delegate = self
        isEditable = false
        isScrollEnabled = false
        
        guard let maxLength = maxLength, let readMoreIdentifier = readMoreIdentifier, totalText.count > maxLength else {
            return text = totalText
        }
        let minimumText = String(totalText.prefix(maxLength))
        let readMoreString = (minimumText + readMoreIdentifier) as NSString
        let readMoreRange =  readMoreString.range(of: readMoreIdentifier)
        readMoreAttributedString = NSMutableAttributedString(string: readMoreString as String, attributes: [NSAttributedString.Key.font: font ?? UIFont.systemFont(ofSize: 15), NSAttributedString.Key.foregroundColor: textColor ?? UIColor.black])
        readMoreAttributedString?.addAttributes([NSAttributedString.Key.link: moreLink], range: readMoreRange)
        configureLinkAttributes(attributedString: readMoreAttributedString, range: readMoreRange)
        attributedText = readMoreAttributedString
        if let readLessIdentifier = readLessIdentifier {
            let readLessString = (totalText + readLessIdentifier) as NSString
            let readLessRange =  readLessString.range(of: readLessIdentifier)
            
            readLessAttributedString = NSMutableAttributedString(string: readLessString as String, attributes: [NSAttributedString.Key.font: font ?? UIFont.systemFont(ofSize: 15)])
            readLessAttributedString?.addAttributes([NSAttributedString.Key.link: lessLink], range:readLessRange)
            configureLinkAttributes(attributedString: readLessAttributedString, range: readLessRange)
        }
    }
    
    func configureLinkAttributes(attributedString: NSMutableAttributedString?, range: NSRange) {
        guard let attributedString = attributedString else {
            return
        }
        attributedString.addAttributes([NSAttributedString.Key.font: linkFont ?? font ?? UIFont.systemFont(ofSize: 15)], range: range)
    }
    
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        if URL.absoluteString == moreLink {
            if let readLessAttributedString = readLessAttributedString {
                attributedText = readLessAttributedString
            }
            readMoreDelegate?.readMoreTextView(self, type: .readMore)
            return false
        } else if URL.absoluteString == lessLink {
            if let readMoreAttributedString = readMoreAttributedString {
                attributedText = readMoreAttributedString
            }
            readMoreDelegate?.readMoreTextView(self, type: .readMore)
            return false
        }
        return true
    }
}


