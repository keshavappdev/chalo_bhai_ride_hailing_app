import 'package:ride_hailing_app/data/models/user_model.dart';
import 'package:ride_hailing_app/data/datasources/local/mock_data.dart';

class UserRepository {
  Future<User> getUser(String userId) async {
    await Future.delayed(const Duration(seconds: 1));
    final user = MockData.getUserById(userId);
    if (user == null) {
      throw Exception('User not found');
    }
    return user;
  }

  Future<User> updateUser(User user) async {
    await Future.delayed(const Duration(seconds: 1));
    // In real app, this would update the user in the database
    return user;
  }

  Future<List<PaymentMethod>> getPaymentMethods(String userId) async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      PaymentMethod(
        id: 'pm1',
        type: 'Visa',
        lastFourDigits: '4242',
        cardHolderName: 'John Doe',
        expiryDate: '12/25',
        isDefault: true,
      ),
      PaymentMethod(
        id: 'pm2',
        type: 'Mastercard',
        lastFourDigits: '8888',
        cardHolderName: 'John Doe',
        expiryDate: '08/24',
        isDefault: false,
      ),
    ];
  }

  Future<void> addPaymentMethod(String userId, PaymentMethod method) async {
    await Future.delayed(const Duration(seconds: 1));
    // In real app, this would add the payment method
  }

  Future<void> removePaymentMethod(String userId, String methodId) async {
    await Future.delayed(const Duration(seconds: 1));
    // In real app, this would remove the payment method
  }

  Future<void> setDefaultPaymentMethod(String userId, String methodId) async {
    await Future.delayed(const Duration(seconds: 1));
    // In real app, this would set the default payment method
  }
}