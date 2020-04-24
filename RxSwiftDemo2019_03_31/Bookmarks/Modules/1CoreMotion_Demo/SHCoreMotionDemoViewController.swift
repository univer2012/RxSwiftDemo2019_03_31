//
//  SHCoreMotionDemoViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by 远平 on 2019/11/26.
//  Copyright © 2019 远平. All rights reserved.
//

import UIKit

import CoreMotion

class SHCoreMotionDemoViewController: UIViewController, UIAccelerometerDelegate {

    var ball: UIImageView!
    var speedX: UIAccelerationValue = 0
    var speedY: UIAccelerationValue = 0
    var motionManager = CMMotionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //放一个小球在中央
        ball = UIImageView(image: UIImage(named: "ball"))
        ball.frame = CGRect(x: 0, y: 0, width: 50, height:50)
        ball.center = self.view.center
        self.view.addSubview(ball)
        
        motionManager.accelerometerUpdateInterval = 1/60
        
        if motionManager.isAccelerometerAvailable {
            let queue = OperationQueue.current!
            motionManager.startAccelerometerUpdates(to: queue) { (accelerometerData, error) in
                //动态设置小球位置
                self.speedX += accelerometerData!.acceleration.x
                self.speedY = accelerometerData!.acceleration.y
                var posX = self.ball.center.x + CGFloat(self.speedX)
                var posY = self.ball.center.y - CGFloat(self.speedY)
                //碰到边框后的反弹处理
                if posX < 0 {
                    posX = 0
                    //碰到左边的边框 后以0.4倍的速度反弹
                    self.speedX *= -0.4
                } else if posX > self.view.bounds.size.width {
                    posX = self.view.bounds.size.width
                    //碰到右边的边框后以0.4倍的速度反弹
                    self.speedX *= -0.4
                }
                
                if posY < 0 {
                    posY = 0
                    //碰到上面的边框不反弹
                    self.speedY = 0
                } else if posY > self.view.bounds.size.height {
                    posY = self.view.bounds.size.height
                    //碰到下面的边框后以1.5倍的速度反弹
                    self.speedY *= -1.5
                }
                self.ball.center = CGPoint(x: posX, y: posY)
            }
        }
    }
}
