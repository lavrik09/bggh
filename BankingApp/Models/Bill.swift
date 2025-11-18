import Foundation

struct Bill: Identifiable, Hashable {
    enum BillType: String {
        case mobile = "Мобильная связь"
        case utilities = "Коммунальные"
        case internet = "Интернет"
        case insurance = "Страховка"
        case subscription = "Подписки"
    }

    let id: UUID
    var provider: String
    var type: BillType
    var amount: Double
    var currency: String
    var dueDate: Date
    var isAutoPayEnabled: Bool

    static func sampleBills() -> [Bill] {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withFullDate]
        return [
            Bill(
                id: UUID(),
                provider: "Тинькофф Мобайл",
                type: .mobile,
                amount: 650,
                currency: "RUB",
                dueDate: formatter.date(from: "2024-08-20")!,
                isAutoPayEnabled: true
            ),
            Bill(
                id: UUID(),
                provider: "Мосэнергосбыт",
                type: .utilities,
                amount: 2_430,
                currency: "RUB",
                dueDate: formatter.date(from: "2024-08-25")!,
                isAutoPayEnabled: false
            ),
            Bill(
                id: UUID(),
                provider: "Netflix",
                type: .subscription,
                amount: 999,
                currency: "RUB",
                dueDate: formatter.date(from: "2024-08-17")!,
                isAutoPayEnabled: true
            )
        ]
    }
}
