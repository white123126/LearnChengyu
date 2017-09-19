//
//  KKChengYuCell.swift
//  LearnChengYu
//
//  Created by white on 2017/9/15.
//  Copyright © 2017年 com.kkdl. All rights reserved.
//

import UIKit
import SnapKit
class KKChengYuCell: UITableViewCell {
    let chengyuLabel = KKChengYuLabel.init(frame: CGRect.zero)
    var alignment:NSTextAlignment = NSTextAlignment.left
    var chengyu:KKChengYu? {
        didSet {
            chengyuLabel.removeFromSuperview()
            self.addSubview(chengyuLabel)
            chengyuLabel.chengyu = chengyu
            let size = chengyuLabel.intrinsicContentSize
            let x = self.bounds.size.width - size.width
            let y = self.bounds.size.height - size.height
            chengyuLabel.snp.updateConstraints{ (make) in
                if alignment == NSTextAlignment.left {
                    make.left.equalTo(self)
                }else if alignment == NSTextAlignment.center {
                    make.left.equalTo(self).offset(x/2.0)
                }else {
                    make.right.equalTo(self)
                }
                make.top.equalTo(self).offset(y/2.0)
                make.width.equalTo(size.width)
                make.height.equalTo(size.height)
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        chengyu = nil
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

