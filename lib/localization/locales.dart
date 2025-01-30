import 'package:flutter_localization/flutter_localization.dart';

const List<MapLocale> LOCALES = [
  MapLocale("en", LocaleData.EN),
  MapLocale("ml", LocaleData.ML),
];

mixin LocaleData {
  //*
  static const String cancelButton = "Cancel";
  static const String submitButton = "submit";
  //*introduction
  static const String intro1Title = "title-1";
  static const String intro1SubTitle = "subtitle-1";
  static const String intro2Title = "title-2";
  static const String intro2SubTitle = "subtitle-2";
  static const String intro3Title = "title-3";
  static const String intro3SubTitle = "subtitle-3";
  static const String skipButton = "button-skip";
  static const String continueButton = "button-continue";
  static const String getStarted = "button-get-started";

  //*auth
  static const String authSocialSigninButton = "social-signin-button";
  static const String authSigninWithPasswordButton = "signin-with-password";
  static const String authSignin = "signin";
  static const String authSignup = "signup";
  static const String welcomePageTitle = "welcome-page-title";
  static const String haveAccount = "you-have-account";
  static const String alreadyHaveAccount = "already-have-account";
  static const String signinWelcomeMessage = "signin-welcome-message";
  static const String signinSubtitle = "signin-subtitle";
  static const String signupTitle = "signup-title";
  static const String signupSubtitle = "signup-subtitle";
  static const String profileTitle = "profile-title";
  static const String profileSubtitle = "profile-subtitle";
  static const String profileFinish = "profile-finish";
  static const String forgetPasswordEmailTitle = "email-title";
  static const String forgetPasswordEmailSubTitle = "email-subtitle";
  static const String forgetPasswordOTPTitle = "top-title";
  static const String forgetPasswordOTPSubTitle = "top-subtitle";
  static const String forgetPasswordNewPasswordTitle = "new-pass-title";
  static const String forgetPasswordNewPasswordSubTitle = "new-pass-subtitle";

  //*home
  static const String homeShopListTitle = "Shop Title";
  static const String homeProductListTitle = "Product Title";
  static const String offerPageAppBarTitle = "Offer Title";
  static const String offerClaimButton = "Claim Button";
  static const String notificationTitle = "Notifications";
  //*shops
  static const String yourLocation = "location";
  static const String allShopTitle = "All";
  static const String favoriteShopTitle = "Favorite";
  //*orders
  static const String orderStatusActive = "Active";
  static const String orderStatusCompleted = "Completed";
  static const String orderStatusCanceled = "Canceled";
  static const String orderDetailsTitle = "Order Details";
  static const String trackOrderButton = "Track Order";
  static const String cancelOrderButton = "Cancel Order";
  //*orders -> reward-screen
  static const String orderRewardTitle = "Congratulations!";
  static const String orderRewardSubtitle = "reward-subtitle";
  static const String orderRewardButton = "order-reward-button";
  //*orders -> user-mood
  static const String userMoodTitle = "user-mood-title";
  static const String userMoodSubtitle = "user-mood-subtitle";
  //*orders -> rating-driver
  static const String rateDriverTitle = "rate-driver-title";
  static const String rateDriverSubTitle = "rate-driver-subtitle";
  static const String notReceiveOrder = "not-receive";
  static const String rateDriverButton = "rate-driver-button";
  //*orders -> tip-driver
  static const String tipDriverTitle = "tip-driver-title";
  static const String tipDriverSubTitle = "tip-driver-subtitle";
  //*orders -> rate-shop
  static const String rateShopTitle = "rate-shop-title";
  static const String rateShopSubTitle = "rate-shop-subtitle";
  static const String rateShopReviewTitle = "rate-shop-review";
  //*wallet
  static const String walletBalance = "Your Balance";
  static const String walletAddMoney = "Top Up";
  static const String walletTransactionHistory = "Transaction History";
  //*account
  static const String accountVouchersTitle = "Vouchers & Discount";
  static const String accountPointsTitle = "Caffely Points";
  static const String accountRewardsTitle = "Caffely Rewards";
  static const String accountFavoriteCoffeeTitle = "Favorite Coffee";
  static const String accountAddressTitle = "Saved Address";
  static const String accountPaymentTitle = "Payment Method";
  static const String accountCategoryGeneral = "General";
  static const String accountPersonalInfoTitle = "Personal Info";
  static const String accountNotificationTitle = "account-Notification";
  static const String accountSecurityTitle = "Security";
  static const String accountLanguageTitle = "Language";
  static const String accountDarkModeText = "Dark Mode";
  static const String accountCategoryAbout = "About";
  static const String accountHelpCenterTitle = "Help Center";
  static const String accountAboutCaffelyTitle = "About Caffely";
  static const String accountLogOutText = "logout";
  static const String logoutConfirmationMessage = "Logout-Confirmation";
  static const String logoutConfirmationButton = "Yes";
  //* account -> caffely points
  static const String totalPointText = "Total Caffely Points";
  static const String pointValueText = "Point Value";
  static const String pointHistoryTitle = "point history";
  //* account -> caffely rewards
  static const String caffelyRewardTitle = "reward-title";
  static const String caffelyRewardSubtitle = "Reward-subtitle";
  static const String caffelyShareNote = "Share";
  static const String caffelyButton = "reward-button";

  //*bottom navigation
  static const String viewAll = "view all";
  static const String home = "Home";
  static const String shop = "Shop";
  static const String orders = "Orders";
  static const String wallet = "Wallet";
  static const String account = "Account";

  static const Map<String, dynamic> EN = {
    //*
    cancelButton: "Cancel",
    viewAll: "View All",
    submitButton: "Submit",

    //*introduction
    intro1Title: "Get Your Coffee - Anytime, Anywhere",
    intro1SubTitle:
        "Choose the way you want to enjoy your coffee with Caffely. Just a few taps on the app, and your coffee is ready for you.",
    intro2Title: "Seamless Payments with Our Secure Wallet",
    intro2SubTitle:
        "Say goodbye to hassle and hello to seamless transactions with Caffely's secure wallet. Making payments has never been easier.",
    intro3Title: "Explore the World of Coffee Right Now",
    intro3SubTitle:
        "Dive into the fascinating world of coffee with Caffely. Discover unique and delightful coffee flavors, one sip at a time",
    skipButton: "Skip",
    continueButton: "Continue",
    getStarted: "Get Started",
    //*auth
    authSocialSigninButton: "Continue with %a",
    authSigninWithPasswordButton: "Sign in with password",
    authSignin: "Sign in",
    authSignup: "Sign up",
    welcomePageTitle: "let's dive in into your account",
    haveAccount: "Don't have account?",
    alreadyHaveAccount: "Already have account?",
    signinWelcomeMessage: "Welcome back 👋",
    signinSubtitle: "Please enter your email & password to sign in",
    signupTitle: "Create Account 👩‍💻",
    signupSubtitle: "Sign up to unlock the world of coffee",
    profileTitle: "Complete Your Profile 👤",
    profileSubtitle:
        "Add the finishing touches to your profile. Lets make your coffee experience more social!",
    profileFinish: "Finish",
    forgetPasswordEmailTitle: "Reset your Password🔑",
    forgetPasswordEmailSubTitle:
        "Please enter your email and we will send an OTP code in the next step to reset your password",
    forgetPasswordOTPTitle: "OTP code verification 🔐",
    forgetPasswordOTPSubTitle:
        "We have send an otp code to your email and%a. Enter the OTP code below to verify",
    forgetPasswordNewPasswordTitle: "Create new password 🔒",
    forgetPasswordNewPasswordSubTitle:
        "Create your new password if you forgot it. then you have to do forgot password.",
    //*home
    homeProductListTitle: "Popular Menu",
    homeShopListTitle: "Nearby Shop",
    offerPageAppBarTitle: "Special Offer",
    offerClaimButton: "Claim Discount",
    notificationTitle: "Notifications",
    //*Shops
    yourLocation: "Your Location",
    favoriteShopTitle: "Favorite",
    allShopTitle: "All",

    //*wallet
    walletBalance: "Your Balance",
    walletAddMoney: "Top Up",
    walletTransactionHistory: "Transaction History",

    //*orders
    orderStatusActive: "Active",
    orderStatusCompleted: "Completed",
    orderStatusCanceled: "Canceled",
    orderDetailsTitle: "Order Details",
    trackOrderButton: "Track Order",
    cancelOrderButton: "Cancel Order",
    //*orders -> reward-screen
    orderRewardButton: "OK",
    orderRewardTitle: "Congratulations!",
    orderRewardSubtitle: "You have earned a free coffee voucher!",
    //*orders -> user-mood
    userMoodTitle: "What's Your Mood!",
    userMoodSubtitle: "about this order?",
    //*orders -> rating-driver
    notReceiveOrder: "Haven't received your order?",
    rateDriverTitle: "Let's rate your driver's delivery service",
    rateDriverSubTitle:
        "How was the delivery of your order from Caffely Astoria Aromas?",
    //*order -> tip-driver
    tipDriverTitle: "Wow 5 Star!🤩",
    tipDriverSubTitle:
        "Do you want to add additional tip to make your driver's day?",
    //*order -> rate-shop
    rateShopTitle: "Enjoyed your coffee?",
    rateShopSubTitle: "Rate the shop. your feedback is matters.",
    rateShopReviewTitle: "Leave your review",

    //*account
    accountVouchersTitle: "Vouchers & Discount",
    accountPointsTitle: "Caffely Points",
    accountRewardsTitle: "Caffely Rewards",
    accountFavoriteCoffeeTitle: "Favorite Coffee",
    accountAddressTitle: "Saved Address",
    accountPaymentTitle: "Payment Method",
    accountCategoryGeneral: "General",
    accountPersonalInfoTitle: "Personal Info",
    accountNotificationTitle: "Notifications",
    accountSecurityTitle: "Security",
    accountLanguageTitle: "Language",
    accountDarkModeText: "Dark Mode",
    accountCategoryAbout: "About",
    accountHelpCenterTitle: "Help Center",
    accountAboutCaffelyTitle: "About Caffely",
    accountLogOutText: "Logout",
    logoutConfirmationMessage: "Are you sure you want to log out?",
    logoutConfirmationButton: "Yes, logout",
    //*account -> caffely point
    totalPointText: "Total Caffely Points",
    pointHistoryTitle: "Point History",
    pointValueText: "100 points = \$1.00. You can use these points as payment.",
    //*account -> caffely reward
    caffelyRewardTitle: "Get Free Coffee!",
    caffelyRewardSubtitle:
        "Get a free coffee discount voucher every time your friend joins via your referral code.",
    caffelyShareNote: "Copy or share the referral code below",
    caffelyButton: "Share Referral Code",

    //*bottom navigation
    home: "Home",
    shop: "Shops",
    orders: "Orders",
    wallet: "Wallet",
    account: "Account",
  };

  static const Map<String, dynamic> ML = {
    cancelButton: "റദ്ദാക്കുക",
    viewAll: "എല്ലാം കാണുക",
    submitButton: "സമർപ്പിക്കുക",

    //*introduction
    intro1Title: "നിങ്ങളുടെ കോഫി - എപ്പോൾ വേണമെങ്കിലും, എവിടെ വേണമെങ്കിലും",
    intro1SubTitle:
        "Caffely ഉപയോഗിച്ച് നിങ്ങളുടെ കോഫി എങ്ങനെ ആസ്വദിക്കണമെന്നത് തിരഞ്ഞെടുക്കുക. ആപ്പ് ഉപയോഗിച്ച് കുറച്ച് ടാപ്പുകൾ മാത്രം, കോഫി നിങ്ങളെ കാത്തിരിക്കുന്നു.",
    intro2Title: "നിങ്ങളുടെ സുരക്ഷിത വാലറ്റിലൂടെ സുഗമമായ പേയ്മെന്റുകൾ",
    intro2SubTitle:
        "പ്രയാസങ്ങളെ വിടു, Caffely-യുടെ സുരക്ഷിത വാലറ്റിലൂടെ അതിവേഗ ഇടപാടുകൾ ആസ്വദിക്കൂ.",
    intro3Title: "കോഫിയുടെ ലോകം അന്വേഷിക്കൂ",
    intro3SubTitle:
        "Caffely ഉപയോഗിച്ച് കോഫിയുടെ മനോഹരമായ രുചികൾ കണ്ടെത്തുക, ഓരോ ഇലുപ്പിനും പുതിയൊരു അനുഭവം.",
    skipButton: "ഒഴിവാക്കുക",
    continueButton: "തുടരുക",
    getStarted: "ആരംഭിക്കൂ",

    //*auth
    authSocialSigninButton: "%a ഉപയോഗിച്ച് തുടരുക",
    authSigninWithPasswordButton: "പാസ്‌വേഡോടെ പ്രവേശിക്കുക",
    authSignin: "ലോഗിൻ ചെയ്യുക",
    authSignup: "രജിസ്റ്റർ ചെയ്യുക",
    welcomePageTitle: "നിങ്ങളുടെ അക്കൗണ്ടിലേക്ക് പ്രവേശിക്കൂ",
    haveAccount: "അക്കൗണ്ട് ഇല്ലേ?",
    alreadyHaveAccount: "അക്കൗണ്ട് ഉണ്ടോ?",
    signinWelcomeMessage: "തിരികെ സ്വാഗതം 👋",
    signinSubtitle: "ലോഗിൻ ചെയ്യാൻ ദയവായി നിങ്ങളുടെ ഇമെയിൽ & പാസ്‌വേഡ് നൽകുക",
    signupTitle: "അക്കൗണ്ട് സൃഷ്ടിക്കുക 👩‍💻",
    signupSubtitle: "കോഫിയുടെ ലോകം അനായാസമായി ആസ്വദിക്കാൻ സൈൻ അപ്പ് ചെയ്യുക",
    profileTitle: "നിങ്ങളുടെ പ്രൊഫൈൽ പൂരിപ്പിക്കുക 👤",
    profileSubtitle:
        "നിങ്ങളുടെ പ്രൊഫൈൽ പൂർണ്ണമാക്കൂ. കോഫി അനുഭവം കൂടുതൽ സാമൂഹികമാക്കാം!",
    profileFinish: "പൂർത്തിയാക്കുക",

    //*home
    homeProductListTitle: "ജനപ്രിയ മെനു",
    homeShopListTitle: "അടുത്തുള്ള ഷോപ്പുകൾ",
    offerPageAppBarTitle: "പ്രത്യേക ഓഫർ",
    offerClaimButton: "ഡിസ്കൗണ്ട് ക്ലെയിം ചെയ്യുക",
    notificationTitle: "അറിയിപ്പുകൾ",

    //*shops
    yourLocation: "നിങ്ങളുടെ സ്ഥലം",
    allShopTitle: "എല്ലാം",
    favoriteShopTitle: "പ്രിയപ്പെട്ടത്",

    //*orders
    orderStatusActive: "സജീവം",
    orderStatusCompleted: "പൂർത്തിയായി",
    orderStatusCanceled: "റദ്ദാക്കി",
    orderDetailsTitle: "ഓർഡർ വിശദാംശങ്ങൾ",
    trackOrderButton: "ഓർഡർ പിന്തുടരുക",
    cancelOrderButton: "ഓർഡർ റദ്ദാക്കുക",

    //*wallet
    walletBalance: "നിങ്ങളുടെ ബാലൻസ്",
    walletAddMoney: "പണം ചേർക്കുക",
    walletTransactionHistory: "ഇടപാട് ചരിത്രം",

    //*account
    accountVouchersTitle: "വൗച്ചറുകളും ഡിസ്‌കൗണ്ടുകളും",
    accountPointsTitle: "Caffely പോയിന്റുകൾ",
    accountRewardsTitle: "Caffely ബഹുമതികൾ",
    accountFavoriteCoffeeTitle: "പ്രിയപ്പെട്ട കോഫി",
    accountAddressTitle: "സംരക്ഷിച്ച വിലാസങ്ങൾ",
    accountPaymentTitle: "പേയ്മെന്റ് മാർഗം",
    accountCategoryGeneral: "പൊതുവായി",
    accountPersonalInfoTitle: "വ്യക്തിഗത വിവരങ്ങൾ",
    accountNotificationTitle: "അറിയിപ്പുകൾ",
    accountSecurityTitle: "സുരക്ഷ",
    accountLanguageTitle: "ഭാഷ",
    accountDarkModeText: "ഡാർക്ക് മോഡ്",
    accountCategoryAbout: "കൂടുതൽ അറിയുക",
    accountHelpCenterTitle: "സഹായ കേന്ദ്രം",
    accountAboutCaffelyTitle: "Caffely-നെ കുറിച്ച്",
    accountLogOutText: "ലോഗൗട്ട്",
    logoutConfirmationMessage: "നിങ്ങൾക്ക് ലോഗൗട്ട് ചെയ്യണോ?",
    logoutConfirmationButton: "അതെ, ലോഗൗട്ട്",

    //*bottom navigation
    home: "ഹോം",
    shop: "ഷോപ്പ്",
    orders: "ഓർഡറുകൾ",
    wallet: "വാലറ്റ്",
    account: "അക്കൗണ്ട്",
  };
}
