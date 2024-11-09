//
//  ViewController.swift
//  iOSMediaDemo
//
//  Created by Jingfu Li on 2024/11/1.
//

import UIKit
import Component

class ViewController: UIViewController {
    var audioPlayer: AudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let url = Bundle.resourceBundle.url(forResource: "Chasing Dreams", withExtension: "mp3") {
            audioPlayer = AudioPlayer(url: url)
        }
    }

    @IBAction func playButtonClicked(_ sender: Any) {
        audioPlayer?.play()
    }
}




