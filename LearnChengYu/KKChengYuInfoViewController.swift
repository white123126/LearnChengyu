//
//  KKChengYuInfoViewController.swift
//  LearnChengYu
//
//  Created by white on 2017/9/15.
//  Copyright © 2017年 com.kkdl. All rights reserved.
//

import UIKit
import SnapKit

class KKChengYuInfoViewController: UIViewController {
    var chengyu: KKChengYu!
    var chengyuLabel = KKChengYuLabel.init(frame: CGRect.zero)
    let scrollView: UIScrollView = UIScrollView.init()
    let chuchuLabel: KKChengYuLabel = KKChengYuLabel.init(frame: CGRect.zero)
    let shiyiLable: KKChengYuLabel = KKChengYuLabel.init(frame: CGRect.zero)
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = chengyu.title
        self.view.backgroundColor = UIColor.white;
        self.view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        scrollView.backgroundColor = UIColor.clear
        scrollView.addSubview(self.chengyuLabel)
        scrollView.addSubview(self.chuchuLabel)
        scrollView.addSubview(self.shiyiLable)
        
        self.chengyuLabel.chengyuFontSize = self.view.bounds.size.width / CGFloat(chengyu.title.count) / 2.0
        self.chengyuLabel.pinyinFontSize = self.chengyuLabel.chengyuFontSize/2.0
        self.chengyuLabel.chengyu = chengyu
        
        self.chuchuLabel.backgroundColor = UIColor.clear
        self.chuchuLabel.font = UIFont.systemFont(ofSize: 16)
        self.chuchuLabel.textColor = UIColor.gray
        self.chuchuLabel.text = "出自："+chengyu.chuchu
        self.chuchuLabel.numberOfLines = 0
               
        self.shiyiLable.backgroundColor = UIColor.clear
        self.shiyiLable.font = UIFont.systemFont(ofSize: 16)
        self.shiyiLable.textColor = UIColor.black
        self.shiyiLable.text = "释义："+chengyu.shiyi
        self.shiyiLable.numberOfLines = 0
       
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.chengyuLabel.sizeToFit()
        let size_label = self.chengyuLabel.intrinsicContentSize
        self.chengyuLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(scrollView).offset(20)
            make.width.equalTo(size_label.width)
            make.height.equalTo(size_label.height)
        }
        self.chuchuLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.view.snp.left).offset(20)
            make.top.equalTo(self.chengyuLabel.snp.bottom).offset(40)
            make.right.equalTo(self.view.snp.right).offset(-20)
            make.height.equalTo(self.chuchuLabel.height)
        }
        self.shiyiLable.snp.makeConstraints { (make) in
            make.left.equalTo(self.view.snp.left).offset(20)
            make.top.equalTo(self.chuchuLabel.snp.bottom).offset(40)
            make.right.equalTo(self.view.snp.right).offset(-20)
            make.height.equalTo(self.shiyiLable.height)
            make.bottom.equalTo(scrollView).offset(-50)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
