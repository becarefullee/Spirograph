//
//  ViewController.swift
//  Spirograph
//
//  Created by Becarefullee on 16/9/13.
//  Copyright © 2016年 Becarefullee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  var config: SpirographConfig!
  var animator: SpirographAnimator!
  
  var isStopBtnTapped: Bool = false

  @IBOutlet weak var CanvasView: Canvas!
  @IBOutlet weak var stopBtn: UIButton!

  @IBAction func swipeHappend(_ sender: UISwipeGestureRecognizer) {
    animator.reset(withCanvasCleared: false)
    config.theta = 0
    config.r_max = Double(arc4random_uniform(140))
    config.r_min = Double(arc4random_uniform(140))
    config.r_inter = Double(arc4random_uniform(60)) - 10
  }
  
  @IBAction func R_MinSliderChanged(_ sender: UISlider) {
    animator.reset()
    config.theta = 0
    if sender.value > 0.5 {
      config.r_min = 80 + Double(sender.value * 100)
      
    } else {
      config.r_min = 100 - Double(sender.value * 100)
    }
  }
  
  @IBAction func R_MaxSliderChanged(_ sender: UISlider) {
    animator.reset()
    config.theta = 0
    if sender.value > 0.5 {
      config.r_max = 80 + Double(sender.value * 100)
    } else {
      config.r_max = 100 - Double(sender.value * 100)
    }
  }
  
  @IBAction func R_InterSliderChanged(_ sender: UISlider) {
    animator.reset()
    config.theta = 0
    if sender.value > 0.5 {
      config.r_inter = 20 + Double(sender.value * 30)
    } else {
      config.r_inter = 20 - Double(sender.value * 30)
    }
  }
  
  @IBAction func stopBtnPressed(_ sender: UIButton) {
    isStopBtnTapped = !isStopBtnTapped
    if isStopBtnTapped{
      stopBtn.setTitle("Resume", for: UIControlState())
      animator.stopAnimation()
    } else {
      stopBtn.setTitle("Stop", for: UIControlState())
      animator.startAnimation()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    config = SpirographConfig(r_max: 100, r_min: 130, r_inter: 34, theta: 0, delta: Double.pi/40)
    animator = SpirographAnimator(canvas: self.CanvasView, config: config)
  }
}

