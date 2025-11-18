import Foundation

struct Account: Identifiable, Hashable {
    enum AccountType: String, CaseIterable, Codable {
        case checking = "Текущий"
        case savings = "Накопительный"
        case investment = "Инвестиции"
        case credit = "Кредитный"
    }

    let id: UUID
    var name: String
    var type: AccountType
    var currency: String
    var balance: Double
    var accountNumber: String
    var interestRate: Double?
    var goalProgress: Double?

    static let sample = Account(
        id: UUID(),
        name: "Основной счёт",
        type: .checking,
        currency: "RUB",
        balance: 254_600,
        accountNumber: "4081 78•• ••45 9900",
        interestRate: nil,
        goalProgress: 0.64
    )
}
