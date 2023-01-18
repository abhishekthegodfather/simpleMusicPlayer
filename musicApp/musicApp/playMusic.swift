//
//  playMusic.swift
//  musicApp
//
//  Created by Cubastion on 18/01/23.
//

import UIKit
import AVFoundation

class playMusic: UIViewController, AVAudioPlayerDelegate {

    @IBOutlet weak var songNamelabel: UILabel!
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var songProgressSilder: UISlider!
    @IBOutlet weak var pauseBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var previousBtn: UIButton!
    @IBOutlet weak var volumebtn: UIButton!
    @IBOutlet weak var volumeProgressSlider: UISlider!
    
//    var songName = ""
//    var songUrl : URL!
    var songArray2 : [URL] = []
    var indexPath : IndexPath!
    var audioPlayer = AVAudioPlayer()
    var timer: Timer!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.playMusic(url: songArray2[indexPath.row])
        self.setupThing()
    }
    
    func setupThing(){
        self.volumeProgressSlider.isHidden = true
        pauseBtn.setTitle("", for: .normal)
        pauseBtn.setImage(UIImage.init(systemName: "pause.circle.fill"), for: .normal)
        nextBtn.setTitle("", for: .normal)
        nextBtn.setImage(UIImage.init(systemName: "arrowshape.turn.up.right.fill"), for: .normal)
        previousBtn.setTitle("", for: .normal)
        previousBtn.setImage(UIImage.init(systemName: "arrowshape.turn.up.left.fill"), for: .normal)
        volumebtn.setTitle("", for: .normal)
        volumebtn.setImage(UIImage.init(systemName: "volume.3.fill"), for: .normal)
        songProgressSilder.addTarget(self, action: #selector(songProgress(_ :)), for: .valueChanged)
        
        self.pauseBtn.addTarget(self, action: #selector(pauseAction(_ :)), for: .touchUpInside)
        self.nextBtn.addTarget(self, action: #selector(nextAction(_ :)), for: .touchUpInside)
        self.previousBtn.addTarget(self, action: #selector(previousAction(_ :)), for: .touchUpInside)
        self.volumebtn.addTarget(self, action: #selector(volumeAction(_ :)), for: .touchUpInside)
    }
    
    @objc func songProgress(_ sender: UISlider){
        audioPlayer.currentTime = TimeInterval(sender.value)
    }
    
    @objc func pauseAction(_ sender: UIButton){
        if audioPlayer.isPlaying {
            audioPlayer.pause()
            pauseBtn.setTitle("", for: .normal)
            pauseBtn.setImage(UIImage.init(systemName: "play.circle.fill"), for: .normal)
        }else{
            audioPlayer.play()
            pauseBtn.setTitle("", for: .normal)
            pauseBtn.setImage(UIImage.init(systemName: "pause.circle.fill"), for: .normal)
        }
    }
    
    @objc func nextAction(_ sender: UIButton){
        if indexPath.row < songArray2.count-1{
            indexPath.row += 1
            self.playMusic(url: songArray2[indexPath.row])
        }
    }
    
    @objc func previousAction(_ sender: UIButton){
        if indexPath.row > 0{
            indexPath.row -= 1
            self.playMusic(url: songArray2[indexPath.row])
        }
    }
    
    @objc func volumeAction(_ sender: UIButton){
        self.volumeProgressSlider.isHidden = false
        self.volumeProgressSlider.addTarget(self, action: #selector(volumeChanged), for: .valueChanged)
    }
    
    @objc func volumeChanged(){
        audioPlayer.volume = volumeProgressSlider.value
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            self.volumeProgressSlider.isHidden = true
        }
    }
    
    func playMusic(url: URL){
        do{
            self.songNamelabel.text = songArray2[indexPath.row].lastPathComponent
            self.imageView.image = UIImage(named: "playBtn")
            try audioPlayer = AVAudioPlayer(contentsOf: url)
            audioPlayer.delegate = self
            audioPlayer.prepareToPlay()
            audioPlayer.play()
            songProgressSilder.maximumValue = Float(audioPlayer.duration)
        }catch{
            print("Error in playing")
        }
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer(){
        songProgressSilder.value = Float(audioPlayer.currentTime)
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        timer.invalidate()
    }
    
    
    @IBAction func backAction(_ sender: UIButton) {
        audioPlayer.stop()
        timer.invalidate()
        dismiss(animated: true, completion: nil)
    }
    
}
