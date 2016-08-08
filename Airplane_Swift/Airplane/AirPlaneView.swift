//
//  MKAirPlaneBattleView.swift
//  Airplane
//
//  Created by xHadesvn
//  Copyright © 2016 xHadesvn. All rights reserved.
//
let ScreenW = UIScreen.mainScreen().bounds.width
let ScreenH =  UIScreen.mainScreen().bounds.height

import UIKit

class AirPlaneView: UIView {
    
    var bgView: UIImageView?
    var bgView2: UIImageView?
    var airplaneView: UIImageView?
    var bulletArray: [UIImageView] = []
    var enemyArray: [UIImageView] = []
    var boomArray: [UIImageView] = []
    var rate: CGFloat = 0
    var moveSpeed: CGFloat = 0
    var planeNum: Int = 0
    var timer: NSTimer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpBackgroundView()
        setUpAirplaneView()
        addSubview(startOrStopButton)
        setUpBulletViewAndEnemyViewAndBoomViewAnimation()
        NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: Selector("moveBgView"), userInfo: nil, repeats: true)
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // Set the background in the mobile view two pictures
    private func setUpBackgroundView() {
        bgView = UIImageView()
        bgView?.image = UIImage(named: "bg")
        bgView?.contentMode = UIViewContentMode.ScaleToFill
        bgView?.frame = bounds
        addSubview(bgView!)
        bgView2 = UIImageView(image: UIImage(named: "bg"))
        bgView2?.contentMode = UIViewContentMode.ScaleToFill
        bgView2?.frame = CGRect(x: 0, y: ScreenH, width: ScreenW, height: ScreenH)
        addSubview(bgView2!)
    }
    // Setting Airplane image two pictures do animation
    private func setUpAirplaneView() {
        airplaneView = UIImageView(image: UIImage(named: "plane1"))
        airplaneView?.frame = CGRect(x: (ScreenW - 50)/2, y: ScreenH - 50, width: 50, height: 50)
        airplaneView?.contentMode = UIViewContentMode.ScaleToFill
        airplaneView?.userInteractionEnabled = true
        let pan = UIPanGestureRecognizer(target: self, action: Selector("touchMove:"))
        airplaneView?.addGestureRecognizer(pan)
        addSubview(airplaneView!)
    }
    
    // Play/ End Game
    lazy var startOrStopButton: UIButton = {
        let btn = UIButton(type: .Custom)
        btn.frame = CGRect(x: ScreenW - 80, y: ScreenH - 38, width: 70, height: 28)
        btn.setTitle("Play", forState: .Normal)
        btn.setTitle("Pause", forState: .Selected)
        btn.titleLabel?.font = UIFont.systemFontOfSize(12)
        btn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        btn.setBackgroundImage(UIImage(named: "stop"), forState: .Selected)
        btn.setBackgroundImage(UIImage(named: "start"), forState: .Normal)
        btn.addTarget(self, action: Selector("startOrStopClicked:"), forControlEvents: .TouchUpInside)
        return btn
    }()
    
    @objc func startOrStopClicked(button: UIButton) {
         button.selected = !button.selected
        guard let newTimer = timer else {
             timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: Selector("updateData"), userInfo: nil, repeats: true)
            return
        }
        if button.selected == false {
            newTimer.fireDate = NSDate.distantFuture()
        } else {
            newTimer.fireDate = NSDate.distantPast()
        }
    }
    
    // Set up an array of enemy bullets and explosions and animations
    private func setUpBulletViewAndEnemyViewAndBoomViewAnimation () {
        bulletArray = AirPlaneViewHelper.setUpBulletViewShowInView(self)
        enemyArray = AirPlaneViewHelper.setUpEnemyViewShowInView(self)
        boomArray = AirPlaneViewHelper.boomViewAnimationInView(self)
    }
    
    //   Move
    private func bgMove() {
        moveSpeed += 5
        if moveSpeed >= ScreenH {
            moveSpeed = 0
        }
        bgView?.frame.origin.y = moveSpeed
        bgView2?.frame.origin.y = moveSpeed - ScreenH
    }
    //  Flashing aircraft
    private func changePlane() {
        planeNum += 1
        if planeNum%4 == 0 {
            airplaneView?.image = UIImage(named: "plane1")
        } else {
            airplaneView?.image = UIImage(named: "plane2")
        }
    }

    //  Refresh timer
    @objc func moveBgView() {
        bgMove()
    }
    @objc func updateData() {
        
        changePlane()
        engineStart()
        
    }
    private func engineStart(){
        rate += 1
        
        //  0%5 = 0, 5%5 =0, 10%5 = 0 at intervals of 6 is moved up all the bullets second
        if rate%5 == 0 {
            AirPlaneMoveEngine.findBulletInBulletArray(bulletArray,airplaneView:airplaneView!)
        }
        if rate%15 == 0 {
            AirPlaneMoveEngine.findEnemyInEnemyArray(enemyArray)
        }
        
        // Mobile needs to be moved three times every row
        AirPlaneMoveEngine.moveBulletWithBulletArray(bulletArray)
        AirPlaneMoveEngine.moveEnemyWithEnemyArray(enemyArray)
        AirPlaneViewHelper.showEnemyPlaneBoomAnimation(bulletArray, enemyArray:enemyArray, boomArray:boomArray)
    }
    
    @objc func touchMove(gesture: UIPanGestureRecognizer) {
        if gesture.state == UIGestureRecognizerState.Changed {
            airplaneView?.center = gesture.locationInView(self)
        }
    }
}
