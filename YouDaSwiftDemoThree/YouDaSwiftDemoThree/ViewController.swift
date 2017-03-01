//
//  ViewController.swift
//  Stopwatch
//
//  Created by Yi Gu on 2/18/16.
//  Copyright © 2016 YiGu. All rights reserved.
//

import UIKit

class ViewController:UIViewController {

    

  @IBOutlet weak var timerLabel: UILabel!
  @IBOutlet weak var lapTimerLabel: UILabel!
  @IBOutlet weak var playPauseButton: UIButton!
  @IBOutlet weak var lapRestButton: UIButton!
  @IBOutlet weak var lapsTableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  

  
  
  // MARK: play, pause, lap, and reset
  @IBAction func playPauseTimer(_ sender: AnyObject) {
      }
  
  @IBAction func lapResetTimer(_ sender: AnyObject) {
    
  }
  
  
  
}
