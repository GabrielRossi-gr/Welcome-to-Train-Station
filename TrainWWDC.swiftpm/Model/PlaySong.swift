//
//  PlaySong.swift
//  TrainWWDC
//
//  Created by Gabriel Rossi on 19/02/24.
//

import Foundation
import AVFoundation

import AVFoundation

class PlaySong {
//    static let shared = PlaySong()

    private var audioPlayer: AVAudioPlayer?

//    public init() {}
    
    var songName: String
    
    public init(songName: String) {
        self.songName = songName
    }
    
    func playAudio(loop: Bool, enableSongs: Bool) {
        if(enableSongs){
            guard let path = Bundle.main.path(forResource: songName, ofType: nil) else {
                print("Arquivo de áudio \(songName) não encontrado")
                return
            }
            
            do {
                if(loop){
                    
                    audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                    audioPlayer?.prepareToPlay()
                    audioPlayer?.numberOfLoops = -1
                    audioPlayer?.play()
                    
                } else {
                    
                    audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                    audioPlayer?.prepareToPlay()
                    audioPlayer?.numberOfLoops = 0
                    audioPlayer?.play()
                    
                }
                
            } catch {
                print("Erro ao inicializar o player de áudio: \(error.localizedDescription)")
            }
        } else {
            print("disable songs")
        }
        
        

    }

    func stopAudio() {
        if let player = audioPlayer, player.isPlaying {
            player.stop()
        }
    }

    func pauseAudio() {
        if let player = audioPlayer, player.isPlaying {
            player.pause()
        }
    }

    func resumeAudio() {
        if let player = audioPlayer, !player.isPlaying {
            player.play()
        }
    }

    func isPlaying() -> Bool {
        return audioPlayer?.isPlaying ?? false
    }
}
