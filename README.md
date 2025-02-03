


# 🍳 Cooking Timer App with Live Activities & Dynamic Island

This Flutter app integrates **iOS Live Activities** and **Dynamic Island** to display a **real-time countdown timer** for cooking dishes. The app uses the **[live_activities](https://pub.dev/packages/live_activities)** Flutter package to manage Live Activities and Dynamic Island features on iOS 16.1+ devices.

## 📖 Blog Post  

https://medium.com/@ashuflutterdev/integrating-ios-live-activities-in-flutter-with-the-live-activities-package-a-comprehensive-guide-08e201bbbe2d

---

## 🚀 Features
✅ **Live Activity Timer**: Displays a cooking countdown timer in **Dynamic Island** & **Lock Screen**.  
✅ **Real-Time Updates**: Updates the remaining time every second.  
✅ **Flutter & Swift Integration**: Uses **Dart for logic** and **Swift for Live Activity UI**.  
✅ **iOS 16.1+ Support**: Works only on iPhones with iOS 16.1 or later.  

---

## Screenshot 

<p align="center">  
  <img src="https://raw.githubusercontent.com/ashut08/dynamic_island_iOS_with_flutter/refs/heads/main/Screenshot/home.png" alt="Home" width="250"/>  
  <img src="https://raw.githubusercontent.com/ashut08/dynamic_island_iOS_with_flutter/refs/heads/main/Screenshot/island1.png" alt="Swipe Left" width="250"/>  
  <img src="https://raw.githubusercontent.com/ashut08/dynamic_island_iOS_with_flutter/refs/heads/main/Screenshot/island2.png" alt="Uncontacted Tab" width="250"/>  
 
</p>  

## 📌 Requirements
- **Flutter 3.x**
- **Dart 3.x**
- **Xcode (for iOS development)**
- **iOS 16.1+ (Live Activities Support)**





### **3️⃣ Live Activities Implementation**
#### **🔹 Dart Code (Start Cooking Timer)**
```dart
import 'dart:async';
import 'package:live_activities/live_activities.dart';

final liveActivities = LiveActivities();
String? _activityId;
Timer? timer;

  @override
  void initState() {
    super.initState();

    super.initState();
    _initLiveActivities();
  }

  Future<void> _initLiveActivities() async {
    try {
      await liveActivities.init(appGroupId: "group.com.example.demoisland");
    } catch (e) {
      debugPrint("Error initializing Live Activities: $e");
    }
  }
 Future<void> _startCookingTimer() async {
    if (_dishNameController.text.isEmpty || _selectedMinutes == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please enter dish name & select cooking time')),
      );
      return;
    }

    // Convert the selected minutes to seconds for the countdown
    double totalTimeInSeconds = (_selectedMinutes ?? 0) * 60;

    // Create the activity with the initial time
    final activityId = await liveActivities.createActivity({
      'dishname': _dishNameController.text,
      'endtime': totalTimeInSeconds, // Store time in seconds
    });

    setState(() {
      _activityId = activityId;
    });

    // Start the timer for the countdown
    timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (totalTimeInSeconds <= 0) {
        timer.cancel();
        _stopCookingTimer();
        // Stop the timer when time is up
      } else {
        totalTimeInSeconds -= 1; // Decrease by one second

        await liveActivities.updateActivity(_activityId ?? "", {
          'endtime': totalTimeInSeconds, // Update the remaining time
        });
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:
            Text('🍳 Cooking timer started for ${_dishNameController.text}!'),
      ),
    );
  }

  Future<void> _stopCookingTimer() async {
    if (_activityId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No active cooking timer')),
      );
      return;
    }

    await liveActivities.endActivity(_activityId!);

    setState(() {
      _activityId = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Cooking timer stopped! ⏹️')),
    );
  }

```

#### **🔹 Swift Code (Live Activity Widget)**
Modify `DemoIslandiOS.swift`:
```swift
import ActivityKit
import WidgetKit
import SwiftUI

struct LiveActivitiesAppAttributes: ActivityAttributes, Identifiable {
    public typealias LiveDeliveryData = ContentState

    public struct ContentState: Codable, Hashable {}

    var id = UUID()
}

struct  DemoIslandiOS: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: LiveActivitiesAppAttributes.self) { context in
            let remainingTime = context.state.remainingTime
            VStack {
                Text("🍳 Cooking: \(UserDefaults(suiteName: "group.com.example.myapp")!.string(forKey: "dishname") ?? "Unknown")")
                    .font(.title3)
                    .bold()
                    .foregroundColor(.white)
                Text("⏳ Remaining Time: \(formattedCountdown(from: remainingTime))")
                    .font(.headline)
                    .foregroundColor(.yellow)
            }
            .padding()
            .background(Color.black.opacity(0.8))
            .clipShape(RoundedRectangle(cornerRadius: 15))
        } dynamicIsland: { context in
            let remainingTime = context.state.remainingTime
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    Text("🍳 Cooking")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("\(formattedCountdown(from: remainingTime))")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("⌛ Cooking in Progress... \(formattedCountdown(from: remainingTime))")
                        .font(.headline)
                        .foregroundColor(.yellow)
                }
            } compactLeading: {
                Text("🍳")
            } compactTrailing: {
                Text("\(formattedCountdown(from: remainingTime))")
            } minimal: {
                Text("⏳")
            }
        }
    }
}

// Function to format countdown time in MM:SS format
func formattedCountdown(from timeInterval: TimeInterval) -> String {
    let minutes = Int(timeInterval) / 60
    let seconds = Int(timeInterval) % 60
    return String(format: "%02d:%02d", minutes, seconds)
}
```

---

### **4️⃣ Flutter & Swift Integration**
- **Flutter** sends data to **Swift** using `UserDefaults` with the **same App Group**.
- The **Live Activity** is updated every second in **Swift** using the data passed from **Flutter**.

---

## 🏁 Usage
To start the cooking timer, simply call the `startCookingTimer()` function:



This will:
1. Start a Live Activity for the cooking timer.
2. Update the **Dynamic Island** every second as the countdown decreases.

---

## 📝 Notes
- **Live Activities** and **Dynamic Island** are only available on devices with **iOS 16.1** or later.


---

## 🛠 Development Tips
- Ensure that both **Flutter** and **Swift** use the **same App Group** for sharing data.
- **Test on a physical device** to view the Dynamic Island behavior.
- Make sure to handle background execution and edge cases, such as when the app goes into the background.

---

## 🔗 Resources
- [Flutter Live Activities Package](https://pub.dev/packages/live_activities)
- [iOS ActivityKit Documentation](https://developer.apple.com/documentation/activitykit)


