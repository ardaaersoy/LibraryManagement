//
//  MediaPlayer.swift
//  LibraryManagement
//
//  Created by Arda ERSOY on 12.05.2021.
//

import Foundation
import AVFoundation

class MediaPlayer {
    
    // MARK: - Define variables
    static let shared = MediaPlayer()
    private var player: AVAudioPlayer!
    
    // MARK: - Method for playing specified sound
    func playSound() {
        let soundUrl = Bundle.main.url(forResource: "note1", withExtension: "wav")
        
        do {
            if let url = soundUrl {
                player = try AVAudioPlayer(contentsOf: url)
                player.play()
            }
            
        } catch let err {
            print("Could not read contents", err.localizedDescription)
        }
    }
}
