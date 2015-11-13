//
//  PlaySoundViewController.swift
//  Pitch Perfect
//
//  Created by Eduard Meciar on 02/11/15.
//  Copyright © 2015 Eduard Meciar. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundViewController: UIViewController {
    
    var player:AVAudioPlayer!
    var recievedAudio: RecordedAudio!
    var audioEngine: AVAudioEngine!
    var audioFile:AVAudioFile!

    override func viewDidLoad() {
        super.viewDidLoad()
        player = try! AVAudioPlayer(contentsOfURL: recievedAudio.filePathUrl)
        player.enableRate = true
        audioEngine = AVAudioEngine()
        audioFile = try! AVAudioFile(forReading: recievedAudio.filePathUrl)
        setSessionPlayerOn()
    }
    
    override func viewDidDisappear(animated: Bool) {
        setSessionPlayerOff()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func stopToBeggining(){
        player.stop()
        player.currentTime = 0.0
        audioEngine.stop()
        audioEngine.reset()
    }
    
    @IBAction func playSnailSound(sender: UIButton) {
        playAudioWithVariableRate(0.5)
    }
    
    @IBAction func playFastSound(sender: UIButton) {
        playAudioWithVariableRate(1.5)
    }

    @IBAction func playChipmunk(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    
    func playAudioWithVariableRate(rate: Float){
        stopToBeggining()
        player.rate = rate
        player.volume = 1.0
        player.play()
    }
    
    func playAudioWithVariablePitch(pitch: Float){
        stopToBeggining()
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        let changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        try! audioEngine.start()
        
        audioPlayerNode.volume = 1.0
        audioPlayerNode.play()
    }
    
    @IBAction func playVader(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    @IBAction func stopSound(sender: UIButton) {
            stopToBeggining()
    }
    
    
    /*
    I used this two functions to increace a volume of recorded sound
    I found this funciton in http://stackoverflow.com/questions/29526435/force-audio-file-playback-through-iphone-loud-speaker-using-swift
    */
    func setSessionPlayerOn()
    {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayAndRecord)
        } catch _ {
        }
        do {
            try AVAudioSession.sharedInstance().setActive(true)
        } catch _ {
        }
        do {
            try AVAudioSession.sharedInstance().overrideOutputAudioPort(AVAudioSessionPortOverride.Speaker)
        } catch _ {
        }
    }
    func setSessionPlayerOff()
    {
        do {
            try AVAudioSession.sharedInstance().setActive(false)
        } catch _ {
        }
    }

}
