//
//  KKLearnViewController.swift
//  LearnChengYu
//
//  Created by white on 2017/9/15.
//  Copyright © 2017年 com.kkdl. All rights reserved.
//

import UIKit
import SnapKit
class KKLearnViewController: UIViewController {
    let learnView: KKLeanView = KKLeanView.init(frame: CGRect.zero)
    var viewType: KKLearnViewType = .ChengYuSelectShiYi
    var chengyus: Array<KKChengYu>!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        chengyus = KKDBManager.sharedManager().randomChengYu(count: 20, number: 4)
        self.view.addSubview(learnView)
        learnView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(84)
            make.left.right.bottom.equalTo(self.view)
        }
        learnView.viewType = viewType
        learnView.chengyu = chengyus.first
        learnView.issueIndex = 1
        self.navigationController?.navigationBar.isHidden = false
        learnView.nextButton.addTarget(self, action: #selector(KKLearnViewController.nextIssue), for: UIControlEvents.touchUpInside)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func nextIssue() {
        if learnView.issueIndex < chengyus.count {
            
            if (learnView.issueIndex == chengyus.count - 1) {
                learnView.nextButton.setTitle("完成", for: UIControlState.normal)
            }
            learnView.issueIndex += 1
            learnView.chengyu = chengyus[learnView.issueIndex - 1]
        }
    }
    
}
