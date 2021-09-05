//
//  MicroCMSRequester.swift
//  MediaApp
//
//  Created by FX on 2021/09/05.
//

import Foundation


class MicroCMSRequester: ObservableObject {
    @Published var articles = [Article]()
    private let iso8601DateFormatter = ISO8601DateFormatter()
    
    init() {
        iso8601DateFormatter.formatOptions.insert(.withFractionalSeconds)
    }
}
