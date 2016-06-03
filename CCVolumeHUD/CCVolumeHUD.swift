//
//  CCVolumeHUD.swift
//  CCVolumeHUD
//
//  Created by César Felipe Cruz Morales on 5/26/16.
//  Copyright © 2016 cecruzmo. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import AVFoundation
import MediaPlayer
import QuartzCore

class CCVolumeHUD: NSObject {
  
  static let sharedInstance = CCVolumeHUD()
  let volumeView = MPVolumeView.init(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, 21))
  let dismissTime = 2.0
  
  private let outputVolumeKeyPath = "outputVolume"
  private let statusBarHeight: CGFloat = 21.0
  
  private override init() {
    super.init()
    self.configureNotifications()
    self.configureAudioSession()
    self.configureVolumeView()
  }
  
  deinit {
    NSNotificationCenter.defaultCenter().removeObserver(self)
  }
  
  private func configureNotifications() {
    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(deviceOrientationDidChangeNotification(_:)), name: UIDeviceOrientationDidChangeNotification, object: nil)
    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(applicationDidBecomeActiveNotification(_:)), name: UIApplicationDidBecomeActiveNotification, object: nil)
  }
  
  @objc private func deviceOrientationDidChangeNotification(note: NSNotification) {
    volumeView.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, statusBarHeight)
  }
  
  @objc private func applicationDidBecomeActiveNotification(note: NSNotification) {
    self.configureAudioSession()
  }
  
  private func configureAudioSession() {
    do {
      let audioSession = AVAudioSession.sharedInstance()
      try audioSession.setActive(true)
      audioSession.addObserver(self, forKeyPath: outputVolumeKeyPath, options: [], context: nil)
      UIApplication.sharedApplication().windows.first?.addSubview(volumeView)
    } catch {
      print("CCVolumeHUD: \(error)")
    }
  }
  
  private func configureVolumeView() {
    volumeView.alpha = 0.00001 // 0.0 will cause default volume HUD appears
    volumeView.userInteractionEnabled = false
    volumeView.showsRouteButton = false
    volumeView.setVolumeThumbImage(UIImage(), forState: .Normal)
  }
  
  override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
    if keyPath == outputVolumeKeyPath {
      self.showUnobtrusiveVolumeHUD()
    }
  }
  
  private func showUnobtrusiveVolumeHUD() {
    UIApplication.sharedApplication().statusBarHidden = true
    volumeView.layer.removeAllAnimations()
    volumeView.alpha = 1.0
    
    UIView.animateWithDuration(dismissTime, animations: {
      self.volumeView.alpha = 0.00001
      }, completion: { (completed: Bool) in
        if completed == true {
          UIApplication.sharedApplication().statusBarHidden = false
        }
    })
  }
}
