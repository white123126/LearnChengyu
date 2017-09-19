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
        let string = NSMutableString.init(string: self)
        var range = CFRangeMake(0, self.characters.count)
        
        CFStringTransform(string as CFMutableString, &range, kCFStringTransformMandarinLatin, false)
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
        return self[Range(start ..< end)]
    }
}

extension KKChengYu {
    
    //    //随机获取几个汉字
    //    func randomKanJi(_ count: Int) -> Array<String> {
    //
    //    }
    //
    
    
}
