//
//  VideoServer.swift
//  TestRecordAndCompress
//
//  Created by ysj on 2017/11/15.
//  Copyright © 2017年 ysj. All rights reserved.
//

import Foundation
import Photos
import AssetsLibrary
import MediaPlayer

class VideoServer: NSObject {
    
    public static var shared = VideoServer()
    
    func compressVideo(url: URL, name: String, isSave: Bool, successHandle: @escaping ((Data, UIImage) -> Void), failHandle: (() -> Void)? ) {
        
        let asset = AVURLAsset(url: url)
        
        let exportSession = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetMediumQuality)
        exportSession?.shouldOptimizeForNetworkUse = true
        exportSession?.outputURL = compressURL(name: name)
        exportSession?.outputFileType = .mp4
        
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: compressURL(name: name).path) {
            do {
                print("尝试删除原重名老文件")
                try fileManager.removeItem(atPath: compressURL(name: name).path)
            } catch _ {
                print("删除原重名老文件失败")
            }
        }
        
        exportSession?.exportAsynchronously(completionHandler: { [weak self] in
            guard let weakSelf = self else {
                return
            }
            if exportSession?.status == .completed {
                print("视频压缩成功")
                if isSave {
                    print("压缩视频正在保存至相册")
                    weakSelf.saveVideo(url: weakSelf.compressURL(name: name))
                }
                
                do {
                    let data = try Data.init(contentsOf: weakSelf.compressURL(name: name))
                    successHandle(data, weakSelf.getImageWithVideoURL(url: weakSelf.compressURL(name: name)))
                } catch _ {
                    print("压缩视频转化data失败")
                }
                
            } else {
                print("视频压缩失败")
                if let closure = failHandle {
                    closure()
                }
            }
        })
    }
    
    func getImageWithVideoURL(url: URL) -> UIImage {
        
        let mpPlayer = MPMoviePlayerController(contentURL: url)
        let image = mpPlayer?.thumbnailImage(atTime: 0.0, timeOption: .nearestKeyFrame)
        return image!
    }
    
    func compressURL(name: String) -> URL {
        return URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? "").appendingPathComponent("\(name).mp4")
    }
    
    func saveVideo(url: URL) {
        PHPhotoLibrary.shared().performChanges({
            PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: url)
        }) { (isSuccess, error) in
            if isSuccess {
                print("视频保存到相册成功")
            } else {
                print("视频保存到相册失败")
            }
        }
    }
}
