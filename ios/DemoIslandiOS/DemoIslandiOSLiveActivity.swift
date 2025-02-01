//
//  DemoIslandiOSLiveActivity.swift
//  DemoIslandiOS
//
//  Created by mac on 25/01/25.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct DemoIslandiOSAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct DemoIslandiOSLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: DemoIslandiOSAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension DemoIslandiOSAttributes {
    fileprivate static var preview: DemoIslandiOSAttributes {
        DemoIslandiOSAttributes(name: "World")
    }
}

extension DemoIslandiOSAttributes.ContentState {
    fileprivate static var smiley: DemoIslandiOSAttributes.ContentState {
        DemoIslandiOSAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: DemoIslandiOSAttributes.ContentState {
         DemoIslandiOSAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: DemoIslandiOSAttributes.preview) {
   DemoIslandiOSLiveActivity()
} contentStates: {
    DemoIslandiOSAttributes.ContentState.smiley
    DemoIslandiOSAttributes.ContentState.starEyes
}
