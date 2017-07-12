 //
//  GameManager.swift
//  GameFish
//
//  Created by Tung on 6/27/17.
//  Copyright © 2017 Tung. All rights reserved.
//

import UIKit

class GameManager: NSObject {
    //add Ca, truyen vao mang
    var fishViews : NSMutableArray?
    var hookView : HookerView?
    override init()
    {
        self.fishViews = NSMutableArray()
        //tren goc trai tren cung, width 20, height
        self.hookView = HookerView(frame: CGRect(x: 0, y: -490, width: 20, height: 490))
    }
    
    func addFishToviewController(_ viewcontroller:UIViewController,
                                 width:Int)
    {
        let fishView = FishView(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
        fishView.generateFish(width)
        self.fishViews?.add(fishView)
        viewcontroller.view.addSubview(fishView)
    }
    //Phuong thuc ca can cau
//    func bite(fishView: FishView)
//    {
//        //neu trang thai ca chua bi bat, hook di xuong thif
//        if (fishView.status != fishView.CAUGHT && self.hookView?.status != self.hookView?.DRAWINGUP){
//            fishView.caught()
//            print(fishView.frame.height)
//            fishView.center = CGPoint(x: (self.hookView?.center.x)!, y: (self.hookView?.frame.origin.y)! + (self.hookView?.frame.height)! + fishView.frame.width/2)
//            self.hookView?.status = self.hookView?.CAUGHTF
//        }
//    }
    func updateMove()
    {
        self.hookView?.updateMove()
        for fishView in self.fishViews!
        {
            (fishView as AnyObject).updateMove()
            
            if (((fishView as AnyObject).frame).contains(CGPoint(x: self.hookView!.center.x, y: self.hookView!.frame.origin.y + self.hookView!.frame.height + (fishView as AnyObject).frame.width/2)))
            {
                bite (fishView as! FishView)
            }
        }
    }
    func dropHookerAtX(_ x: Int)
    {
        self.hookView?.dropDownAtX(x)
    }

    func bite(_ fishView: FishView)
    {
        if (fishView.status != fishView.CAUGHT && self.hookView?.status != self.hookView?.DRAWINGUP)
        {
            fishView.caught()
            fishView.center = CGPoint(x: self.hookView!.center.x, y: self.hookView!.frame.origin.y + self.hookView!.frame.height + fishView.frame.width/2)
            self.hookView?.status = self.hookView?.CAUGHTF
        }
    }

}
