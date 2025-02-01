import ActivityKit
import WidgetKit
import SwiftUI

struct LiveActivitiesAppAttributes: ActivityAttributes, Identifiable {
    public typealias LiveDeliveryData = ContentState

    public struct ContentState: Codable, Hashable {}

    var id = UUID()
}

let sharedDefault = UserDefaults(suiteName: "group.com.example.demoisland")!

struct DemoIslandiOS: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: LiveActivitiesAppAttributes.self) { context in
            let dishName = sharedDefault.string(forKey: context.attributes.prefixedKey("dishname")) ?? "Unknown"
                        let totalTimeValue = sharedDefault.double(forKey: context.attributes.prefixedKey("totaltime"))
                        let totalTime = TimeInterval(totalTimeValue * 60) //
         
       

            VStack {
                Text("🍳 Cooking: \(dishName)")
                    .font(.title3)
                    .bold()
                    .foregroundColor(.white)
                    .padding(.top, 5)

                Text("⏳ Total Time: \(totalTimeValue) minutes")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .padding(.bottom, 5)
                
              
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(LinearGradient(
                gradient: Gradient(colors: [.orange, .red]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            ))
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .padding()
        } dynamicIsland: { context in
            let dishName = sharedDefault.string(forKey: context.attributes.prefixedKey("dishname")) ?? "Unknown"
            let totalTimeValue = sharedDefault.double(forKey: context.attributes.prefixedKey("endtime"))
              


            return DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    Text("🍽️ \(dishName)")
                        .font(.headline)
                        .foregroundColor(.white)
                }
                DynamicIslandExpandedRegion(.trailing) {
                    
                    VStack{
                        Text("\(formattedCountdown(from: totalTimeValue))")
                    }
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("⌛ Cooking in Progress...")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.9))
                        .padding(8)
                        .background(Color.black.opacity(0.5))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                  
                    Text("Remaining Time: \(formattedCountdown(from: totalTimeValue))")
                                           .font(.headline)
                                           .foregroundColor(.yellow)
                }
            } compactLeading: {
                Text("🍳")
            } compactTrailing: {
                Text("\(formattedCountdown(from: totalTimeValue))")
            } minimal: {
                Text("⏳")
            }
        }
        
    }
   
    
}

// Function to format countdown time correctly
func formattedCountdown(from timeInterval: TimeInterval) -> String {
    let minutes = Int(timeInterval) / 60
    let seconds = Int(timeInterval) % 60
    return String(format: "%02d:%02d", minutes, seconds)
}
extension LiveActivitiesAppAttributes {
    func prefixedKey(_ key: String) -> String {
        return "\(id)_\(key)"
    }
}
