## Kirala - Rental Platform

###  Description  
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
