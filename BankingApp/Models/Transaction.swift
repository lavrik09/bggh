import Foundation

enum TransactionCategory: String, CaseIterable, Codable {
    case food = "Еда"
    case transport = "Транспорт"
    case entertainment = "Развлечения"
    case utilities = "Коммунальные"
    case shopping = "Покупки"
    case transfers = "Переводы"
    case salary = "Зарплата"
}

struct Transaction: Identifiable, Hashable {
    let id: UUID
    let title: String
    let subtitle: String
    let amount: Double
    let currency: String
    let date: Date
    let category: TransactionCategory
    let isDebit: Bool

    static func sampleData() -> [Transaction] {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withFullDate]
        return [
            Transaction(
                id: UUID(),
                title: "Перевод от ACME",
                subtitle: "Зарплата",
                amount: 185_000,
                currency: "RUB",
                date: formatter.date(from: "2024-08-01")!,
                category: .salary,
                isDebit: false
            ),
            Transaction(
                id: UUID(),
                title: "Яндекс Go",
                subtitle: "Поездка",
                amount: 520,
                currency: "RUB",
                date: formatter.date(from: "2024-08-12")!,
                category: .transport,
                isDebit: true
            ),
            Transaction(
                id: UUID(),
                title: "Супермаркет VkusVill",
                subtitle: "Продукты",
                amount: 3_480,
                currency: "RUB",
                date: formatter.date(from: "2024-08-13")!,
                category: .food,
                isDebit: true
            ),
            Transaction(
                id: UUID(),
                title: "Apple Music",
                subtitle: "Подписка",
                amount: 169,
                currency: "RUB",
                date: formatter.date(from: "2024-08-05")!,
                category: .entertainment,
                isDebit: true
            )
        ]
    }
}
