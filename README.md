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
   - [Auth](#auth)
   - [Home](#home)
   - [Product](#product)
   - [Search And Filter](#search-and-filter)
   - [Others](#others)
   - [Email](#email)



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

Overall, the Kirala project aims to create a dynamic and efficient rental platform that connects users looking to rent out their unused items with those in need of short-term rentals. By providing a secure, user-friendly, and well-designed application, Kirala strives to enhance the rental experience for all users, fostering a community of shared resources and sustainable consumption.

## Screenshots

### Auth

| Login Screen | Reset Password Screen | Register Screen  |
|--|--|--|
|<img width="350" alt="Login Screen" src="https://github.com/user-attachments/assets/5cd6fcd4-3160-48ed-92db-b5e55ed9fd9f"> |<img width="350" alt="Register Screen" src="https://github.com/user-attachments/assets/ad5153e0-c7ff-4039-a3f7-69098dd6487c"> |<img width="350" alt="Reset Password Screen" src="https://github.com/user-attachments/assets/81a5e0a1-f080-4089-b992-7f506755ef73">

### Home
| Home Screen 1 | Home Screen 2 | Home Screen 3 |
|--|--|--|
|<img width="350" alt="Home Screen 1 " src="https://github.com/user-attachments/assets/5b110df8-c8f0-4114-afa1-adcbf608d2fc">|<img width="350" alt="Home Screen 2" src="https://github.com/user-attachments/assets/4be68ad3-715c-449f-8b5a-67e07ee4807b">|<img width="350" alt="Home Screen 3" src="https://github.com/user-attachments/assets/82e79304-e50b-4239-9db6-2ceda0198dfe">

| Home Screen With Category Filter | Add Favorite Product When No Login  | Category Screen |
|--|--|--|
|<img width="350" alt="Home Screen 4 " src="https://github.com/user-attachments/assets/64b91923-5479-4615-b5fe-387f4cd8f9eb">|<img width="350" alt="Home Screen 5" src="https://github.com/user-attachments/assets/a673d644-d7e6-4c25-a151-901d4d065db8">|<img width="350" alt="Home Screen 3" src="https://github.com/user-attachments/assets/2b702224-765b-46e2-aaee-5e3db91162cc">

### Product
| Create Product Screen | Update Product Screen 1  | Update Product Screen 2 |
|--|--|--|
|<img width="350" alt="Create Product Screen" src="https://github.com/user-attachments/assets/3448e3a4-d7a9-4158-a10e-707325fb6b10">|<img width="350" alt="Update Product Screen 1" src="https://github.com/user-attachments/assets/cb1f2381-3e78-4bd4-83f6-6ffe55fbe280">|<img width="350" alt="Update Product Screen 2" src="https://github.com/user-attachments/assets/def64eea-5007-49ee-b638-ebf17259c6d5">

| Update Product Calendar | Update Product Photos  | Update Product Location |
|--|--|--|
|<img width="350" alt="Update Product Calendar" src="https://github.com/user-attachments/assets/c8dc8ccc-9b60-4e78-9a56-21aaaa4dd1a2">|<img width="350" alt="Update Product Photos" src="https://github.com/user-attachments/assets/e6407ea0-70e3-4768-a576-840e751613df">|<img width="350" alt="Update Product Location" src="https://github.com/user-attachments/assets/9359bf58-6c98-489b-bfee-b3d840e71d16">

| My Products | My Favorite Products|
|--|--|
|<img width="350" alt="My Products" src="https://github.com/user-attachments/assets/1a3da8bb-529f-4ff7-90c2-4cb41f6e3b08">|<img width="350" alt="My Favorite Products" src="https://github.com/user-attachments/assets/fda3c686-0493-4332-9a47-5f06d13ff5d6">

| Product Detail 1 | Product Detail 2 | Product Detail Map And Desc |
|--|--|--|
|<img width="350" alt="Product Detail 1" src="https://github.com/user-attachments/assets/4784b427-59c1-41d3-8cbc-5c4e8893c591">|<img width="350" alt="Product Detail Loading Hud" src="https://github.com/user-attachments/assets/946c0b13-2a3f-42c2-a9c5-1a74758d6e67">|<img width="350" alt="Product Detail Success Alert" src="https://github.com/user-attachments/assets/9e1cd789-09db-4fcd-bb5f-39c6d5a10df9">

| Product Detail Price | Product Detail Loading Hud | Product Detail Success Alert |
|--|--|--|
|<img width="350" alt="Product Detail Price" src="https://github.com/user-attachments/assets/8a97a3bd-968c-4c53-b208-dfc7edfe5f4b">|<img width="350" alt="Product Detail 2" src="https://github.com/user-attachments/assets/4aff3878-c56e-4aa7-a29b-1ce454b5e56b">|<img width="350" alt="Product Detail Map And Desc " src="https://github.com/user-attachments/assets/10d0f88f-d6ab-4c5a-8e72-2cbbbac88e40">

### Search And Filter
| Search Product With Category Screen | Product Sort Modal | Product Filter Modal |
|--|--|--|
|<img width="350" alt="Search Product With Category Screen" src="https://github.com/user-attachments/assets/7bd7e73e-e6a5-4378-bada-5b3545071beb">|<img width="350" alt="Product Sort Modal" src="https://github.com/user-attachments/assets/e505e7a5-f78a-4c72-8e0f-a4d45236201f">|<img width="350" alt="Product Filter Modal" src="https://github.com/user-attachments/assets/8a35cca3-edae-437d-acc5-d2d04cdac399">

| Product Brand Filter Modal  | Product Category Filter Modal  | Product Rating Filter Modal  |
|--|--|--|
|<img width="350" alt="Product Brand Filter Modal" src="https://github.com/user-attachments/assets/5d01d1b1-cd26-4c07-833a-57644f35a9f9">|<img width="350" alt="Product Category Filter Modal" src="https://github.com/user-attachments/assets/9d0a979c-71d3-4e6e-afd0-c108149e035a">|<img width="350" alt="Product Rating Filter Modal" src="https://github.com/user-attachments/assets/e3ee29d4-b945-48c8-8d10-11cfb39be17b">

| Product City Filter Modal  | Product Price Filter Modal  | Product Renter Filter Modal | Product Rental Period Filter Modal |
|--|--|--|--|
|<img width="350" alt="Product City Filter Modal" src="https://github.com/user-attachments/assets/f8f7c09e-6577-4884-ba81-a28e91cbe381">|<img width="350" alt="Product Price Filter Modal" src="https://github.com/user-attachments/assets/a3b53852-26a1-491b-9820-c1eff95a89c9">|<img width="350" alt="Product Renter Filter Modal" src="https://github.com/user-attachments/assets/02d0c4d3-7fa8-4d72-9df4-5acf1fd0af50">|<img width="350" alt="Product Rental Period Filter Modal" src="https://github.com/user-attachments/assets/9023eb22-f592-422d-a07a-378f90c60f9d">

### Others
| Splash Screen | Lottie Animation Screen| Empty State Screen |
|--|--|--|
|<img width="350" alt="Splash Screen" src="https://github.com/user-attachments/assets/eaa4b958-e30a-4e09-a757-77ff34ee5131">|<img width="350" alt="Lottie Animation Screen" src="https://github.com/user-attachments/assets/a703e2c5-06f2-4200-b8bd-d6bc836d8cee">|<img width="350" alt="Empty State Screen" src="https://github.com/user-attachments/assets/864bec4c-26f3-45d7-a602-7de60036c45a">

### Email
| Verify Email Mail | Reset Password Mail | Product Rent Request Mail |
|--|--|--|
|<img width="350" alt="Verify Email Mail" src="https://github.com/user-attachments/assets/036a6e3e-45b4-410b-a16b-037f58469d6f">|<img width="350" alt="Reset Password Mail" src="https://github.com/user-attachments/assets/0dea5d42-3d37-4292-97d9-4949e0955cb6">|<img width="350" alt="Product Rent Request Mail" src="https://github.com/user-attachments/assets/2fe44414-fecf-4fee-9009-3e6af0bfc370">

