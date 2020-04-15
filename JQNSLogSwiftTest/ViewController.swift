//
//  ViewController.swift
//  JQNSLogSwiftTest
//
//  Created by zhongkang on 2020/3/24.
//  Copyright © 2020 zhongkang. All rights reserved.
//

import UIKit

let ScreenWidth = UIScreen.main.bounds.size.width
let ScreenHeight = UIScreen.main.bounds.size.height



class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self .setLog()
        
        
        // Do any additional setup after loading the view.
    }
    
    func setLog(){
        let jqLogView = JQNSLogView(frame: CGRect(x: 100, y: 100, width: 60, height: 30))
        jqLogView .backgroundColor = UIColor.blue
                
        self.view .addSubview(jqLogView)
        
        let handDrag = UIPanGestureRecognizer(target: self, action: #selector(funDrag))
        jqLogView.addGestureRecognizer(handDrag)
        
        
        
    }
    
   
    
    
    
    @objc func funDrag(sender: UIPanGestureRecognizer){
            var Point = sender.translation(in: self.view);//现对于起始点的移动位置
            Point = sender.location(in: self.view);//在整个self.view 中的位置
        
        let jqLogView = sender.view as? JQNSLogView
        
        if jqLogView?.isMove == false {
            return
        }
        
        
        
        
        if ( Point.x < 50) {
               Point.x = 50;
           }else if (Point.x > (ScreenWidth - 50)) {
               Point.x = ScreenWidth - 50;
           }
           
           if (Point.y   < 40 ) {
               Point.y = 40 ;
           }else if (Point.y > (ScreenHeight  - 40)){
               Point.y = ScreenHeight - 40;
           }
        sender.view?.center = Point

            if(sender.state == .began){
                print("begin: "+String(describing: Point.x)+","+String(describing:Point.y))
            }else if(sender.state == .ended){
                print("ended: "+String(describing: Point.x)+","+String(describing:Point.y))
            }else{
                print("ing: "+String(describing: Point.x)+","+String(describing:Point.y))
            }
        }
    
  
    
    
   
    
   

    
    


}

