//
//  TimeZoneTestHelpers.swift
//  ACCTests
//
//  Created by Rafiul Hasan on 11/20/25.
//

import Foundation

extension TimeZone {
    static var GMT: TimeZone {
        TimeZone(secondsFromGMT: 0)!
    }
}
