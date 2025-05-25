# Condee 콘디
<!---- 배너 이미지 추가 ---->
 'Condee'는 Condition, Conti에서 따온 이름으로 다양한 배경화면 이미지를 생성할 수 있는 iOS Application 입니다.

 </div>

## 📱 Features

### 1. 메인 화면
   \- 사용자가 직접 생성한 이미지들을 격자 디자인을 통해 확인할 수 있습니다.<br/>
   \- 핀치 제스처를 통해 한 줄에 확인하고 싶은 이미지의 개수를 조절할 수 있습니다.<br/>
   \- 이미지를 선택해 자세한 이미지를 확인하고 공유 및 다운로드가 가능합니다.

### 2. 이미지 생성 화면
   \- 사용자 갤러리에 있는 이미지를 활용해 배경 및 추가 이미지를 활용할 수 있습니다.<br/>
   \- 클립보드에 있는 이미지를 활용할 수 있습니다.<br/>
   \- 기본적으로 제공하는 이모지를 활용할 수 있습니다.<br/>
   \- 직접 입력한 텍스트를 추가할 수 있습니다.(크기 및 색상 변경 가능)<br/>
   \- 텍스트가 있는 이미지에서 텍스트를 추출하여 이미지 형식으로 활용할 수 있습니다.

<br/>
 
## 🖼 Screenshot
### 메인 화면
<img width="200" src="https://github.com/user-attachments/assets/c6ecd833-75f7-435e-8718-bd1209b4306a">
<img width="200" src="https://github.com/user-attachments/assets/84442c8f-8dda-4df4-8675-5e68c9237701">
<img width="200" src="https://github.com/user-attachments/assets/4fdf69e0-416d-45ba-92e3-c507e3089484">

### 이미지 생성 화면
<img width="200" src="https://github.com/user-attachments/assets/9b88d3a1-690c-4d23-83ae-bee3348b4248">
<img width="200" src="https://github.com/user-attachments/assets/d2a054d0-7a81-4bcd-a6c1-958aad9762c8">
<img width="200" src="https://github.com/user-attachments/assets/e63b1389-310c-4e3e-b695-71b574baf59a">
<img width="200" src="https://github.com/user-attachments/assets/9ffc8595-7ae0-4a81-ba7f-73042d9388d8">
<img width="200" src="https://github.com/user-attachments/assets/53d501e3-b595-4f33-a00b-99fbf3164001">
<img width="200" src="https://github.com/user-attachments/assets/3b683b66-2853-4331-ba6c-4a54ad2b6ca6">
<img width="200" src="https://github.com/user-attachments/assets/17de4b45-f331-4e1b-93eb-a6bfcdc30340">



## 🛠 Development

### Tech Skills

<img width="80" alt="SwiftUI" src="https://img.shields.io/badge/SwiftUI-9cf">  <img width="90" alt="Combine" src="https://img.shields.io/badge/Combine-DBCFC1">


### Libraries
<img width="75" alt="OpenCV" src="https://img.shields.io/badge/OpenCV-blueviolet">  <img width="75" alt="SwiftData" src="https://img.shields.io/badge/SwiftData-ff69b4">

### Environment

<img width="85" alt="스크린샷 2021-11-19 오후 3 52 02" src="https://img.shields.io/badge/iOS-16.0+-silver">  <img width="95" alt="스크린샷 2021-11-19 오후 3 52 02" src="https://img.shields.io/badge/Xcode-16.1-blue">

### Project Structure

```
Selterview
    |
    ├── Resources
    │       └── Assets.xcassets
    │
    ├── Sources
    │       ├── Application
    |       │       ├── CondeeApp
    │       │       └── DIContainer
    |       |
    │       ├── Data
    |       │     └── Repositories
    |       |
    │       ├── Domain
    |       │     ├── Entities
    |       │     ├── Enums
    |       │     ├── Interfaces
    |       │     └── UseCases
    |       |
    │       └── Presentation
    |               ├── Main
    |               │     ├── View
    |               |     |     ├── Components
    |               |     |     ├── Modifiers
    |               |     |     ├── Scenes
    |               |     |     └── SubViews
    |               │     |
    |               │     └── ViewModel
    |               │
    |               └── Styles
    |               │
    |               └── Utils
    |                     └── Extensions
    │
    └── Tests
          ├── CondeeTests=
          |
          ├── CondeeUITests
          |
          ├── Mocks
          │     ├── Repositories
          │     └── UseCases
          |
          └── TestDIContainer

```

<br/>
