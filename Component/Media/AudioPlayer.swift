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

fileprivate func audioQueueOutputCallback(inUserData: UnsafeMutableRawPointer?, inAQ: AudioQueueRef, inBuffer: AudioQueueBufferRef) {
    let player = Unmanaged<AudioPlayer>.fromOpaque(inUserData!).takeUnretainedValue()
    //player.handleAudioQueueOutputCallback(inAQ: inAQ, inBuffer: inBuffer)
}

final public class AudioPlayer {
    let url: URL

    var fileID: AudioFileID?
    var audioStreamBasicDescription = AudioStreamBasicDescription()
    var audioQueue: AudioQueueRef?
    var audioQueueBuffers = [AudioQueueBufferRef]()
    var numPacketsToRead: UInt32 = 0
    var packetIndex: Int64 = 0
    var packetDescription = AudioStreamPacketDescription()

    //MARK: - Initialization

    public init?(url: URL) {
        self.url = url

        // 打开音频文件
        guard AudioFileOpenURL(url as CFURL, .readPermission, 0, &fileID) == noErr else {
            return nil
        }

        // 获取音频文件的数据格式
        var size: UInt32 = UInt32(MemoryLayout<AudioStreamBasicDescription>.stride)
        guard AudioFileGetProperty(fileID!, kAudioFilePropertyDataFormat, &size, &audioStreamBasicDescription) == noErr else {
            return nil
        }

        // 创建音频队列
        guard AudioQueueNewOutput(&audioStreamBasicDescription, audioQueueOutputCallback, Unmanaged.passUnretained(self).toOpaque(), nil, nil, 0, &audioQueue) == noErr else {
            return nil
        }

        // 获取音频文件的数据包数
        var propertySize = UInt32(MemoryLayout<UInt64>.stride)
        guard AudioFileGetProperty(fileID!, kAudioFilePropertyAudioDataPacketCount, &propertySize, &numPacketsToRead) == noErr else {
            return nil
        }

        // 创建音频队列缓冲区
        for _ in 0..<3 {
            var buffer: AudioQueueBufferRef?
            guard AudioQueueAllocateBuffer(audioQueue!, 1024, &buffer) == noErr else {
                return nil
            }
            audioQueueBuffers.append(buffer!)
        }

        // 填充音频队列缓冲区
        for buffer in audioQueueBuffers {
            handleAudioQueueOutputCallback(inAQ: audioQueue!, inBuffer: buffer)
        }

        print("AudioPlayer init")
    }

    //MARK: - Deinitialization

    deinit {
        AudioQueueDispose(audioQueue!, true)
        AudioFileClose(fileID!)
    }

    //MARK: - Private Methods

    private func handleAudioQueueOutputCallback(inAQ: AudioQueueRef, inBuffer: AudioQueueBufferRef) {
        var numBytes: UInt32 = inBuffer.pointee.mAudioDataBytesCapacity
        var numPackets = numPacketsToRead
        guard AudioFileReadPackets(fileID!, false, &numBytes, &packetDescription, packetIndex, &numPackets, inBuffer.pointee.mAudioData) == noErr else {
            return
        }

        if numPackets > 0 {
            inBuffer.pointee.mAudioDataByteSize = numBytes
            AudioQueueEnqueueBuffer(inAQ, inBuffer, numPackets, &packetDescription)
            packetIndex += Int64(numPackets)
        } else {
            AudioQueueStop(inAQ, false)
        }
    }

    //MARK: - Public Methods

    /// 播放音频
    public func play() {
        AudioQueueStart(audioQueue!, nil)
    }

    /// 暂停音频
    public func pause() {
        AudioQueuePause(audioQueue!)
    }

    /// 停止音频
    public func stop() {
    }
}
