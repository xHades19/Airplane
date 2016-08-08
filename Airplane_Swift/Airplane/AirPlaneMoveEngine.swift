//
//  AirPlaneMoveEngine.swift
//  Airplane
//
//  Created by xHadesvn
//  Copyright © 2016 xHadesvn. All rights reserved.
//

import UIKit

class AirPlaneMoveEngine: NSObject {

    //  Set the correct tag before the bullet and take on aircraft
    class func findBulletInBulletArray(bulletArray:[UIImageView], airplaneView: UIView) {
        var a = 0
        for i in 0..<bulletArray.count {
            let bulletView = bulletArray[i]
            if bulletView.tag == 0 {
                a+=1
                bulletView.tag = a
                bulletView.frame = CGRect(x: airplaneView.frame.origin.x + 25 - 3, y: airplaneView.frame.origin.y - 10, width: 6, height: 10)
                // Each taking three were left, right
                if a == 3 {
                    break
                }
            }
        }
    }
    //   Set the correct tag and take aircraft
    class func findEnemyInEnemyArray(enemyArray:[UIImageView]) {
        for i in 0..<enemyArray.count {
            let enemyView = enemyArray[i]
            if enemyView.tag == 0 {
                enemyView.tag = 1
                let x = UInt32(ScreenW) - 50
                enemyView.frame = CGRect(x: CGFloat(arc4random()%x), y: -50, width: 50, height: 50)
                break
            }
            
        }
    }
    //  Moving Bullet
    class func moveBulletWithBulletArray(bulletArray:[UIImageView]) {
        for i in 0..<bulletArray.count {
            let bulletView = bulletArray[i]
            if bulletView.tag != 0 {
                bulletView.frame.origin.y -= 5
                if bulletView.tag == 1 {
                    bulletView.frame.origin.x -= 1
                }
                if bulletView.tag == 3 {
                    bulletView.frame.origin.x += 1
                }
                if bulletView.frame.origin.y <= -10 || bulletView.frame.origin.x <= -6 || bulletView.frame.origin.x >= ScreenW {
                    bulletView.tag=0;
                }
                
            }
        }
    }
    
    //   Mobile enemy
    class func moveEnemyWithEnemyArray(enemyArray:[UIImageView]) {
        for i in 0..<enemyArray.count {
            let enemy = enemyArray[i]
            if enemy.tag == 1 {
                enemy.frame.origin.y += 5
                if enemy.frame.origin.y >= ScreenH {
                    enemy.tag=0;
                }
            }
        }
    }
}
