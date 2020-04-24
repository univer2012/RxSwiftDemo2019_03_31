//
//  SHRxswift_62MyTableViewCell.swift
//  RxSwiftDemo2019_03_31
//
//  Created by 远平 on 2019/11/24.
//  Copyright © 2019 远平. All rights reserved.
//

import UIKit
import RxSwift

//单元格类
class SHRxswift_62MyTableViewCell: UITableViewCell {
    
    var button: UIButton!
    
    var disposeBag = DisposeBag()
    
    //单元格重用时调用
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }

    //初始化
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //添加按钮
        button = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 25))
        button.setTitle("点击", for: .normal)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        addSubview(button)
    }
    
    //布局
    override func layoutSubviews() {
        super.layoutSubviews()
        button.center = CGPoint(x: bounds.size.width - 35, y: bounds.midY)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
