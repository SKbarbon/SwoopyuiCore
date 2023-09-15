//
//  SwiftUIView.swift
//  
//
// 
//

import SwiftUI
import AVKit

// used props: width, height
struct TheVideoPlayerView: View {
    @Binding var subviewData : SubView
    @Binding var subviewupdates : [SubViewUpdateRequest]
    
    // experiance vars
    @State var currntAvPlayer = AVPlayer()
    @State var loaded = false
    @State var width : Int = 0
    @State var height : Int = 0

    var body: some View {
        if loaded {
            VideoPlayer(player: currntAvPlayer)
                .frame(width: CGFloat(width), height: CGFloat(height))
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
                    width = subviewData.props?.width ?? 150
                    height = subviewData.props?.height ?? 150
                    currntAvPlayer = AVPlayer(url: URL(string: subviewData.props?.link ?? "")!)
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
                    updatePlayer(url: URL(string: u.new_link!)!, same_position: u.same_position!)
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
            } else if u.action == "resize" {
                if u.parent_id == subviewData.ID {
                    width = u.width!
                    height = u.height!
                    
                    if subviewupdates.count > num {subviewupdates.remove(at: num)}
                }
            }
            num = num + 1
        }
    }
    func updatePlayer(url: URL, same_position:Bool) {
        let avPlayer = currntAvPlayer
        let currentTime = avPlayer.currentTime()
        let playerItem = AVPlayerItem(url: url)
        avPlayer.replaceCurrentItem(with: playerItem)
        if same_position{
            avPlayer.seek(to: currentTime)
        }
    }
}
