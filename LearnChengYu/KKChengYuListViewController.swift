//
//  KKChengYuListViewController.swift
//  LearnChengYu
//
//  Created by white on 2017/9/15.
//  Copyright © 2017年 com.kkdl. All rights reserved.
//

import UIKit
import SnapKit
class KKChengYuListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var dataSource: Array = KKDBManager.sharedManager().chengyuList(limit: 100, lastId: 0)
    var tableView: UITableView = UITableView.init(frame: CGRect.zero, style: UITableViewStyle.plain)
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "成语列表"
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(KKChengYuCell.classForCoder(), forCellReuseIdentifier: "CHENGYULISTCELL")
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.left.bottom.right.top.equalTo(self.view)
        }
        self.navigationController?.navigationBar.isHidden = false
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        weak var weakSelf = self
        DispatchQueue.global().async {
            let count = KKDBManager.sharedManager().countOfChengyu
            if (weakSelf?.dataSource.count)! <  count{
                let array = KKDBManager.sharedManager().chengyuList(limit: count - (weakSelf?.dataSource.count)!, lastId: (weakSelf?.dataSource.last?.id)!)
                if array.count > 0 {
                    weakSelf?.dataSource = (weakSelf?.dataSource)!+array
                    DispatchQueue.main.async {
                        weakSelf?.tableView.reloadData()
                    }
                }
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let info = KKChengYuInfoViewController()
        info.chengyu = self.dataSource[indexPath.row]
        self.navigationController?.pushViewController(info, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let chengyu = self.dataSource[indexPath.row]
        let identifier = "CHENGYULISTCELL"
        let cell: KKChengYuCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! KKChengYuCell
        
        cell.chengyu = chengyu
        return cell
    }
}
