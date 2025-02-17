# Kirala - Rental Platform

## Table of Contents
1. [Description](#description)
2. [App Features](#app-features)
3. [Development](#development)
4. [Installation](#installation)
   - [Requirements](#requirements)
   - [Steps](#steps)
5. [Usage](#usage)
6. [Detailed Description](#detailed-description)
7. [Screenshots](#screenshots)
   - [Home](#home)
   - [Favorite](#favorite)
   - [Detail](#detail)
   - [Others](#others)


##  Description  
Kirala is an iOS application that enables users to rent out underutilized items from their homes and allows others to rent them for short-term needs. Users can list items, manage rental requests, and browse available rentals. The app offers secure authentication, favorites, cart, and order tracking, ensuring a seamless and user-friendly rental experience while promoting sustainable consumption.  

## App Features

- **Browse & Search:** Users can explore rental listings and search for specific items.
- **User Authentication:** Supports email/password, Google, and Apple sign-in.
- **Item Listings:** Users can list items with details like name, category, price, and description.
- **Rental Management:** Includes order tracking, request approvals, and rental history.
- **Favorites & Cart:** Users can save items for later or add them to the cart for quick checkout.
- **Dark Mode Support:** Fully compatible with iOS dark mode.
- **Multi-Language Support:** English and Turkish available.

- ## Development

- **Platform:** iOS
- **Language:** Swift
- **Architecture:** MVVM (Model-View-ViewModel), Protocol Oriented Programming
- **UI Framework:** UIKit (programmatic)
- **Localization:** The app supports multiple languages, including English and Turkish.
- **Dark Mode:** Full support for Dark Mode is implemented.
- **Error Handling & Loading States:** Custom UI views are developed for handling errors and loading states.
- **Network Layer:** A generic network layer is implemented for efficient API calls.
- **Custom Animations:** Enhancing user interaction with custom animations.
- **Design Patterns & Techniques:**
  - **Protocol Oriented Programming**
  - **Delegate Pattern**
  - **Notification Center**
  - **Builder Pattern**
  - **Dependency Injection**
- **Third-Party Frameworks:**
  - **[JTAppleCalendar](https://github.com/Ramotion/paper-onboarding)**
  - **[Kingfisher](https://github.com/onevcat/Kingfisher)**
  - **[Lottie](https://github.com/airbnb/lottie-ios)**
- **Manually Added Third-Party Frameworks:**
  - **[ImageSlider](https://github.com/Trendyol/ios-components/tree/master/UILibraries/ImageSlider)**
  - **[PinchableImageView](https://github.com/Trendyol/ios-components/tree/master/UILibraries/PinchableImageView/)**
  - **[AutoCompleteTextField](https://github.com/Trendyol/ios-components/tree/master/UILibraries/AutoCompleteTextField)** 
  - **[ProgressHUD](https://github.com/relatedcode/ProgressHUD)**
  - **[Cosmos](https://github.com/evgenyneu/Cosmos)**
  - **[Pretty Card](https://github.com/simla-tech/PrettyCards)**
  - **[Fastis](https://github.com/simla-tech/Fastis)(Modified)**
  - **[Bottom Popup](https://github.com/ergunemr/BottomPopup)**

 ## Installation

### Requirements

- Xcode (latest version)
- iOS 11.0 or later
- Swift 5+

### Steps

1. **Clone the Repository:**
   ```bash
   git clone https://github.com/alicolak64/Kirala.git
   cd kirala
   ```

2. **Install Dependencies:**
   - Swift Package Manager, add dependencies through Xcode.

4. **Run the Project:**
   - Open the project in Xcode, select a target device or simulator, and run.

## Usage

- **Sign Up & Login:** Users can register with email/password, Google, or Apple authentication and verify the email verification email
- **Rent an Item:** Browse through listings, filter, and search for available rental items.
- **List an Item:** Create a new listing via the "My Listings" page and manage existing listings.
- **Order Management:** Track rental transactions via the "My Orders" page.

### Detailed Description  

Kirala aims to develop an iOS application that facilitates the rental of underutilized or unused items in users’ homes. With Kirala, users can upload items they wish to rent out, set daily rental prices, and make them available for others to rent. Additionally, the application provides a platform for users who have short-term needs for certain items but prefer not to purchase them outright. These users can browse through available rental items listed by others and proceed with renting them as needed.

The application offers a seamless experience for both registered and unregistered users. Unregistered users can browse through the available rental listings, while those who wish to place orders are prompted to create an account. Users interested in listing rental items are required to have an account, ensuring a level of accountability within the platform. Therefore, the application encompasses features for both unregistered users, including viewing available listings, as well as login and registration pages for account creation.

Kirala offers multiple options for user registration and login. Users can sign up using their email address and password, log in with their Google account, or utilize their Apple account for authentication. Upon creating an account and logging in, users who wish to list rental items can navigate to the listing creation page. Here, they can input details such as category selection, item name, price, and description before sharing their listings with the platform users, all free of charge. They can manage their posted listings and respond to incoming requests through the My Listings page, where they can approve or reject requests as needed.

For users interested in renting items, the application provides filtering options based on categories, as well as a search feature by item name. Users can add desired items to their cart or mark them as favorites for future reference. The checkout process allows users to review items in their cart and place orders seamlessly. Additionally, users can track the status of their orders through the My Orders page.

The Kirala application not only focuses on facilitating rentals but also ensures a secure and user-friendly experience. Security measures such as encryption and secure authentication mechanisms are implemented to protect user data and transactions. The application adheres to relevant data protection regulations to ensure the privacy and security of user information.

Furthermore, the design and development of the Kirala application are guided by industry standards and best practices to ensure a high-quality, reliable, and accessible platform. The user interface is designed to be intuitive and visually appealing, providing a smooth navigation experience for all users.

The development of Kirala involves a comprehensive approach, including backend development for data management and user authentication, iOS development for a robust user interface, and deployment strategies for continuous integration and continuous deployment (CI/CD). Testing procedures are conducted to ensure the functionality and reliability of the application, addressing any issues before deployment.

Overall, the Kirala project aims to create a dynamic and efficient rental platform that connects users looking to rent out their unused items with those in need of short-term rentals. By providing a secure, user-friendly, and well-designed application, Kirala strives to enhance the rental experience for all users, fostering a community of shared resources and sustainable consumption.

## Screenshots

### Home

| Home Screen 1 | Home Screen 2 | Home Screen 3 | Home Screen 4 | Detail Share | Dark Mode |
|--|--|--|--|--|--|
|<img width="350" alt="Home Screen 1" src="https://github.com/alicolak64/UniTurkey/assets/71923609/f2522272-cb8b-45dc-9578-4f7db0bc0fb4"> |<img width="350" alt="Home Screen 2" src="https://github.com/alicolak64/UniTurkey/assets/71923609/e42a38f0-5de3-4fe4-9d5d-6a9c1ac15124">|<img width="350" alt="Home Screen 3" src="https://github.com/alicolak64/UniTurkey/assets/71923609/177d5790-f29c-428b-833c-55aa0970b829">|<img width="350" alt="Home Screen 4" src="https://github.com/alicolak64/UniTurkey/assets/71923609/935e859c-d574-413b-bcdf-9517801a0cd6">|<img width="350" alt="Detail Share" src="https://github.com/alicolak64/UniTurkey/assets/71923609/928f23fe-0a07-4bba-9d70-9301cd7405e0">|<img width="350" alt="Dark Mode" src="https://github.com/alicolak64/UniTurkey/assets/71923609/856cd838-3daf-4ac7-831c-fc3b7888a28f">

### Favorite
| Favorite Screen 1 | Favorite Screen 2 | Favorite Screen 3 | Dark Mode |
|--|--|--|--|
|<img width="350" alt="Favorite1" src="https://github.com/alicolak64/UniTurkey/assets/71923609/994bb841-755b-4b5f-a1f1-7b5c8e508084">|<img width="350" alt="Favorite2" src="https://github.com/alicolak64/UniTurkey/assets/71923609/9f589d41-dbfe-46fd-8e04-4ad4688ada66">|<img width="350" alt="Favorite3" src="https://github.com/alicolak64/UniTurkey/assets/71923609/3d2a6419-5a79-478a-98a9-ba5d79c407b2">|<img width="350" alt="Favorite4" src="https://github.com/alicolak64/UniTurkey/assets/71923609/32b74c6d-5ebe-4bcc-9376-b91e04899166">

### Detail
| Detail Screen 1 | Detail Screen 2 | Detail Screen 3 | Detail Screen 4 | Dark Mode |
|--|--|--|--|--|
<img width="350" alt="Detail1" src="https://github.com/alicolak64/UniTurkey/assets/71923609/37fd3730-13b4-4631-a984-0bb510bd5ba0"> |<img width="350" alt="Detail2" src="https://github.com/alicolak64/UniTurkey/assets/71923609/b9669428-ea83-4895-90e6-fce23fd5dc72"> |<img width="350" alt="Detail3" src="https://github.com/alicolak64/UniTurkey/assets/71923609/2e3d16cf-74d2-4b75-94ac-b5c59e42888b"> |<img width="350" alt="Detail4" src="https://github.com/alicolak64/UniTurkey/assets/71923609/04fd1919-eea1-448e-bebe-79a475175efd"> |<img width="350" alt="Detail5" src="https://github.com/alicolak64/UniTurkey/assets/71923609/9d29928a-e148-407a-a4e2-3c12eb397214">

### Others
| Splash | Onboarding Screen 1 | Onboarding Screen 2 | Map Action | Safari Action |
|--|--|--|--|--|
|<img width="350" alt="Splash" src="https://github.com/alicolak64/UniTurkey/assets/71923609/4532a08f-f5e5-4ece-8fd2-b2e4d3615f4c">|<img width="350" alt="Onboarding" src="https://github.com/alicolak64/UniTurkey/assets/71923609/dae36c8d-c04b-494c-aac4-f926a82376f1">|<img width="350" alt="Screenshot 2024-04-26 at 14 26 34" src="https://github.com/alicolak64/UniTurkey/assets/71923609/d2e0cd34-b643-40c2-909a-ff5eec014835">|<img width="350" alt="Action2" src="https://github.com/alicolak64/UniTurkey/assets/71923609/b7388927-e5f9-4d8e-a0aa-31bd3f6d1ebe">|<img width="350" alt="Action1" src="https://github.com/alicolak64/UniTurkey/assets/71923609/24298258-c30a-4296-ba54-db6ef1141535">|
