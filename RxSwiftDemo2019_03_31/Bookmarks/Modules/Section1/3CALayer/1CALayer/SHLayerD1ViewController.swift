//
//  SHLayerD1ViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by Mac on 2020/3/15.
//  Copyright © 2020 远平. All rights reserved.
//

import UIKit


class SHLayerD1ViewController: UIViewController {
    
    var viewForLayer: UIView = UIView()
    
    var layer: CALayer {
        return viewForLayer.layer
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initUI()
        
        setUpLayer()
    }
    
    func setUpLayer() {
        layer.backgroundColor = UIColor.blue.cgColor
        layer.borderWidth = 100.0
        layer.borderColor = UIColor.red.cgColor
        layer.shadowOpacity = 0.7
        layer.shadowRadius = 10.0
        
        layer.contents = UIImage(named: "star")?.cgImage
        layer.contentsGravity = CALayerContentsGravity.center
    }
    
    private func initUI() {
        view.addSubview(viewForLayer)
        viewForLayer.snp_makeConstraints { (make) in
            make.width.equalTo(300)
            make.height.equalTo(300)
            make.center.equalToSuperview()
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapGestureRecognized(_:)))
        let pin = UIPinchGestureRecognizer(target: self, action: #selector(pinchGestureRecognized(_:)))
        self.view.addGestureRecognizer(tap)
        self.view.addGestureRecognizer(pin)
    }
    
    @objc func tapGestureRecognized(_ sender: UITapGestureRecognizer) {
        layer.shadowOpacity = layer.shadowOpacity == 0.7 ? 0.0 : 0.7
    }
    @objc func pinchGestureRecognized(_ sender: UIPinchGestureRecognizer) {
        let offset: CGFloat = sender.scale < 1 ? 5.0 : -5.0
        let oldFrame = layer.frame
        let oldOrigin = oldFrame.origin
        let newOrigin = CGPoint(x: oldOrigin.x + offset, y: oldOrigin.y + offset)
        let newSize = CGSize(width: oldFrame.width + (offset * -2.0), height: oldFrame.height + (offset * -2.0))
        let newFrame = CGRect(origin: newOrigin, size: newSize)
        if newFrame.width >= 100.0 && newFrame.width <= 300.0 {
            layer.borderWidth -= offset
            layer.cornerRadius += (offset / 2.0)
            layer.frame = newFrame
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
