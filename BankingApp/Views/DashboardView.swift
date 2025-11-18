import SwiftUI

struct DashboardView: View {
    @EnvironmentObject private var service: BankingService
    @EnvironmentObject private var viewModel: DashboardViewModel

    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 24) {
                    balanceSection
                    quickActions
                    accountsCarousel
                    analyticsSection
                    transactionsSection
                    billsSection
                }
                .padding()
            }
            .navigationTitle("Добро пожаловать")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        // notifications action
                    } label: {
                        Image(systemName: "bell.badge.fill")
                    }
                }
            }
        }
    }

    private var balanceSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Доступно")
                .font(.callout)
                .foregroundStyle(.secondary)
            Text(service.totalBalance().formatted(.currency(code: "RUB")))
                .font(.largeTitle.bold())
            ProgressView(value: 0.68) {
                Text("План расходов на месяц")
            }
            .progressViewStyle(.linear)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
    }

    private var quickActions: some View {
        HStack(spacing: 16) {
            QuickActionButton(title: "Пополнить", icon: "arrow.down.circle")
            QuickActionButton(title: "Снять", icon: "banknote")
            QuickActionButton(title: "Оплатить", icon: "doc.text")
            QuickActionButton(title: "QR", icon: "qrcode")
        }
    }

    private var accountsCarousel: some View {
        VStack(alignment: .leading, spacing: 8) {
            SectionHeader(title: "Счета", subtitle: "Управляйте всеми продуктами")
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(service.accounts) { account in
                        AccountCardView(account: account)
                    }
                }
                .padding(.horizontal, 4)
            }
        }
    }

    private var analyticsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionHeader(title: "Аналитика", subtitle: "Категории расходов")
            ForEach(TransactionCategory.allCases, id: \.self) { category in
                if let value = viewModel.spendingByCategory[category] {
                    HStack {
                        Text(category.rawValue)
                        Spacer()
                        Text(value.formatted(.currency(code: "RUB")))
                            .bold()
                    }
                    ProgressView(value: min(value / 50_000, 1))
                        .tint(.teal)
                }
            }
        }
        .padding()
        .background(Color(.secondarySystemBackground), in: RoundedRectangle(cornerRadius: 20))
    }

    private var transactionsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionHeader(title: "Последние операции", subtitle: "Обновлено \(Date().formatted(.dateTime.hour().minute()))")
            ForEach(viewModel.highlightedTransactions) { transaction in
                TransactionRow(transaction: transaction)
                Divider()
            }
            NavigationLink("Показать все") {}
                .font(.subheadline.bold())
        }
    }

    private var billsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionHeader(title: "Счета к оплате", subtitle: "Настройте автоплатежи")
            ForEach(service.bills) { bill in
                HStack {
                    VStack(alignment: .leading) {
                        Text(bill.provider)
                            .bold()
                        Text("До \(bill.dueDate.formatted(date: .abbreviated, time: .omitted))")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    Spacer()
                    Text(bill.amount.formatted(.currency(code: bill.currency)))
                        .bold()
                }
                .padding(.vertical, 4)
            }
            NavigationLink("Управлять платежами") {
                PaymentsView()
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(BankingService())
        .environmentObject(DashboardViewModel(service: BankingService()))
}
