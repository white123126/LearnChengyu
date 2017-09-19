//
//  KKChengYu.swift
//  LearnChengYu
//
//  Created by white on 2017/9/14.
//  Copyright © 2017年 com.kkdl. All rights reserved.
//

import UIKit
import FMDB

class KKChengYu: NSObject {
    
    var title: String! = nil //成语
    var pinyin: String! = nil // 拼音
    var shiyi: String! = nil // 释 义
    var chuchu: String! = nil //出处
    var number = 0 //字数
    var showAll = true // 是否全部显示
    var hidenIndex = -1 //隐藏字的位置 小于0等于showAll
    var id = 0
    
    override init() {
        super.init()
    }
    
    convenience init(_ obj:Dictionary<String, Any>) {
        self.init()
        self.id = Int(obj["id"]! as! String)!
        self.title = obj["title"] as! String
        self.pinyin = obj["pinyin"] as! String
        self.shiyi = obj["shiyi"] as! String
        self.chuchu = obj["chuchu"] as! String
        self.number = obj["number"] as! Int
    }
    
    func randomHiden() {
        let num = arc4random()
        self.hidenIndex = Int(num) % self.number
        self.showAll = false
    }
    
    //随机获取几个其他成语的释义
    func randomShiyi(_ count: Int) -> Array<String> {
        let db = KKDBManager.currentUser.db!
        db.open()
        let results = try! db.executeQuery("select shiyi from chengyu where id != ? order by RANDOM() limit ?", values: [self.id,count])
        var array = Array<String>()
        while results.next() {
            let shiyi = results.string(forColumn:"shiyi")
            array.append(shiyi!)
        }
        db.close()
        return array
    }
    
    //随机获取几个成语
    class func randomChengYu(_ count:Int , number: Int) -> Array<KKChengYu> {
        return KKDBManager.currentUser.randomChengYu(count:count, number:number)
    }
    
    class func all() -> Array<KKChengYu> {
        return KKDBManager.currentUser.allChengYu()
    }
}
