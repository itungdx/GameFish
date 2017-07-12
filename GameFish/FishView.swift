//
//  FishView.swift
//  GameFish
//
//  Created by Tung on 6/27/17.
//  Copyright © 2017 Tung. All rights reserved.
//

import UIKit

class FishView: UIImageView {
    //trang thai dang boi hoac bi bat
    var status : Int? // 1-0 boi hay bi bat
    var speed : Int?
    var vy : Int?//-1 0 1 boi ngang len xuong
    var widthFrame : Int? //chieu rong Frame
    var heightFrame : Int? //chieu dai Frame
    var widthFish : Int?
    var heightFish: Int?
    let MOVING : Int = 0
    let CAUGHT : Int = 1
    override init(frame: CGRect) {
        self.widthFish = Int(frame.width)
        self.heightFish = Int(frame.height)
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Sinh ca
    func generateFish(_ width:Int){
        //Add ca
        
//        self.image = UIImage(named:"fish1")
//        self.frame = CGRect(x: CGFloat(100), y: CGFloat(100), width: CGFloat(40), height: CGFloat(30))
        
        //gan withFame bang width truyen vao
        //khi con ca boi ria phai, lay bien luu lai chieu dai man hinh luc do de co ca boi ra roi quay dau lai
        
        self.widthFrame = width
        self.vy = Int(arc4random_uniform(3))-1
        //random vi tri ca
        let y : Float = Float(arc4random_uniform(240)) + 80
        //tao trang thai dang boi
        self.status = MOVING
        
        self.speed = ( Int)(arc4random_uniform(5)) + 2
        //Neu dieu kien ca ra den bien trai thoa man
        if (Int(self.center.x) <=  -Int(self.widthFish!/2))
        {
            self.transform = CGAffineTransform.identity
            self.image = UIImage(named: "fish1")
            self.frame = CGRect(x: -CGFloat(self.widthFish!), y: CGFloat(y), width: CGFloat(self.widthFish!), height: CGFloat(self.heightFish!))
        } else
        {
            self.transform = CGAffineTransform.identity
            self.image = UIImage(cgImage: UIImage(named:"fish1")!.cgImage!, scale: 1.0, orientation:UIImageOrientation.upMirrored)
            self.frame = CGRect(x: CGFloat(self.widthFrame!), y: CGFloat(y), width: CGFloat(self.widthFish!), height: CGFloat(self.heightFish!))
            self.speed = -Int(self.speed!)
        }
    }
    func updateMove(){
        //neu ca dang boi theo chieu Ox và Oy
        if(self.status == MOVING){
            //set vi tri toc do di chuyen
            self.center = CGPoint(x: self.center.x + CGFloat(self.speed!), y: self.center.y + CGFloat(self.vy!))
            //neu con ca di len dinh thi no se thay do chieu di
            if (Int(self.center.y) < -Int(self.heightFish!) || Int(self.center.y) > self.heightFish! + 240)
            {
                self.vy = -self.vy!
            }
            if ((Int(self.center.x) > self.widthFrame! && self.speed! > 0) || (Int(self.center.x) < -self.widthFish! && self.speed! < 0))
            {
                generateFish(self.widthFrame!)
            }
        }
                //trang thay con ca bi bat
        else if (self.status == CAUGHT)
        {
            self.center = CGPoint(x: self.center.x, y: self.center.y - 5)
            if (Int(self.frame.origin.y) <= -Int(self.widthFish!) )
            {
                generateFish(self.widthFrame!)
            }
        }
    }
    func caught()
    {
        if (self.status == MOVING) {
            self.status = CAUGHT
            //ca chay tu trai qua phai, quay ca goc am 90
            if (self.speed! > 0)
            {
                self.transform = CGAffineTransform(rotationAngle: CGFloat(-M_PI_2))
            }
            else{
                //ca chay tu phai qua trai, quay ca goc duong 90
                self.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI_2))
            }
        }
    }
}
