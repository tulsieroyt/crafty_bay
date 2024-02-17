class Urls {
  static const String _baseUrl = 'http://ecom-api.teamrabbil.com/api';

  static String sentEmailOtp(String email) => '$_baseUrl/UserLogin/$email';

  static String verifyOtp(String email, String otp) =>
      '$_baseUrl/VerifyLogin/$email/$otp';

  static String readProfile = '$_baseUrl/ReadProfile';
  static String createProfile = '$_baseUrl/CreateProfile';
  static String homeBanner = '$_baseUrl/ListProductSlider';
  static String categoryList = '$_baseUrl/CategoryList';
  static String brandList = '$_baseUrl/BrandList';
  static String popularProduct = '$_baseUrl/ListProductByRemark/Popular';
  static String specialProduct = '$_baseUrl/ListProductByRemark/Special';
  static String newProduct = '$_baseUrl/ListProductByRemark/New';

  static String productsByCategory(int categoryId) =>
      '$_baseUrl/ListProductByCategory/$categoryId';

  static String productsByBrand(int brandId) =>
      '$_baseUrl/ListProductByBrand/$brandId';

  static String reviewByProductId(int productId) =>
      '$_baseUrl/ListReviewByProduct/$productId';

  static String addToWishList(int productId) =>
      '$_baseUrl/CreateWishList/$productId';

  static String removeFromWishListById(int productId) =>
      '$_baseUrl/RemoveWishList/$productId';

  static String deleteFromCartList(int productId) =>
      '$_baseUrl/DeleteCartList/$productId';

  static String wishList = '$_baseUrl/ProductWishList';
  static String createReview = '$_baseUrl/CreateProductReview';

  static String productDetails(int productId) =>
      '$_baseUrl/ProductDetailsById/$productId';
  static String addToCart = '$_baseUrl/CreateCartList';
  static String cartList = '$_baseUrl/CartList';
  static String createInvoice = '$_baseUrl/InvoiceCreate';
  static String invoiceList = '$_baseUrl/InvoiceList';

  static String policyByType(String type) => '$_baseUrl/PolicyByType/$type';
}
