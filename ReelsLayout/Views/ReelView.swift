//
//  ReelView.swift
//  ReelsLayout
//
//  Created by darktech4 on 30/11/2023.
//

import SwiftUI
import AVFoundation

struct ReelView: View {
    @Binding var reel: Reel
    @Binding var likeCounter: [Like]
    var size: CGSize
    var safeArea: EdgeInsets
    //View props
    @State private var player: AVPlayer?
    @State private var looper: AVPlayerLooper?
    
    var body: some View {
        GeometryReader{
            let rect = $0.frame(in: .scrollView(axis: .vertical))
            // Custom video player
            CustomVideoPlayer(player: $player)
            //offset update
                .preference(key: OffsetKey.self, value: rect)
                .onPreferenceChange(OffsetKey.self ,perform: { value in
                    playPause(value)
                })
                .overlay(alignment: .bottom,content: {
                    ReelDetailsView()
                })
                //double tap like animation
                .onTapGesture(count: 2) { pos in
                    let id = UUID()
                    likeCounter.append(.init(id: id, tappedRect: pos, animated: false))
                    // animating like
                    withAnimation(.snappy(duration: 1.2), completionCriteria: .logicallyComplete) {
                        if let index = likeCounter.firstIndex(where: { $0.id == id}) {
                            likeCounter[index].animated = true
                        }
                    } completion: {
                        //                        likeCounter.removeAll(where: { $0.id == id})
                    }
                    //like this reel
                    reel.isLike = true
                }
                .onAppear{
                    guard player == nil else { return }
                    guard let bundleID = Bundle.main.path(forResource: reel.videoID, ofType: "mp4") else {return}
                    
                    let videoURL = URL(filePath: bundleID)
                    
                    let playerItem = AVPlayerItem(url: videoURL)
                    let queue = AVQueuePlayer(playerItem: playerItem)
                    looper = AVPlayerLooper(player: queue, templateItem: playerItem)
                    player = queue
                }
                .onDisappear{
                    player = nil
                }
        }
    }
    
    // play / pause action
    func playPause(_ rect: CGRect){
        if -rect.minY < (rect.height * 0.5) && rect.minY < (rect.height * 0.5){
            player?.play()
        }else{
            player?.pause()
        }
        
        if rect.minY >= size.height || -rect.minY >= size.height{
            player?.seek(to: .zero)
        }
    }
    
    @ViewBuilder
    func ReelDetailsView() -> some View{
        HStack (alignment: .bottom, spacing: 10) {
            VStack(alignment: .leading, spacing: 8, content: {
                HStack(spacing: 10) {
                    Image (systemName: "person.circle.fill")
                        .font (.largeTitle)
                    Text (reel.authorName)
                        .font(.callout)
                        .lineLimit(1)
                }
                .foregroundStyle(.white)
                Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry")
                    .font(.caption)
                    .foregroundStyle (.secondary)
                    .lineLimit (2)
                    .clipped()
            })
            
            Spacer (minLength: 0)
            
            VStack(spacing: 35){
                Button("", systemImage: reel.isLike ? "suit.heart.fill" : "suit.heart"){
                    reel.isLike.toggle()
                }
                .symbolEffect(.bounce, value: reel.isLike)
                .foregroundStyle(reel.isLike ? .red : .white)
                
                Button("", systemImage: "message"){}
                
                Button("", systemImage: "paperplane"){}
                
                Button("", systemImage: "ellipsis"){}
                
            }
            .font(.title2)
            .foregroundStyle(.white)
        }
        .padding(.leading, 15)
        .padding(.trailing, 10)
        .padding(.bottom, safeArea.bottom + 15)
    }
    
}

#Preview {
    ContentView()
}
