//
//  DemoIslandiOSBundle.swift
//  DemoIslandiOS
//
//  Created by mac on 25/01/25.
//

import WidgetKit
import SwiftUI

@main
struct DemoIslandiOSBundle: WidgetBundle {
    var body: some Widget {
        DemoIslandiOS()
        DemoIslandiOSControl()
        DemoIslandiOSLiveActivity()
    }
}
