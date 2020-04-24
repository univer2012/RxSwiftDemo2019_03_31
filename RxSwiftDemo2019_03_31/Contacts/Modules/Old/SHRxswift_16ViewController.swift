//
//  SHRxswift_16ViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by rrd on 2019/7/9.
//  Copyright © 2019 远平. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

#if false //原来的
class SHRxswift_16ViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    var pickerView: UIPickerView!
    //最简单的pickerView适配器（显示普通文本）
    private let stringPickerAdapter = RxPickerViewStringAdapter<[[String]]>(components: [], numberOfComponents: { (dataSource, pickView, components) -> Int in
        components.count
    }, numberOfRowsInComponent: { (dataSource, pickerView, components, component) -> Int in
        return components[component].count
    }) { (adapter, pickerView, components, row, component) -> String? in
        return components[component][row]
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        pickerView = UIPickerView()
        view.addSubview(pickerView)
        //绑定pickerView数据
        Observable.just([["One", "Two", "Three", "Four"],
                         ["A", "B", "C", "D"] ])
        .bind(to: pickerView.rx.items(adapter: stringPickerAdapter))
        .disposed(by: disposeBag)
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        button.center = self.view.center
        button.backgroundColor = .blue
        button.setTitle("获得信息", for: .normal)
        button.rx.tap.bind { [weak self] in
            self?.getPickerViewValue()
        }
        .disposed(by: disposeBag)
        view.addSubview(button)
    }
    //触摸按钮时，获得被选中的索引
    @objc func getPickerViewValue() {
        let message = String(pickerView.selectedRow(inComponent: 0)) + "-" + String(pickerView.selectedRow(inComponent: 1))
        let alertController = UIAlertController(title: "被选中的索引为", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
#elseif false  //MARK: - 修改默认的样式

class SHRxswift_16ViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    var pickerView: UIPickerView!
    //最简单的pickerView适配器（显示普通文本）
    private let attrStringPickerAdapter = RxPickerViewAttributedStringAdapter<[String]>(components: [], numberOfComponents: { (dataSource, pickView, components) -> Int in
        1
    }, numberOfRowsInComponent: { (dataSource, pickerView, components, component) -> Int in
        return components.count
    }) { (adapter, pickerView, components, row, component) -> NSAttributedString? in
        return NSAttributedString(string: components[row], attributes: [
            NSAttributedString.Key.foregroundColor  : UIColor.orange,   //橙色文字
            NSAttributedString.Key.underlineStyle   : NSUnderlineStyle.double.rawValue, //双下划线
            NSAttributedString.Key.textEffect       : NSAttributedString.TextEffectStyle.letterpressStyle
            ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView = UIPickerView()
        view.addSubview(pickerView)
        //绑定pickerView数据
        Observable.just(["One", "Two", "Three", "Four"])
            .bind(to: pickerView.rx.items(adapter: attrStringPickerAdapter))
            .disposed(by: disposeBag)
    }
}

#else //MARK: - 使用自定义视图
class SHRxswift_16ViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    var pickerView: UIPickerView!
    //最简单的pickerView适配器（显示普通文本）
    private let attrStringPickerAdapter = RxPickerViewViewAdapter<[UIColor]>(components: [], numberOfComponents: { (dataSource, pickView, components) -> Int in
        1
    }, numberOfRowsInComponent: { (dataSource, pickerView, components, component) -> Int in
        return components.count
    }) { (_, _, components, row, _,view) -> UIView in
        let componentView = view ?? UIView()
        componentView.backgroundColor = components[row]
        return componentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView = UIPickerView()
        view.addSubview(pickerView)
        //绑定pickerView数据
        Observable.just([UIColor.red, UIColor.orange, UIColor.yellow])
            .bind(to: pickerView.rx.items(adapter: attrStringPickerAdapter))
            .disposed(by: disposeBag)
    }
}

#endif
