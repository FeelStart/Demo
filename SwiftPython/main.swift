//
//  main.swift
//  SwiftPython
//
//  Created by Jingfu Li on 2024/7/11.
//

/**
 * 1 添加 PythonKit
 * File -> Add Package Dependencies -> ...
 *
 * 2  配置 Python
 * Edit Scheme 中的环境变量，设置以下的参数
 * PYTHON_VERSION=3
 * PYTHON_LOADER_LOGGING=1
 * PYTHON_LIBRARY=/Library/Developer/CommandLineTools/Library/Frameworks/Python3.framework/Versions/3.9/lib/libpython3.9.dylib
 *
 * TO SEE:
 * https://www.appcoda.com.tw/from-swift-import-python/
 * https://stackoverflow.com/questions/75495800/error-unable-to-extract-uploader-id-youtube-discord-py
 */

import Foundation
import PythonKit

// let PYTHON_LIBRARY = ProcessInfo.processInfo.environment["PYTHON_LIBRARY"]

let sys = Python.import("sys")
print("Python \(sys.version_info.major).\(sys.version_info.minor)")

sys.path.append("/Users/jingfuli/Documents/FeelStart/Demo/SwiftPython/Python")
let Download = Python.import("download")
Download.downloadVideo("https://www.youtube.com/watch?v=zSstXi-j7Qc", "/Users/jingfuli/Downloads/youtube")
