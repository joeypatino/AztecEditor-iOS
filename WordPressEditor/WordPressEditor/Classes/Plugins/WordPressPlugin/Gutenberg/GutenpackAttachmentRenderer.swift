import Aztec
import Foundation
import UIKit


/// Renders self-closing Gutenberg blocks.
final public class GutenpackAttachmentRenderer {
    
    /// Text Color
    ///
    var textColor = UIColor.gray
    
    public init() {}
}

extension GutenpackAttachmentRenderer: TextViewAttachmentImageProvider {
    
    public func textView(_ textView: AztecTextView, shouldRender attachment: NSTextAttachment) -> Bool {
        return attachment is GutenpackAttachment
    }
    
    public func textView(_ textView: AztecTextView, imageFor attachment: NSTextAttachment, with size: CGSize) -> UIImage? {
        guard let attachment = attachment as? GutenpackAttachment else {
            return nil
        }
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        
        let label = attachment.blockName.uppercased()
        let colorMessage = NSAttributedString(string: label, attributes: [.foregroundColor: textColor])
        
        let textRect = colorMessage.boundingRect(with: size, options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil)
        let textPosition = CGPoint(x: ((size.width - textRect.width) * 0.5), y: ((size.height - textRect.height) * 0.5))
        colorMessage.draw(in: CGRect(origin: textPosition, size: CGSize(width: size.width, height: textRect.size.height)))
        
        let path = UIBezierPath()
        
        let dashes = [ Constants.defaultDashCount, Constants.defaultDashCount ]
        path.setLineDash(dashes, count: dashes.count, phase: 0.0)
        path.lineWidth = Constants.defaultDashWidth
        
        let centerY = round(size.height * 0.5)
        path.move(to: CGPoint(x: 0, y: centerY))
        path.addLine(to: CGPoint(x: ((size.width - textRect.width) * 0.5) - Constants.defaultDashWidth, y: centerY))
        
        path.move(to: CGPoint(x: ((size.width + textRect.width) * 0.5) + Constants.defaultDashWidth, y: centerY))
        path.addLine(to: CGPoint(x: size.width, y: centerY))
        
        textColor.setStroke()
        path.stroke()
        
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return result
    }
    
    public func textView(_ textView: AztecTextView, boundsFor attachment: NSTextAttachment, with lineFragment: CGRect) -> CGRect {
        let padding = textView.textContainer.lineFragmentPadding
        let width = lineFragment.width - padding * 2
        
        return CGRect(origin: .zero, size: CGSize(width: width, height: Constants.defaultHeight))
    }
}


// MARK: - Constants
//
extension GutenpackAttachmentRenderer {
    
    struct Constants {
        static let defaultDashCount = CGFloat(8.0)
        static let defaultDashWidth = CGFloat(2.0)
        static let defaultHeight = CGFloat(44.0)
    }
}
