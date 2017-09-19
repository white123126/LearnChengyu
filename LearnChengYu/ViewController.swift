//
//  ViewController.swift
//  LearnChengYu
//
//  Created by white on 2017/9/14.
//  Copyright © 2017年 com.kkdl. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    let tableView = UITableView.init(frame: CGRect.zero, style: UITableViewStyle.plain)
    let cellIdentifier = "MainViewCell"
    let titles = ["全部成语","完形填空","释义选择","成语选择"]
    var pinyins:Array<Any>! = []
    override func viewDidLoad() {
        super.viewDidLoad()
        for title in titles {
            pinyins.append(title.pingyin())
        }
        tableView.register(KKChengYuCell.classForCoder(), forCellReuseIdentifier:cellIdentifier)
        tableView.tableFooterView = UIView.init();
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalTo(self.view)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.showAllChengYu()
            break
        case 1:
            
            break
        case 2:
            self.showLearnView(type: .ChengYuSelectShiYi)
            break
        case 3:
            self.showLearnView(type: .ShiYiSelectChengYu)
            break
        default:
            break
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.size.height/CGFloat(self.titles.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:KKChengYuCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! KKChengYuCell
        cell.chengyuLabel.chengyuFontSize = 30
        cell.chengyuLabel.pinyinFontSize = 20
        let chengyu = KKChengYu.init()
        chengyu.title = titles[indexPath.row]
        chengyu.pinyin = pinyins[indexPath.row] as! String
        cell.alignment = NSTextAlignment.center
        cell.chengyu = chengyu
        
        return cell
    }
    
    func showAllChengYu() {
        self.navigationController?.pushViewController(KKChengYuListViewController(), animated: true)
    }
    func showLearnView(type:KKLearnViewType) {
        let learnView = KKLearnViewController()
        learnView.viewType = type
        self.navigationController?.pushViewController(learnView, animated: true)
    }
}


