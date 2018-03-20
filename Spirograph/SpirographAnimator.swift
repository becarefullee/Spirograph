//
//  SpirographAnimator.swift
//  Spirograph
//
//  Created by becarefullee on 2018/3/19.
//  Copyright © 2018年 Becarefullee. All rights reserved.
//

import Foundation
import UIKit


/// Configuration
class SpirographConfig {
  var r_max: Double
  var r_min: Double
  var r_inter: Double
  var theta: Double
  var delta: Double
  
  /// Initialization
  init(r_max: Double, r_min: Double, r_inter: Double, theta: Double, delta: Double) {
    self.r_max = r_max
    self.r_min = r_min
    self.r_inter = r_inter
    self.theta = theta
    self.delta = delta
  }
}


/// Animator that used to draw Spirograph
class SpirographAnimator {
  var calculationTimer: Timer!
  var refreshTimer: Timer!
  
  var config: SpirographConfig
  var calculatedPoints = [CGPoint]()
  var canvas: Canvas!
  
  /// Initialization
  ///
  /// - Parameters:
  ///   - canvas: the canvas that will be used
  ///   - config: the config that will be used for drawing
  init(canvas: Canvas, config: SpirographConfig) {
    self.canvas = canvas
    self.config = config
    //Start animation
    startAnimation()
  }
  
  /// Initialize the calculation timer and refresh timer
  func startAnimation() {
    calculationTimer = Timer.scheduledTimer(timeInterval: 0.001,target: self, selector:#selector(runCalculationTimer), userInfo: nil, repeats: true)
    refreshTimer = Timer.scheduledTimer(timeInterval: 0.05,target: self, selector:#selector(runRefreshTimer), userInfo: nil, repeats: true)
  }

  func stopAnimation() {
    refreshTimer.invalidate()
    calculationTimer.invalidate()
  }
  
  ///When the timer got fired, redraw the canvas
  @objc func runRefreshTimer() {
    drawSpirograph(in: canvas)
  }
  
  /// When the timer got fired, calculate the a new point and add it to result array
  @objc func runCalculationTimer() {
    calculatePoints(in: canvas)
  }
  
  /// Call this methond to trigger redrawing of the canvas
  ///
  /// - Parameter canvas: the Canvas View that currently is using
  func drawSpirograph(in canvas: Canvas) {
    canvas.redraw(with: calculatedPoints)
    
    /// Clear the array, put the last point as the first point for next round of drawing
    if let lastPoint = calculatedPoints.last {
      calculatedPoints = [lastPoint]
    }
  }
  
  /// Add a new point into result array
  ///
  /// - Parameter canvas: the Canvas View that currently is using
  func calculatePoints(in canvas: Canvas) {
    calculatedPoints.append(calculateNextPoint(in: canvas.bounds, r_max: config.r_max, r_min: config.r_min, r_inter: config.r_inter, theta: config.theta))
    config.theta += config.delta
  }
  
  /// Calculate the next point's postion
  ///
  /// - Parameters:
  ///   - rect: bound rect
  ///   - r_max: r_max
  ///   - r_min: r_min
  ///   - r_inter: r_inter
  ///   - theta: theta
  /// - Returns: the postion of next point that should be drawn
  func calculateNextPoint(in rect: CGRect, r_max: Double, r_min: Double, r_inter: Double, theta: Double) -> CGPoint {
    let middle_X: CGFloat = rect.size.width / 2
    let middle_Y: CGFloat = rect.size.height / 2
    let x: Double = ((r_max - r_min) * cos(theta) + r_inter * cos((r_max / r_min - 1) * theta))
    let y: Double = (-(r_max - r_min) * sin(theta) + r_inter * sin ((r_max / r_min - 1) * theta))
    var point = CGPoint(x: x,y: y)
    point.x = point.x + middle_X
    point.y = point.y + middle_Y
    return point
  }

  /// Reset animator
  ///
  /// - Parameter withPointsCleared: whether to keep the calculated points or not
  func reset(withCanvasCleared: Bool = true) {
    calculatedPoints.removeAll()
    guard withCanvasCleared else {
      return
    }
    canvas.clear()
  }
}
