//
//  PhoneType.swift
//  ReLite
//
//  Created by SuperS0n1k on 20/06/2025.
//

import UIKit

func getDeviceIdentifier() -> String {
    #if targetEnvironment(simulator)
    // Simulator: get identifier from environment variable
    return ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "Simulator"
    #else
    // Real device: use uname
    var systemInfo = utsname()
    uname(&systemInfo)
    let machineMirror = Mirror(reflecting: systemInfo.machine)
    let identifier = machineMirror.children.reduce("") { identifier, element in
        guard let value = element.value as? Int8, value != 0 else { return identifier }
        return identifier + String(UnicodeScalar(UInt8(value)))
    }
    return identifier
    #endif
}
