//
//  ViewController.swift
//  Spirograph
//
//  Created by Becarefullee on 16/9/13.
//  Copyright © 2016年 Becarefullee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var CanvasView: Canvas!

  @IBAction func swipeHappend(_ sender: UISwipeGestureRecognizer) {
    pointArray.removeAll()
    theta = 0
    r_max = Double(arc4random_uniform(140)) + 0
    r_min = Double(arc4random_uniform(140)) + 0
    r_inter = Double(arc4random_uniform(60)) - 10
  }
  
  @IBOutlet weak var stopBtn: UIButton!
  
  var timer: Timer!
  var refreshTimer: Timer!
  var r_max: Double = 100
  var r_min: Double = 130
  var r_inter: Double = 34
  var theta: Double = 0
  var delta = M_PI/40
  var pointArray = [CGPoint]()
  var isStopBtnTapped: Bool = false

  
  func calculateThePoint(r_max: Double, r_min: Double, r_inter: Double, theta: Double) -> CGPoint {
    let rect: CGRect = CanvasView.bounds
    let middle_X: CGFloat = rect.size.width / 2
    let middle_Y: CGFloat = rect.size.height / 2
    let x: Double = ((r_max - r_min) * cos(theta) + r_inter * cos((r_max / r_min - 1) * theta))
    let y: Double = (-(r_max - r_min) * sin(theta) + r_inter * sin ((r_max / r_min - 1) * theta))
    var point = CGPoint(x: x,y: y)
    point.x = point.x + middle_X
    point.y = point.y + middle_Y
    return point
  }
  
  
  func sendPointToCanvasView() {
    pointArray.append(calculateThePoint(r_max: r_max, r_min: r_min, r_inter: r_inter, theta: theta))
//    CanvasView.endPoint = calculateThePoint(r_max: r_max, r_min: r_min, r_inter: r_inter, theta: theta)
//    CanvasView.redraw()
    theta = theta + delta
  }
  
  func refresh() {
    CanvasView.points = pointArray
    CanvasView.redraw()
    let lastPoint: CGPoint = pointArray.last!
    pointArray = [lastPoint]
  }

  @IBAction func R_MaxSliderChanged(_ sender: UISlider) {
    pointArray.removeAll()
    CanvasView.clear()
    theta = 0
    if sender.value > 0.5 {
      r_max = 80 + Double(sender.value * 100)
    } else {
      r_max = 100 - Double(sender.value * 100)
    }
  }
  
  @IBAction func R_MinSliderChanged(_ sender: UISlider) {
    pointArray.removeAll()
    CanvasView.clear()
    theta = 0
    if sender.value > 0.5{
      r_min = 80 + Double(sender.value * 100)
      
    } else {
      r_min = 100 - Double(sender.value * 100)
    }
  }
  
  @IBAction func R_InterSliderChanged(_ sender: UISlider) {
    pointArray.removeAll()
    CanvasView.clear()
    theta = 0
    if sender.value > 0.5{
      r_inter = 20 + Double(sender.value * 30)
    } else {
      r_inter = 20 - Double(sender.value * 30)
    }
  }

  @IBAction func stopBtnPressed(_ sender: UIButton) {
    isStopBtnTapped = !isStopBtnTapped
    if isStopBtnTapped{
    stopBtn.setTitle("Resume", for: UIControlState())
    refreshTimer.invalidate()
    timer.invalidate()
    } else {
      stopBtn.setTitle("Stop", for: UIControlState())
      timer = Timer.scheduledTimer(timeInterval: 0.001,target:self,selector:#selector(ViewController.sendPointToCanvasView),userInfo:nil,repeats:true)
    
      refreshTimer = Timer.scheduledTimer(timeInterval: 0.05,target:self,selector:#selector(ViewController.refresh),userInfo:nil,repeats:true)
    }
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    CanvasView.startPoint = calculateThePoint(r_max: r_max, r_min: r_min, r_inter: r_inter, theta: delta)

  }
  
  override func viewDidLoad() {
    super.viewDidLoad()        
    timer = Timer.scheduledTimer(timeInterval: 0.001,target:self,selector:#selector(ViewController.sendPointToCanvasView),userInfo:nil,repeats:true)

    refreshTimer = Timer.scheduledTimer(timeInterval: 0.05,target:self,selector:#selector(ViewController.refresh),userInfo:nil,repeats:true)
  }
}

