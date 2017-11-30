//
//  KKExtension.swift
//  LearnChengYu
//
//  Created by white on 2017/9/14.
//  Copyright © 2017年 com.kkdl. All rights reserved.
//

import UIKit

extension String {
    func pingyin() -> String! {
        var string = NSMutableString.init(string: self)
        var range = CFRangeMake(0, self.count)
        CFStringTransform(string as CFMutableString, &range, kCFStringTransformMandarinLatin, false)
        let symbols = ["\u{3002}","\u{FF1F}","\u{FF01}","\u{FF0C}","\u{3001}","\u{FF1B}","\u{FF1A}","\u{300C}","\u{300D}","\u{300E}","\u{300F}","\u{2018}","\u{2019}","\u{201C}","\u{201D}","\u{FF08}","\u{FF09}","\u{3014}","\u{3015}","\u{3010}","\u{3011}","\u{2014}","\u{2026}","\u{2013}","\u{FF0E}","\u{300A}","\u{300B}","\u{3008}","\u{3009}","·"]
        
        for i in 0 ..< symbols.count {
            let s = symbols[i] as String!
            string = string.replacingOccurrences(of: s!, with: " "+s!+" ") as! NSMutableString
        }
        
        return string.copy() as! String
    }
}

extension String {
    
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    subscript (r: Range<Int>) -> String {
        let start = index(startIndex, offsetBy: r.lowerBound)
        let end = index(startIndex, offsetBy: r.upperBound)
        return String(self[Range(start ..< end)])
    }
}

extension KKChengYu {
    
    //    //随机获取几个汉字
    //    func randomKanJi(_ count: Int) -> Array<String> {
    //
    //    }
    //
    
    
}
