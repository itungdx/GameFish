//
//  HookerView.swift
//  GameFish
//
//  Created by Tung on 6/27/17.
//  Copyright © 2017 Tung. All rights reserved.
//

import UIKit

class HookerView: UIImageView {
    //co the bat dau keo
    let PREPARE = 0
    //dang keo xuong
    let DROPPING = 1
    //keo len
    let DRAWINGUP = 2
    //bat duoc ca
    let CAUGHTF = 3
    // trang thai moc cau
    var status : Int?
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.image = UIImage(named:"hook")
        self.status = PREPARE
    }
    
    
    
    func updateMove()
    {
    //neu can dang keo xuong
    if (self.status == DROPPING)
    {
        self.center = CGPoint(x: self.center.x, y: self.center.y + 10)
        //neu can cham toi mep duoi man hinh thiet bi (o day la 480)
        //thi can se keo len
        if (self.frame.origin.y + self.frame.height > 480)
        {
            self.status = DRAWINGUP
        }
    }
    else if (self.status == DRAWINGUP)
    {
        //dang keo len
        self.center = CGPoint(x: self.center.x, y: self.center.y - 20)
        if (self.frame.origin.y + self.frame.size.height < 0)
        {
            self.status = PREPARE
        }
    }
    else if (self.status == CAUGHTF)
    {
        self.center = CGPoint(x: self.center.x, y: self.center.y - 5)
        if (self.frame.origin.y + self.frame.height < 0)
        {
            self.status = PREPARE
        }
        }
    }
    func dropDownAtX(_ x: Int)
    {
        if (self.status == PREPARE)
        {
            self.center = CGPoint(x: CGFloat(x), y: self.center.y)
            self.status = DROPPING
        }
    }
}
