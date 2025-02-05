import Foundation
import Aztec
import UIKit

class TextViewStubAttachmentDelegate: TextViewAttachmentDelegate, TextViewAttachmentImageProvider {

    func textView(_ textView: AztecTextView, attachment: NSTextAttachment, imageAt url: URL, onSuccess success: @escaping (UIImage) -> Void, onFailure failure: @escaping () -> Void) {
        // NO OP!
    }

    func textView(_ textView: AztecTextView, placeholderFor attachment: NSTextAttachment) -> UIImage {
        return placeholderImage(for: attachment)
    }

    func placeholderImage(for attachment: NSTextAttachment) -> UIImage {
        let placeholderImage: UIImage
        switch attachment {
        case _ as ImageAttachment:
            placeholderImage = UIImage()
        case _ as VideoAttachment:
            placeholderImage = UIImage()
        default:
            placeholderImage = UIImage()

        }

        return placeholderImage
    }

    func textView(_ textView: AztecTextView, urlFor imageAttachment: ImageAttachment) -> URL? {
        return nil
    }

    func textView(_ textView: AztecTextView, deletedAttachment attachment: MediaAttachment) {

    }

    func textView(_ textView: AztecTextView, selected attachment: NSTextAttachment, atPosition position: CGPoint) {
    }
    
    func textView(_ textView: AztecTextView, deselected attachment: NSTextAttachment, atPosition position: CGPoint) {        
    }

    func textView(_ textView: AztecTextView, shouldRender attachment: NSTextAttachment) -> Bool {
        return true
    }

    func textView(_ textView: AztecTextView, boundsFor attachment: NSTextAttachment, with lineFragment: CGRect) -> CGRect {
        return CGRect.zero
    }

    func textView(_ textView: AztecTextView, imageFor attachment: NSTextAttachment, with size: CGSize) -> UIImage? {
        return nil
    }
}
