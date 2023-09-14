//
//  SwiftUIView.swift
//  
//
//  Created by Yousif Aladwani on 14/09/2023.
//

import SwiftUI
import AVKit

// used props: width, height
struct TheVideoPlayerView: View {
    @Binding var subviewData : SubView
    @Binding var subviewupdates : [SubViewUpdateRequest]
    
    // experiance vars
    @State var currentVidPlayer : CustomizedVideoPlayer = CustomizedVideoPlayer()
    @State var currntAvPlayer = AVPlayer()
    @State var loaded = false
    var body: some View {
        if loaded {
            currentVidPlayer
                .frame(width: CGFloat(subviewData.props?.width ?? 150), height: CGFloat(subviewData.props?.height ?? 150))
                .onChange(of: subviewupdates){_ in
                    checkSubviewUpdates()
                }
        } else if subviewData.props?.link == "" || subviewData.props?.link == nil {
            Label("Video Player contains an empty link", systemImage: "info.circle.fill")
                .bold()
                .foregroundStyle(.red)
                .frame(width: CGFloat(subviewData.props?.width ?? 150), height: CGFloat(subviewData.props?.height ?? 150))
        } else {
            Text("Loading Video Player")
                .frame(width: CGFloat(subviewData.props?.width ?? 150), height: CGFloat(subviewData.props?.height ?? 150))
                .onAppear() {
                    currntAvPlayer = AVPlayer(url: URL(string: subviewData.props?.link ?? "")!)
                    currentVidPlayer = CustomizedVideoPlayer(avPlayer: currntAvPlayer)
                    loaded = true
                    currntAvPlayer.play()
                }
        }
    }
    func checkSubviewUpdates (){
        var num = 0
        for u in subviewupdates {
            if u.action == "change_video_link" {
                if u.parent_id == subviewData.ID {
                    currentVidPlayer.updatePlayer(url: URL(string: u.new_link!)!, same_position: u.same_position!)
                    subviewupdates.remove(at: num)
                }
            } else if u.action == "change_video_state" {
                if u.parent_id == subviewData.ID {
                    if u.new_video_state == "play" {
                        currntAvPlayer.play()
                    } else if u.new_video_state == "puase" {
                        currntAvPlayer.pause()
                    }
                    subviewupdates.remove(at: num)
                }
            }
            num = num + 1
        }
    }
}

struct CustomizedVideoPlayer: UIViewControllerRepresentable {
    @State var avPlayer : AVPlayer = AVPlayer()
    @State var pipController: AVPictureInPictureController?
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        let player = avPlayer
        controller.player = player
        controller.allowsPictureInPicturePlayback = true
        
        if AVPictureInPictureController.isPictureInPictureSupported() {
            pipController = AVPictureInPictureController(playerLayer: AVPlayerLayer(player: player))
        }
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        // No need to implement anything here
    }

    func updatePlayer(url: URL, same_position:Bool) {
        let currentTime = avPlayer.currentTime()
        let playerItem = AVPlayerItem(url: url)
        avPlayer.replaceCurrentItem(with: playerItem)
        if same_position{
            avPlayer.seek(to: currentTime)
        }
    }

    func startPictureInPicture() {
        pipController?.startPictureInPicture()
    }
    
    func stopPictureInPicture() {
        pipController?.stopPictureInPicture()
    }
}


