//
//  Canvas.swift
//  Spirograph
//
//  Created by Becarefullee on 16/9/14.
//  Copyright © 2016年 Becarefullee. All rights reserved.
//

import Foundation
import UIKit


class Canvas: UIView {
  var preRenderedImage: UIImage!
  var bezierPath: UIBezierPath!
  
  var lineWidth: CGFloat = 1
  var lineColor: UIColor = UIColor.black
  
  
  // MARK: - Initialization
  override init(frame: CGRect) {
    super.init(frame: frame)
    initBezierPath()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    initBezierPath()
  }
  
  func initBezierPath() {
    bezierPath = UIBezierPath()
    bezierPath.lineCapStyle = CGLineCap.round
    bezierPath.lineJoinStyle = CGLineJoin.round
    bezierPath.lineWidth = lineWidth
  }
  
  
  func redraw(with points: [CGPoint]) {
    guard points.count > 0 else {
      return
    }
    bezierPath.move(to: points[0])
    for i in 0..<points.count {
      bezierPath.addLine(to: points[i])
    }
    renderToImage()
    setNeedsDisplay()
    bezierPath.removeAllPoints()
  }
  
  override func draw(_ rect: CGRect) {
    super.draw(rect)
    if preRenderedImage != nil {
      preRenderedImage.draw(in: self.bounds)
    }
    
    bezierPath.lineWidth = lineWidth
    lineColor.setStroke()
    bezierPath.stroke()
  }
  
  func renderToImage() {
    
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0.0)
    
    if preRenderedImage != nil {
      preRenderedImage.draw(in: self.bounds)
    }
    lineColor.setStroke()
    bezierPath.stroke()
    preRenderedImage = UIGraphicsGetImageFromCurrentImageContext()
    
    UIGraphicsEndImageContext()
  }

  func clear() {
    preRenderedImage = nil
    bezierPath.removeAllPoints()
    setNeedsDisplay()
  }
}
