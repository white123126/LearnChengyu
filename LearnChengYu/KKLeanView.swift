//
//  KKLeanView.swift
//  LearnChengYu
//
//  Created by white on 2017/9/18.
//  Copyright © 2017年 com.kkdl. All rights reserved.
//

import UIKit
import SnapKit

enum KKLearnViewType {
    case ChengYuSelectShiYi
    case ShiYiSelectChengYu
}

class KKLeanView: UIView {
    var wrongAnswers:Array<String>!
    var viewType: KKLearnViewType = .ChengYuSelectShiYi
    var chengyu: KKChengYu? {
        didSet {
            if chengyu != nil {
                if viewType == .ChengYuSelectShiYi {
                    wrongAnswers = chengyu?.randomShiyi(3)
                    wrongAnswers.append((chengyu?.shiyi)!)
                    wrongAnswers.sort { (str0, strq) -> Bool in
                        let random = arc4random()%2
                        return random == 0 ? false : true
                    }
                    for i in 0..<wrongAnswers.count {
                        let string = wrongAnswers[i]
                        if string == chengyu?.shiyi {
                            index = i
                            break
                        }
                    }
                }else {
                    wrongAnswers = KKDBManager.sharedManager().randomChengYuTitle(count: 3, number: 0)
                    wrongAnswers.append((chengyu?.title)!)
                    wrongAnswers.sort { (str0, strq) -> Bool in
                        let random = arc4random()%2
                        return random == 0 ? false : true
                    }
                    for i in 0..<wrongAnswers.count {
                        let string = wrongAnswers[i]
                        if string == chengyu?.title {
                            index = i
                            break
                        }
                    }
                }
            }
            self.reloadSubviews()
        }
    }
    var haveMore = true
    var index:Int = 0 //正确选项
    var issueIndex = 1
    let issueLabel:UILabel = UILabel.init(frame: CGRect.zero)
    let answerView:KKAnswerView = KKAnswerView.init(frame: CGRect.zero)
    let nextButton:UIButton = UIButton.init(frame: CGRect.zero)
    
    override init(frame: CGRect) {
        self.chengyu = nil
        super.init(frame: frame)
        self.addSubview(issueLabel)
        self.addSubview(answerView)
        self.addSubview(nextButton)
        self.issueLabel.numberOfLines = 0
        self.issueLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(20)
            make.right.equalTo(self).offset(-20)
            make.top.equalTo(self).offset(30)
        }
        self.issueLabel.font = UIFont.systemFont(ofSize: 35)
        self.issueLabel.textColor = UIColor.black
        
        self.answerView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(20)
            make.top.equalTo(issueLabel.snp.bottom).offset(50)
            make.right.equalTo(self).offset(-20)
        }
        self.nextButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(80)
            make.height.equalTo(40)
            make.top.equalTo(answerView.snp.bottom).offset(40)
        }
        self.nextButton.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        self.nextButton.setTitleColor(UIColor.black, for: UIControlState.normal)
    }
    
    convenience init(frame: CGRect, index:Int, chengyu:KKChengYu) {
        self.init(frame: frame)
        self.index = index
        self.chengyu = chengyu
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func reloadSubviews() {
        if viewType == .ChengYuSelectShiYi {
            self.issueLabel.text = String.init(format: "%d、", arguments: [issueIndex]) + (chengyu?.title)!
        }else {
            self.issueLabel.text = String.init(format: "%d、", arguments: [issueIndex]) + (chengyu?.shiyi)!
            self.issueLabel.font = UIFont.systemFont(ofSize: 20)
        }
        
        self.answerView.answers = wrongAnswers
        if haveMore {
            nextButton.setTitle("下一题", for: UIControlState.normal)
        }else {
            nextButton.setTitle("完成", for: UIControlState.normal)
        }
    }
}


class KKAnswerView: UIView {
    
    var answers:Array<String>? {
        didSet {
            self.relayoutSubviews()
        }
    }
    var answerLaebls:Array<UILabel> = []
    var selectedCallBack:(Int)->Void = {_ in }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect,ansers:Array<String>?,selected:@escaping (Int)->Void) {
        self.init(frame: frame)
        self.answers = answers!
        selectedCallBack = selected
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func relayoutSubviews() {
        let items = ["A、 ","B、 ","C、 ","D、 "]
        let count = answers?.count
        for i in 0..<count! {
            let answer = items[i] + (answers?[i])!
            if i < answerLaebls.count {
                let label = answerLaebls[i]
                label.text = answer
                if (i>0) {
                    let upLabel = answerLaebls[i-1]
                    label.snp.updateConstraints({ (make) in
                        make.left.equalTo(self).offset(20)
                        make.top.equalTo(upLabel.snp.bottom).offset(20)
                        make.right.equalTo(self).offset(-20)
                        if i == (answers?.count)! - 1 {
                            make.bottom.equalTo(self).offset(-20)
                        }
                    })
                }else {
                    label.snp.updateConstraints({ (make) in
                        make.left.equalTo(self).offset(20)
                        make.top.equalTo(self).offset(20)
                        make.right.equalTo(self).offset(-20)
                    })
                }
            }else {
                let label = UILabel.init(frame: CGRect.zero)
                label.backgroundColor = UIColor.clear
                label.font = UIFont.systemFont(ofSize: 15)
                label.numberOfLines = 0
                label.text = answer
                self.addSubview(label)
                if (i>0) {
                    let upLabel = answerLaebls[i-1]
                    label.snp.makeConstraints({ (make) in
                        make.left.equalTo(self).offset(20)
                        make.top.equalTo(upLabel.snp.bottom).offset(20)
                        make.right.equalTo(self).offset(-20)
                        if i == (answers?.count)! - 1 {
                            make.bottom.equalTo(self).offset(-20)
                        }
                    })
                }else {
                    label.snp.makeConstraints({ (make) in
                        make.left.equalTo(self).offset(20)
                        make.top.equalTo(self).offset(20)
                        make.right.equalTo(self).offset(-20)
                    })
                }
                answerLaebls.append(label)
            }
        }
    }
}
