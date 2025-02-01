# demoisland

Here's the **README.md** file formatted so you can directly paste it into your project. 🚀  

---

### **📌 README.md for Cooking Timer & Recipe Tracker**
```md
# 🍳 Cooking Timer & Recipe Tracker  

**Cooking Timer & Recipe Tracker** is a **Flutter app** that uses **iOS Live Activities & Dynamic Island** to track cooking times in real-time. The app helps home cooks and chefs by displaying **dish name & remaining cooking time** on **Dynamic Island & Lock Screen**.  

## 📸 Screenshots  
🚀 *Add images here* (e.g., Dynamic Island showing countdown, app UI, etc.)

---

## 📌 Features  
✅ **Set a cooking timer for any dish**  
✅ **Real-time countdown on Dynamic Island**  
✅ **Automatic updates via Live Activities**  
✅ **Hands-free tracking while cooking**  
✅ **Works on iPhone 14 Pro+ & iOS 16.1+**  

---

## 📲 Installation  

### 1️⃣ Clone the Repository  
```sh
git clone https://github.com/yourusername/cooking-timer-live-activities.git
cd cooking-timer-live-activities
```

### 2️⃣ Install Dependencies  
```sh
flutter pub get
```

### 3️⃣ iOS Setup  
1. Open **ios/Runner.xcworkspace** in Xcode.  
2. Add **Live Activities & App Groups** capabilities:  
   - **Enable App Groups** (`group.com.example.demoisland`).  
   - **Enable Push Notifications** (if needed).  
   - Add the following in **Info.plist** for both `Runner` and `Widget Extension`:  

```xml
<key>NSSupportsLiveActivities</key>
<true/>
```

3. Install iOS dependencies:  
```sh
cd ios
pod install
```

---

## 🚀 Usage  

### **1️⃣ Start Cooking Timer**  
1. Enter the **dish name**.  
2. Select **cooking duration**.  
3. Tap **"Start Cooking Timer"**.  

### **2️⃣ Dynamic Island Updates**  
- The timer **updates in real-time** on **Dynamic Island**.  
- Displays **time left & dish name**.  

### **3️⃣ Stop Timer**  
- Tap **"Stop Cooking Timer"** to end Live Activity.  

---

## 🛠 Technology Stack  
- **Flutter**  
- **Dart**  
- **Swift & SwiftUI (ActivityKit, WidgetKit)**  
- **Live Activities & Dynamic Island (iOS 16.1+)**  

---

## 🔗 API & Code Reference  

### **Flutter Live Activities Code**  
```dart
final activityId = await liveActivities.createActivity({
  'dishname': _dishNameController.text,
  'endtime': selectedMinutes * 60,
});
```

### **Swift Live Activity Widget Code**  
```swift
let dishName = sharedDefault.string(forKey: context.attributes.prefixedKey("dishname")) ?? "Unknown"
let totalTimeValue = sharedDefault.double(forKey: context.attributes.prefixedKey("endtime"))
```

---

## ✨ Contributing  
1. **Fork the repository**  
2. **Create a new branch**  
3. **Submit a Pull Request (PR)**  

---

## 📜 License  
This project is licensed under the **MIT License**.

---

## 📩 Contact  
💬 **Created by:** Ashutosh  
📧 Email: your@email.com  
🔗 GitHub: [yourusername](https://github.com/yourusername)  
```

---

### **✅ Next Steps**
1️⃣ **Paste this into your README.md**  
2️⃣ **Update placeholders (GitHub username, email, screenshots)**  
3️⃣ **Push the project to GitHub 🚀**  

Let me know if you need any changes! 🎉🔥