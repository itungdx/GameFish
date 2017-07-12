//
//  ViewController.swift
//  GameFish
//
//  Created by Tung on 6/27/17.
//  Copyright © 2017 Tung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var gameManager : GameManager?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.gameManager = GameManager()
        self.view.addSubview((self.gameManager?.hookView)!)
        
        self.gameManager?.addFishToviewController(self, width: Int(self.view.bounds.width))
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action:#selector(ViewController.tapHandle(_:))))
//        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.gameManager!, action: #selector(ViewController.tapHandle(_:))))
        Timer.scheduledTimer(timeInterval: 0.025, target: self.gameManager!, selector: Selector(("updateMove")), userInfo: nil, repeats: true)
        
        //        let fishView = FishView(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
        //        fishView.generateFish(width: Int(self.view.bounds.width))
        //        self.view.addSubview(fishView)
    }
    
    
    @IBAction func addFish(_ sender: UIButton) {
        self.gameManager?.addFishToviewController(self, width: Int(self.view.bounds.width))
    }
    @IBAction func Reset(_ sender: UIButton) {
        self.gameManager?.fishViews?.removeAllObjects()
        for object in self.view.subviews
        {
            if (object .isKind(of: FishView.self))
            {
                object .removeFromSuperview()
            }
        }
        self.gameManager?.addFishToviewController(self, width: Int(self.view.bounds.width))
    }
    

    func tapHandle(_ sender: UIGestureRecognizer)
    {
        let tapPoint = sender.location(in: self.view)
        self.gameManager?.dropHookerAtX(Int(tapPoint.x))
    }
}

