# Akaibu (アーカイブ)
A SwiftUI app for browsing and archiving anime & manga using the MyAnimeList API. Supports iOS and macOS. [iOS demo here](https://github.com/user-attachments/assets/0195d41f-313c-420e-824b-7a5e44d412a2).

![Swift](https://img.shields.io/badge/Swift-f05138?logo=swift&style=for-the-badge&logoColor=white) ![SwiftUI](https://img.shields.io/badge/SwiftUI-0096ff?logo=swift&style=for-the-badge&logoColor=36454f) ![iOS](https://img.shields.io/badge/iOS-808080?logo=ios&style=for-the-badge&logoColor=black) ![macOS](https://img.shields.io/badge/macOS-808080?logo=macos&style=for-the-badge&logoColor=black)

## ✨ Features

🔎 **Search & Browse Anime and Manga** – Discover titles instantly.

📚 **Personal Archive Management** – Track anime and manga by updating status (Watching, Completed, Plan to Watch/Read), score, and progress.

🏷️ **Genre Filtering** – Filter anime and manga results by genre.

🏆 **Top Rankings** – View ranked anime and manga lists.

📅 **Airing Schedules** – View currently airing anime and weekly broadcast schedules.

## 📥 Installation
### 🔹 Requirements
- Xcode 26.2+
- Device running **iOS 26.2+** or **macOS 26.2+**

### 📄 Set up `Secrets.xcconfig`
Inside `<project root>/Secrets.xcconfig` file, add the following properties:
```properties
MAL_CLIENT_ID = <MyAnimeList client id>
MAL_CLIENT_SECRET = <MyAnimeList client secret>
```

### 🔹 Debug Build
1. Clone the repository

    ```bash
    git clone https://github.com/kite1412/swift-akaibu.git
    ```
2. Open the downloaded repository in Xcode
3. Select run destination
4. Simply click run (▶️) button or command + R (⌘ + R).
