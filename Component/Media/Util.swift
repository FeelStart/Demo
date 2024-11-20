//
//  Util.swift
//  Demo
//
//  Created by Jingfu Li on 2024/11/20.
//

import AudioToolbox

final class Player {
    var audioFile: AudioFileID?
    var audioQueue: AudioQueueRef?
    var audioQueueBuffer: [AudioQueueBufferRef] = []
    var audioStreamBasicDescription: AudioStreamBasicDescription = AudioStreamBasicDescription()
    var packetIndex: Int64 = 0
    var packetCount: UInt32 = 0
    var packetMaxSize: UInt32 = 0
    var isPlaying: Bool = false

    public init?(url: URL) {
        guard AudioFileOpenURL(url as CFURL, .readPermission, 0, &audioFile) == noErr else {
            return nil
        }

        var size: UInt32 = UInt32(MemoryLayout<AudioStreamBasicDescription>.size)
        guard AudioFileGetProperty(audioFile!, kAudioFilePropertyDataFormat, &size, &audioStreamBasicDescription) == noErr else {
            return nil
        }

        size = UInt32(MemoryLayout<UInt64>.size)
        guard AudioFileGetProperty(audioFile!, kAudioFilePropertyAudioDataPacketCount, &size, &packetCount) == noErr else {
            return nil
        }

        // kAudioFilePropertyPacketSizeUpperBound
        size = UInt32(MemoryLayout<UInt32>.size)
        guard AudioFileGetProperty(audioFile!, kAudioFilePropertyMaximumPacketSize, &size, &packetMaxSize) == noErr else {
            return nil
        }

        guard AudioQueueNewOutput(&audioStreamBasicDescription, { inUserData, queue, buffer in
            let player = Unmanaged<Player>.fromOpaque(inUserData!).takeUnretainedValue()
            player.fillBuffer(buffer)
        }, Unmanaged.passUnretained(self).toOpaque(), nil, nil, 0, &audioQueue) == noErr else {
            return nil
        }

        for _ in 0...3 {
            var buffer: AudioQueueBufferRef?
            guard AudioQueueAllocateBuffer(audioQueue!, packetMaxSize, &buffer) == noErr else {
                return nil
            }
            audioQueueBuffer.append(buffer!)
        }

        for buffer in audioQueueBuffer {
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
        guard AudioQueueStart(audioQueue!, nil) == noErr else {
            return
        }
    }

    deinit {
        AudioQueueDispose(audioQueue!, true)
        AudioFileClose(audioFile!)
    }
}

