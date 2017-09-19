//
//  KKDBManager.swift
//  LearnChengYu
//
//  Created by white on 2017/9/14.
//  Copyright © 2017年 com.kkdl. All rights reserved.
//

import UIKit
import RealmSwift
import SQLite
import FMDB

class KKDBManager: NSObject {
    static let currentUser = KKDBManager()
    var db: FMDatabase! = nil
    var realm = try! Realm()
    var countOfChengyu: Int = 0
    
    class func sharedManager() -> KKDBManager {
        return currentUser;
    }
    
    override init() {
        super.init()
        self.db = FMDatabase.init(path: Bundle.main.path(forResource: "chengyu", ofType: "sqlite"))
        self.db.open()
        let result = try! self.db.executeQuery("SELECT COUNT(id) as cnt FROM chengyu", values: nil)
        if result.next() {
            self.countOfChengyu = Int(result.int(forColumn: "cnt"))
        }
        self.db.close()
    }
    //随机获取几个成语 number 是成语的字数
    func randomChengYu(count:Int , number: Int) -> Array<KKChengYu> {
        self.db.open()
        var sql = ""
        var param: Array<Any>?
        if number > 0 {
            sql = "select * from chengyu where number = ? order by RANDOM() limit ?"
            param = [number,count]
        }else {
            sql = "select * from chengyu order by RANDOM() limit ?"
            param = [count]
        }
        let results = self.db.executeQuery(sql, withArgumentsIn: param!)
        let array = self.chengyusWithFMResultSet(result: results)
        self.db.close()
        return array
    }
    
    //随机获取几个成语名称 number 是成语的字数
    func randomChengYuTitle(count:Int , number: Int) -> Array<String> {
        self.db.open()
        var sql = ""
        var param: Array<Any>?
        if number > 0 {
            sql = "select title from chengyu where number = ? order by RANDOM() limit ?"
            param = [number,count]
        }else {
            sql = "select title from chengyu order by RANDOM() limit ?"
            param = [count]
        }
        let results = self.db.executeQuery(sql, withArgumentsIn: param!)
        var array: Array<String> = []
        while (results?.next())! {
            array.append((results?.string(forColumn: "title"))!)
        }
        self.db.close()
        return array
    }
    
    //获取所有成语
    func allChengYu() -> Array<KKChengYu> {
        self.db.open()
        let results = try! self.db.executeQuery("select * from chengyu", values: nil)
        let array = self.chengyusWithFMResultSet(result: results)
        self.db.close()
        return array
    }
    
    func chengyuList(limit:Int,lastId:Int) -> Array<KKChengYu> {
        self.db.open()
        let results = try! self.db.executeQuery("select * from chengyu ORDER BY id limit ?  OFFSET ?", values: [limit,lastId])
        let array = self.chengyusWithFMResultSet(result: results)
        self.db.close()
        return array
    }
    
    func chengyusWithFMResultSet(result: FMResultSet!) -> Array<KKChengYu> {
        var array = Array<KKChengYu>()
        while (result?.next())! {
            var dic = Dictionary<String,Any>()
            dic["id"] = result?.string(forColumn:"id")
            dic["title"] = result?.string(forColumn:"title")
            let num = result?.string(forColumn:"number")
            dic["number"] = Int(num!)
            dic["chuchu"] = result?.string(forColumn:"chuchu")
            dic["shiyi"] = result?.string(forColumn:"shiyi")
            dic["pinyin"] = result?.string(forColumn:"pinyin")
            array.append(KKChengYu(dic))
        }   
        return array
    }
}
