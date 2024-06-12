//
//  Strings.swift
//  Kirala
//
//  Created by Ali Çolak on 6.06.2024.
//

import Foundation

enum Strings {
    
    enum Common: String, Localizable {
        case searchBarPlaceholder = "SearchBarPlaceholder"
        case cancel = "Cancel"
        case notifications = "Notifications"
        case newAddeds = "NewAddeds"
        case bestSellers = "BestSellers"
        case mostRated = "MostRated"
        case seeAll = "SeeAll"
        case categories = "Categories"
        case done = "Done"
        case from = "From"
        case to = "To"
        case rent = "Rent"
        case chooseDate = "ChooseDate"
        case chooseRangeRent = "ChooseRangeRent"
        case day = "Day"
        case total = "Total"
        case perDay = "PerDay"
        case product = "Product"
        case all = "All"
        case ok = "Ok"
        case error = "Error"
        case pleaseWait = "PleaseWait"
        case delete = "Delete"
        case tryAgain = "TryAgain"
    }
    
    enum TabBar: String, Localizable {
        case home = "home"
        case myAds = "myAds"
        case myOrders = "myOrders"
        case cart = "cart"
        case profile = "profile"
    }
    
    enum EmptyState: String, Localizable {
        case noDataTitle = "NoDataTitle"
        case noDataDesc = "NoDataDesc"
        case noDataButton = "NoDataButton"
        case noInternetTitle = "NoInternetTitle"
        case noInternetDesc = "NoInternetDesc"
        case noInternetButton = "NoInternetButton"
        case noSearchResultTitle = "NoSearchResultTitle"
        case noSearchResultDesc = "NoSearchResultDesc"
        case noSearchResultButton = "NoSearchResultButton"
        case noFavoriteTitle = "NoFavoriteTitle"
        case noFavoriteDesc = "NoFavoriteDesc"
        case noFavoriteButton = "NoFavoriteButton"
        case noAdsTitle = "NoAdsTitle"
        case noAdsDesc = "NoAdsDesc"
        case noAdsButton = "NoAdsButton"
        case emptyCartTitle = "EmptyCartTitle"
        case emptyCartDesc = "EmptyCartDesc"
        case emptyCartButton = "EmptyCartButton"
        case noNotificationTitle = "NoNotificationTitle"
        case noNotificationDesc = "NoNotificationDesc"
        case noNotificationButton = "NoNotificationButton"
        case noOrderTitle = "NoOrderTitle"
        case noOrderDesc = "NoOrderDesc"
        case noOrderButton = "NoOrderButton"
        case unknownErrorTitle = "UnknownErrorTitle"
        case unknownErrorDesc = "UnknownErrorDesc"
        case unknownErrorButton = "UnknownErrorButton"
        case noLoginFavoriteTitle = "NoLoginFavoriteTitle"
        case noLoginFavoriteDesc = "NoLoginFavoriteDesc"
        case noLoginFavoriteButton = "NoLoginFavoriteButton"
        case noLoginCartTitle = "NoLoginCartTitle"
        case noLoginCartDesc = "NoLoginCartDesc"
        case noLoginCartButton = "NoLoginCartButton"
        case noLoginOrderTitle = "NoLoginOrderTitle"
        case noLoginOrderDesc = "NoLoginOrderDesc"
        case noLoginOrderButton = "NoLoginOrderButton"
        case noLoginNotificationTitle = "NoLoginNotificationTitle"
        case noLoginNotificationDesc = "NoLoginNotificationDesc"
        case noLoginNotificationButton = "NoLoginNotificationButton"
        case noLoginProfileTitle = "NoLoginProfileTitle"
        case noLoginProfileDesc = "NoLoginProfileDesc"
        case noLoginProfileButton = "NoLoginProfileButton"
        case noLoginAdsTitle = "NoLoginAdsTitle"
        case noLoginAdsDesc = "NoLoginAdsDesc"
        case noLoginAdsButton = "NoLoginAdsButton"
        case invalidOrExpireTokenTitle = "InvalidOrExpireTokenTitle"
        case invalidOrExpireTokenDesc = "InvalidOrExpireTokenDesc"
        case invalidOrExpireTokenButton = "InvalidOrExpireTokenButton"
    }
    
    enum Alert: String, Localizable {
        case noLoginTitle = "NoLoginTitle"
        case noLoginAction = "NoLoginAction"
        case cancelAction = "CancelAction"
        case noLoginFavoriteProductMessage = "NoLoginFavoriteProductMessage"
        case forgotPasswordSuccess = "ForgotPasswordSuccess"
        case forgotPasswordSuccessMessage = "ForgotPasswordSuccessMessage"
        case resetPasswordSuccess = "ResetPasswordSuccess"
        case resetPasswordSuccessMessage = "ResetPasswordSuccessMessage"
        case registerSuccess = "RegisterSuccess"
        case registerSuccessMessage = "RegisterSuccessMessage"
        case somethingWentWrong = "SomethingWentWrong"
        case somethingWentWrongMessage = "SomethingWentWrongMessage"
    }
    
    
    enum Auth: String, Localizable {
        case emailPlaceholder = "EmailPlaceholder"
        case passwordPlaceholder = "PasswordPlaceholder"
        case namePlaceholder = "NamePlaceholder"
        case forgotPassword = "ForgotPassword"
        case loginWithApple = "LoginWithApple"
        case loginWithGoogle = "LoginWithGoogle"
        case registerWithApple = "RegisterWithApple"
        case registerWithGoogle = "RegisterWithGoogle"
        case register = "Register"
        case resetPassword = "ResetPassword"
        case forgotPasswordTip = "ForgotPasswordTip"
        case resetPasswordTip = "ResetPasswordTip"
        case noAccount = "NoAccount"
        case alreadyHaveAccount = "AlreadyHaveAccount"
        case login = "Login"
        case otherLoginOptions = "OtherLoginOptions"
        case otherRegisterOptions = "OtherRegisterOptions"
        case passwordTip = "PasswordTip"
        case emailValidation = "EmailValidation"
        case passwordValidation = "PasswordValidation"
        case passwordMatchValidation = "PasswordMatchValidation"
        case nameValidation = "NameValidation"
        case acceptMembershipTerms = "AcceptMembershipTerms"
        case consentForOffers = "ConsentForOffers"
        case agreeToReceiveMessages = "AgreeToReceiveMessages"
        case acknowledgePrivacyPolicy = "AcknowledgePrivacyPolicy"
        case forgotPasswordTipTitle = "ForgotPasswordTipTitle"
        case forgotPasswordTip1 = "ForgotPasswordTip1"
        case forgotPasswordTip2 = "ForgotPasswordTip2"
        case forgotPasswordTip3 = "ForgotPasswordTip3"
        
        case resendVerifyEmailTitle = "ResendVerifyEmailTitle"
        case resendVerifyEmailMessage = "ResendVerifyEmailMessage"
        case resendVerifyEmailAction = "ResendVerifyEmailAction"
        case resendVerifyEmailSuccess = "ResendVerifyEmailSuccess"
        case resendVerifyEmailSuccessMessage = "ResendVerifyEmailSuccessMessage"
    }
    
    enum Filter: String, Localizable {
        case clear = "Clear"
        case sort = "Sort"
        case filter = "Filter"
        case category = "Category"
        case brand = "Brand"
        case price = "Price"
        case rating = "Rating"
        case renter = "Renter"
        case rentalPeriod = "RentalPeriod"
        case city = "City"
        case lowToHigh = "LowToHigh"
        case highToLow = "HighToLow"
        case bestseller = "Bestseller"
        case newest = "Newest"
        case mostRated = "MostRated"
        case selectAll = "SelectAll"
        case search = "Search"
        case apply = "Apply"
        case listProducts = "ListProducts"
        case starAndAbove = "StarAndAbove"
        case min = "Min"
        case max = "Max"
        case minMaxError = "MinMaxError"
    }
    
    enum Ad: String, Localizable {
        
        case other = "Other"
        case all = "All"
        
        case myAds = "MyAds"
        
        case categoryTitle = "CategoryTitle"
        case categoryPlaceholder = "CategoryPlaceholder"
        case categoryTip = "CategoryTip"
        case customCategoryTitle = "CustomCategoryTitle"
        case customCategoryPlaceholder = "CustomCategoryPlaceholder"
        case customCategoryTip = "CustomCategoryTip"
        
        case subCategoryTitle = "SubCategoryTitle"
        case subCategoryPlaceholder = "SubCategoryPlaceholder"
        case subCategoryTip = "SubCategoryTip"
        case customSubCategoryTitle = "CustomSubCategoryTitle"
        case customSubCategoryPlaceholder = "CustomSubCategoryPlaceholder"
        case customSubCategoryTip = "CustomSubCategoryTip"
        
        case brandTitle = "BrandTitle"
        case brandPlaceholder = "BrandPlaceholder"
        case brandTip = "BrandTip"
        case customBrandTitle = "CustomBrandTitle"
        case customBrandPlaceholder = "CustomBrandPlaceholder"
        case customBrandTip = "CustomBrandTip"
        
        case cityTitle = "CityTitle"
        case cityPlaceholder = "CityPlaceholder"
        case cityTip = "CityTip"
        
        case nameTitle = "NameTitle"
        case namePlaceholder = "NamePlaceholder"
        case nameTip = "NameTip"
        
        case priceTitle = "PriceTitle"
        case pricePlaceholder = "PricePlaceholder"
        case priceTip = "PriceTip"
        
        case descriptionTitle = "DescriptionTitle"
        case descriptionPlaceholder = "DescriptionPlaceholder"
        case descriptionTip = "DescriptionTip"
        
        case imagesHeaderTitle = "ImagesHeaderTitle"
        case imagesHeaderButtonTitle = "ImagesHeaderButtonTitle"
        case imagesNoImageDescription = "ImagesNoImageDescription"
        
        case addLeastOneImage = "AddLeastOneImage"
        
        case selectLocation = "SelectLocation"
        case locationTitle = "LocationTitle"
        case locationPlaceholder = "LocationNoLocationDescription"
        
        case rentalPeriodTitle = "RentalPeriodTitle"
        case rentalPeriodTip = "RentalPeriodTip"
        
        case closedRangeTitle = "ClosedRangeTitle"
        case closedRangePlaceholder = "ClosedRangePlaceholder"
        case closedRangeHeaderButtonTitle = "ClosedRangeHeaderButtonTitle"
        
        case addAd = "AddAd"
        case updateAd = "UpdateAd"
        case deleteAd = "DeleteAd"
        
        case categoryErrorTitle = "CategoryErrorTitle"
        case categoryErrorMessage = "CategoryErrorMessage"
        case subcategoryErrorTitle = "SubcategoryErrorTitle"
        case subcategoryErrorMessage = "SubcategoryErrorMessage"
        case brandErrorTitle = "BrandErrorTitle"
        case brandErrorMessage = "BrandErrorMessage"
        case cityErrorTitle = "CityErrorTitle"
        case cityErrorMessage = "CityErrorMessage"
        case nameErrorTitle = "NameErrorTitle"
        case nameErrorMessage = "NameErrorMessage"
        case priceErrorTitle = "PriceErrorTitle"
        case priceErrorMessage = "PriceErrorMessage"
        case descriptionErrorTitle = "DescriptionErrorTitle"
        case descriptionErrorMessage = "DescriptionErrorMessage"
        case minRentPeriodErrorTitle = "MinRentPeriodErrorTitle"
        case minRentPeriodErrorMessage = "MinRentPeriodErrorMessage"
        case maxRentPeriodErrorTitle = "MaxRentPeriodErrorTitle"
        case maxRentPeriodErrorMessage = "MaxRentPeriodErrorMessage"
        case minMaxRentPeriodErrorTitle = "MinMaxRentPeriodErrorTitle"
        case minMaxRentPeriodErrorMessage = "MinMaxRentPeriodErrorMessage"
        case imageErrorTitle = "ImageErrorTitle"
        case imageErrorMessage = "ImageErrorMessage"
        case locationNotFoundErrorTitle = "LocationNotFoundErrorTitle"
        case locationNotFoundErrorMessage = "LocationNotFoundErrorMessage"
        case locationErrorTitle = "LocationErrorTitle"
        case locationErrorMessage = "LocationErrorMessage"
        
        case addSuccessTitle = "AddSuccessTitle"
        case addSuccessMessage = "AddSuccessMessage"
        case addErrorTitle = "AddErrorTitle"
        case addErrorMessage = "AddErrorMessage"
        case addErrorAction = "AddErrorAction"
        
        
        case updateSuccessTitle = "UpdateSuccessTitle"
        case updateSuccessMessage = "UpdateSuccessMessage"
        case updateErrorTitle = "UpdateErrorTitle"
        case updateErrorMessage = "UpdateErrorMessage"
        case updateErrorAction = "UpdateErrorAction"
        
        case deleteSuccessTitle = "DeleteSuccessTitle"
        case deleteSuccessMessage = "DeleteSuccessMessage"
        case deleteErrorTitle = "DeleteErrorTitle"
        case deleteErrorMessage = "DeleteErrorMessage"
        case deleteErrorAction = "DeleteErrorAction"
        
        case deleteConfirmationTitle = "DeleteConfirmationTitle"
        case deleteConfirmationMessage = "DeleteConfirmationMessage"
        case deleteConfirmationAction = "DeleteConfirmationAction"
        case deleteConfirmationCancel = "DeleteConfirmationCancel"
        
        
    }
    
}
