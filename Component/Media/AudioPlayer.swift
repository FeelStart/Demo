//
//  AudioPlayer.swift
//  Demo
//
//  Created by Jingfu Li on 2024/11/7.
//

/*
 * [KKSimplePlayer](https://gist.github.com/zonble/635ea00cb125bc50b3f5880e16ba71b7)
 */

import Foundation
import AudioToolbox

final public class AudioPlayer {
    var audioFile: AudioFileID?
    var audioQueue: AudioQueueRef?
    var audioStreamBasicDescription: AudioStreamBasicDescription = AudioStreamBasicDescription()
    var audioQueueBuffers = [AudioQueueBufferRef]()
    var packetIndex: Int64 = 0
    var packetMaxSize: UInt32 = 0
    var packetCount: UInt32 = 0
    public var isPlaying: Bool = false
    
    public init?(url: URL) {
        guard AudioFileOpenURL(url as CFURL, .readPermission, 0, &audioFile) == noErr else {
            return nil
        }
        
        // 获取 audioStreamBasicDescription
        var size = UInt32(MemoryLayout<AudioStreamBasicDescription>.size)
        guard AudioFileGetProperty(audioFile!, kAudioFilePropertyDataFormat, &size, &audioStreamBasicDescription) == noErr else {
            return nil
        }
        
        // 获取 packetCount
        size = UInt32(MemoryLayout<UInt64>.size)
        guard AudioFileGetProperty(audioFile!, kAudioFilePropertyAudioDataPacketCount, &size, &packetCount) == noErr else {
            return nil
        }
        
        // 获取 maxPacketSize
        size = UInt32(MemoryLayout<UInt32>.size)
        guard AudioFileGetProperty(audioFile!, kAudioFilePropertyMaximumPacketSize, &size, &packetMaxSize) == noErr else {
            return nil
        }
        
        // 创建 AudioQueue
        guard AudioQueueNewOutput(&audioStreamBasicDescription, { userData, audioQueue, buffer in
            let player = Unmanaged<AudioPlayer>.fromOpaque(userData!).takeUnretainedValue()
            player.fillBuffer(buffer)
        }, Unmanaged.passUnretained(self).toOpaque(), nil, nil, 0, &audioQueue) == noErr else {
            return nil
        }
        
        // 创建 AudioQueueBuffer
        for _ in 0..<3 {
            var buffer: AudioQueueBufferRef?
            guard AudioQueueAllocateBuffer(audioQueue!, packetMaxSize, &buffer) == noErr else {
                return nil
            }
            audioQueueBuffers.append(buffer!)
        }
        
        // 填充 AudioQueueBuffer
        for buffer in audioQueueBuffers {
            fillBuffer(buffer)
        }
    }
    
    func fillBuffer(_ buffer: AudioQueueBufferRef) {
        var bytes: UInt32 = packetMaxSize
        var packets: UInt32 = 1024
        var packetDescriptions = [AudioStreamPacketDescription]()
        guard AudioFileReadPacketData(audioFile!, false, &bytes, &packetDescriptions, packetIndex, &packets, buffer.pointee.mAudioData) == noErr else {
            return
        }

        if packets > 0 {
            buffer.pointee.mAudioDataByteSize = bytes
            guard AudioQueueEnqueueBuffer(audioQueue!, buffer, packets, packetDescriptions) == noErr else {
                return
            }
            packetIndex += Int64(packets)
        } else {
            isPlaying = false
        }
    }
    
    public func play() {
        isPlaying = true
        AudioQueueStart(audioQueue!, nil)
    }
}
