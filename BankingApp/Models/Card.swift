import Foundation

struct Card: Identifiable, Hashable {
    enum CardType: String, CaseIterable {
        case debit = "Дебетовая"
        case credit = "Кредитная"
        case virtual = "Виртуальная"
    }

    let id: UUID
    var holder: String
    var number: String
    var type: CardType
    var expiration: String
    var brand: String
    var balance: Double
    var currency: String
    var limit: Double?
    var isLocked: Bool

    static func sampleCards() -> [Card] {
        [
            Card(
                id: UUID(),
                holder: "Ivan Kuznetsov",
                number: "5222 •••• ••22 3010",
                type: .debit,
                expiration: "08/28",
                brand: "Visa",
                balance: 180_540,
                currency: "RUB",
                limit: nil,
                isLocked: false
            ),
            Card(
                id: UUID(),
                holder: "Ivan Kuznetsov",
                number: "5583 •••• ••88 9910",
                type: .credit,
                expiration: "02/27",
                brand: "Mastercard",
                balance: 24_200,
                currency: "RUB",
                limit: 300_000,
                isLocked: false
            ),
            Card(
                id: UUID(),
                holder: "Ivan Kuznetsov",
                number: "4895 •••• ••20 1100",
                type: .virtual,
                expiration: "12/25",
                brand: "Mir",
                balance: 12_480,
                currency: "RUB",
                limit: 50_000,
                isLocked: true
            )
        ]
    }
}
