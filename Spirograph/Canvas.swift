//
//  Canvas.swift
//  Spirograph
//
//  Created by Becarefullee on 16/9/14.
//  Copyright © 2016年 Becarefullee. All rights reserved.
//

import Foundation
import UIKit


class Canvas:UIView{

    var pointArray = [CGPoint]()

    func updataPoints(point:CGPoint){
        
        pointArray.append(point)
    }
    
    
    override func draw(_ rect: CGRect) {
        guard pointArray.count > 1 else {
            return
        }
        super.draw(rect);
        let path = UIBezierPath()
        UIColor.black.setStroke()
        path.move(to: pointArray[0])
        for i in 1..<pointArray.count{
            path.addLine(to:pointArray[i])
        }
        path.stroke()
 
    }
}
