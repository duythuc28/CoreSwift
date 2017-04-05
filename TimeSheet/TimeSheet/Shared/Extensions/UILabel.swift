

import UIKit

extension UILabel {

    // scale font
    override open func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let fontName = self.font.fontName
        let fontSize = self.font.pointSize
        self.font = UIFont(name: fontName, size: fontSize * CGFloat(Constants.FONT_SCALE_VALUE))
    }

    @IBInspectable var localizeKey: String {

        get {
            return ""
        } set {
            self.text = NSLocalizedString(newValue, comment: "")
        }
    }

    @IBInspectable var autoFontScale: Bool {
        get {
            return false
        }
        set (isScale) {
            if isScale {
                if !DeviceType.IS_IPHONE_6P {
                    let newFontSize = font!.pointSize * (isScale ? Constants.RATIO_WIDTH : 1)
                    font = UIFont(name: font.fontName, size: newFontSize)
                }
            }
        }
    }

    @IBInspectable var uppercaseString: Bool {
        get {
            return false
        }
        set {
            if newValue == true {
                self.text = self.text?.uppercased()
            }
        }
    }

    /**
   Height for UILabel
   
   - returns: CGFloat
   */
    func heightForLabel() -> CGFloat {
        let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = self.font
        label.text = self.text
        label.sizeToFit()
        return label.frame.height
    }

}
