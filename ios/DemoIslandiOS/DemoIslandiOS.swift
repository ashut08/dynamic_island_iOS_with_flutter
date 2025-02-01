//
//  DemoIslandiOS.swift
//  DemoIslandiOS
//
//  Created by mac on 25/01/25.
//

import ActivityKit
import WidgetKit
import SwiftUI
struct LiveActivitiesAppAttributes: ActivityAttributes, Identifiable {
  public typealias LiveDeliveryData = ContentState // don't forget to add this line, otherwise, live activity will not display it.

  public struct ContentState: Codable, Hashable { }

  var id = UUID()
}


struct DemoIslandiOS: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: LiveActivitiesAppAttributes.self) { context in
         
            
            VStack {
                Text("Lock Screen: Test Event")
                    .font(.headline)
                Text("Ends in: 10 minutes")
                    .font(.subheadline)
            }
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    Text("Test Event")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("10 min")
                        .foregroundColor(.blue)
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Dynamic Island Works!")
                        .padding()
                        .background(Color.yellow)
                        .cornerRadius(8)
                }
            } compactLeading: {
                Text("dsdds")
            } compactTrailing: {
                Text("10 min")
            } minimal: {
                Text("dsdsdsd")
            }
        }
    }
    
}
extension LiveActivitiesAppAttributes {
  func prefixedKey(_ key: String) -> String {
    return "\(id)_\(key)"
  }
}
