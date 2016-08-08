//
//  AirPlaneViewHelper.swift
//  Airplane
//
//  Created by xHadesvn
//  Copyright © 2016 xHadesvn. All rights reserved.
//

import UIKit

class AirPlaneViewHelper: NSObject {
    //  Setting bullet
    class func setUpBulletViewShowInView (view: UIView) -> [UIImageView]{
        var bulletArr:[UIImageView] = []
        for i in 0..<63 {
            let bulletView = UIImageView(image: UIImage(named: "zidan"))
            bulletView.frame = CGRect(x: -6, y: 12 * i, width: 6, height: 10)
            bulletView.tag = 0
            view.addSubview(bulletView)
            bulletArr.append(bulletView)
        }
        return bulletArr
    }
    //  Setting local aircraft
    class func setUpEnemyViewShowInView (view: UIView) -> [UIImageView]{
        var enemyArray:[UIImageView] = []
        for _ in 0..<20 {
            let enemyView = UIImageView(image: UIImage(named: "diji"))
            enemyView.frame = CGRect(x: -100, y: -100, width: 50, height: 50)
            enemyView.tag = 0
            view.addSubview(enemyView)
            enemyArray.append(enemyView)
        }
        return enemyArray
    }
    // Setting explosion animation
    class func boomViewAnimationInView(view: UIView) -> [UIImageView]{
        var boomImages = [UIImage]()
        var boomArray = [UIImageView]()
        for i in 1..<6 {
            let imageName = "bz\(i).png"
            let image = UIImage(named: imageName)
            boomImages.append(image!)
        }
        for _ in 0..<10 {
            let boomView = UIImageView(frame: CGRect(x: -100, y: -100, width: 50, height: 50))
            boomView.animationImages = boomImages
            boomView.animationDuration = 0.5
            boomView.animationRepeatCount = 1
            view.addSubview(boomView)
            boomArray.append(boomView)
        }
        return boomArray
    }
    // Check whether the explosion
    class func showEnemyPlaneBoomAnimation (bulletArray:[UIImageView], enemyArray: [UIImageView], boomArray:[UIImageView]) {
        for i in 0..<bulletArray.count {
            let bulletView = bulletArray[i]
            if bulletView.tag != 0 {
                for j in 0..<enemyArray.count {
                    let enemyView = enemyArray[j]
                    if enemyView.tag == 1 {
                        let isBoom: Bool = CGRectIntersectsRect(bulletView.frame, enemyView.frame)
                        if isBoom == true {
                            bulletView.tag = 0
                            enemyView.tag = 0
                            for k in 0..<boomArray.count {
                                let boomView = boomArray[k]
                                if boomView.isAnimating() == false {
                                    boomView.frame = enemyView.frame
                                    boomView.startAnimating()
                                    bulletView.frame.origin.x = -100
                                    enemyView.frame.origin.x = -100
                                    break
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
