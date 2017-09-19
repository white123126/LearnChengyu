import UIKit
class KKChengYuLabel: UILabel {
    var title: String = ""
    var pinyin: String = ""
    var chengyu:KKChengYu? {
        didSet {
            title  = (chengyu?.title)!
            pinyin = (chengyu?.pinyin)!
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
        if (clean == true) {
            super.drawText(in: rect)
            clean = false
            return
        }
        
        var pinyinTmp = pinyin
        pinyinTmp = pinyinTmp.replacingOccurrences(of: "，", with: "， ")
        var arrP = pinyinTmp.components(separatedBy: " ")
        if arrP.count < 2 {
            return
        }
        pinyinTmp = ""
        
        for i in 0..<arrP.count {
            let str = arrP[i]
            if str != "" {
                if str.contains("，"){
                    let string = str.replacingOccurrences(of: " ", with: "")
                    pinyinTmp += string.components(separatedBy: "，").first!
                    pinyinTmp += " "
                    pinyinTmp += "，"
                    pinyinTmp += " "
                }else {
                    pinyinTmp += str
                    if i < arrP.count - 1 {
                        pinyinTmp += " "
                    }
                }
            }
        }

        arrP = pinyinTmp.components(separatedBy: " ")
        
        var left = 10
        let context = UIGraphicsGetCurrentContext()
        var textContent = "zhuèng"
        let textStyle = NSMutableParagraphStyle()
        textStyle.alignment = .center
        var textFontAttributes = [NSFontAttributeName: UIFont(name: "HelveticaNeue", size: pinyinFontSize)!, NSForegroundColorAttributeName: UIColor.gray, NSParagraphStyleAttributeName: textStyle]
        
        var size = textContent.boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: textFontAttributes, context: nil)
        var textWidth: CGFloat = size.width
        
        textContent = "我"
        textFontAttributes = [NSFontAttributeName: UIFont(name: "HelveticaNeue", size: chengyuFontSize)!, NSForegroundColorAttributeName: UIColor.gray, NSParagraphStyleAttributeName: textStyle]
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
            var textFontAttributes = [NSFontAttributeName: UIFont(name: "HelveticaNeue", size: pinyinFontSize)!, NSForegroundColorAttributeName: textColor, NSParagraphStyleAttributeName: textStyle] as [String : Any]
            
            var size = textTextContent.boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: textFontAttributes, context: nil)
            var textTextHeight: CGFloat = size.height + 2
            var textRect = CGRect(x: left , y: 10, width:Int(textWidth), height: Int(textTextHeight))
            context?.saveGState()
            context?.clip(to: textRect)
            textTextContent.draw(in: CGRect(x: textRect.minX, y: textRect.minY + (textRect.height - textTextHeight) / 2, width: textWidth, height: textTextHeight), withAttributes: textFontAttributes)
            context?.restoreGState()
            
            

            
            textRect = CGRect(x: left, y: Int(textTextHeight)+10, width: Int(textWidth), height: Int(textTextHeight))
            textTextContent = title[i]
            textColor = UIColor.black
            if i == hidenIndex {
                textColor = UIColor.clear
            }
            textFontAttributes = [NSFontAttributeName: UIFont(name: "HelveticaNeue", size: chengyuFontSize)!, NSForegroundColorAttributeName: textColor, NSParagraphStyleAttributeName: textStyle]
            
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
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize.init(width: width, height: height)
    }
}
