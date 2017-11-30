import UIKit
class KKChengYuLabel: UILabel {
    var title: String = ""
    var pinyin: String = ""
    var chengyu:KKChengYu? {
        didSet {
            self.clean = true
            var rect = self.frame
            rect.size = self.intrinsicContentSize
            self.drawText(in: rect)
            if chengyu != nil {
                title  = (chengyu?.title)!
                pinyin = (chengyu?.pinyin)!
                self.drawText(in: CGRect.zero)
            }
        }
    }
    override var text: String? {
        didSet {
            title = text!
            pinyin = (text?.pingyin())!
            self.drawText(in: CGRect.zero)
        }
    }
    var pinyinFontSize: CGFloat!
    var chengyuFontSize:CGFloat!
    var height: CGFloat!
    var width : CGFloat!
    var clean: Bool {
        didSet {
            self.text = ""
            self.drawText(in: self.bounds)
        }
    }
    var hidenIndex = -1
    
    override init(frame: CGRect) {
        title = ""
        pinyin = ""
        clean = false
        super.init(frame: frame)
        
        if width == nil {
            height = 0.0
            width = 0.0
        }
        if pinyinFontSize == nil {
            pinyinFontSize = 12
        }
        if chengyuFontSize == nil {
            chengyuFontSize = 16
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawText(in rect: CGRect) {
        height = 0.0
        if (clean == true) {
            super.drawText(in: rect)
            let context = UIGraphicsGetCurrentContext()
            context?.saveGState()
            context?.clip(to: rect)
            "".draw(in: CGRect(x: rect.origin.x, y: rect.origin.y , width: rect.size.width, height: rect.size.height), withAttributes: nil)
            context?.restoreGState()
            clean = false
            return
        }
        
//        if (rect.size.width < 1) {
//            return;
//        }
        var pinyinTmp = pinyin
        pinyinTmp = pinyinTmp.replacingOccurrences(of: "  ", with: " ")
        var arrP = pinyinTmp.components(separatedBy: " ")
        if arrP.count < 2 {
            return
        }
        var array:[String] = []
        for i in 0..<arrP.count {
            let s = arrP[i] as String
            if s != " " {
                array.append(s)
            }
        }
        arrP = array
        
        var left = 10
        var top = 10;
        let context = UIGraphicsGetCurrentContext()
        var textContent = "zhuèng"
        let textStyle = NSMutableParagraphStyle()
        textStyle.alignment = .center
        var textFontAttributes = [NSAttributedStringKey.font: UIFont(name: "HelveticaNeue", size: pinyinFontSize)!, NSAttributedStringKey.foregroundColor: UIColor.gray, NSAttributedStringKey.paragraphStyle: textStyle]
        
        var size = textContent.boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: textFontAttributes, context: nil)
        var textWidth: CGFloat = size.width
        
        textContent = "我"
        textFontAttributes = [NSAttributedStringKey.font: UIFont(name: "HelveticaNeue", size: chengyuFontSize)!, NSAttributedStringKey.foregroundColor: UIColor.gray, NSAttributedStringKey.paragraphStyle: textStyle]
        size = textContent.boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: textFontAttributes, context: nil)
        textWidth = textWidth > size.width ? textWidth : size.width
        
        for i in 0 ..< arrP.count {
            let character = arrP[i]
            if character == "" {
                return
            }
            
            var textTextContent = character
            let textStyle = NSMutableParagraphStyle()
            textStyle.alignment = .center
            var textColor = UIColor.gray
            if i == hidenIndex {
                textColor = UIColor.clear
            }
            var textFontAttributes:[NSAttributedStringKey : Any] = [NSAttributedStringKey.font: UIFont(name: "HelveticaNeue", size: pinyinFontSize)!,
                                      NSAttributedStringKey.foregroundColor: textColor,
                                      NSAttributedStringKey.paragraphStyle: textStyle.copy()]
            
            var size = textTextContent.boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: textFontAttributes, context: nil)
            var textTextHeight: CGFloat = size.height + 2
            var textRect = CGRect(x: left , y: top, width:Int(textWidth), height: Int(textTextHeight))
            context?.saveGState()
            context?.clip(to: textRect)
            textTextContent.draw(in: CGRect(x: textRect.minX, y: textRect.minY + (textRect.height - textTextHeight) / 2, width: textWidth, height: textTextHeight), withAttributes: textFontAttributes)
            context?.restoreGState()
            
            textRect = CGRect(x: left, y: top + Int(textTextHeight), width: Int(textWidth), height: Int(textTextHeight))
            textTextContent = title[i]
            textColor = UIColor.black
            if i == hidenIndex {
                textColor = UIColor.clear
            }
            textFontAttributes = [NSAttributedStringKey(rawValue: NSAttributedStringKey.font.rawValue): UIFont(name: "HelveticaNeue", size: chengyuFontSize)!, NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue): textColor, NSAttributedStringKey(rawValue: NSAttributedStringKey.paragraphStyle.rawValue): textStyle]
            
            size = textTextContent.boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: textFontAttributes, context: nil)
            textTextHeight = size.height
            textRect.size.height = textTextHeight
            
            context?.saveGState()
            context?.clip(to: textRect)
            textTextContent.draw(in: CGRect(x: textRect.minX, y: textRect.minY + (textRect.height - textTextHeight) / 2, width: textWidth, height: textTextHeight), withAttributes: textFontAttributes)
            
            left += Int(textWidth)
            context?.restoreGState()
            height = textRect.minY + (textRect.height - textTextHeight) / 2 + textTextHeight
            width = CGFloat(left)
            print(height)
            print(textTextContent)
            if (left + Int(textWidth)) > Int(UIScreen.main.bounds.size.width - 40) {
                left = 10
                top = Int(height)
                top += 5
            }
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize.init(width: width, height: height)
    }
}
