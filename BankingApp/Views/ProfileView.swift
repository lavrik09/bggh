import SwiftUI

struct ProfileView: View {
    @EnvironmentObject private var viewModel: ProfileViewModel

    var body: some View {
        NavigationStack {
            Form {
                Section("Профиль") {
                    HStack {
                        Image(systemName: "person.crop.circle.fill")
                            .font(.largeTitle)
                            .foregroundStyle(.blue)
                        VStack(alignment: .leading) {
                            Text("Иван Кузнецов")
                                .font(.headline)
                            Text("Премиум клиент")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                        Button("Редактировать") {}
                    }
                }

                Section("Безопасность") {
                    Toggle("Face ID", isOn: $viewModel.faceIDEnabled)
                    Picker("Тема", selection: $viewModel.theme) {
                        ForEach(ProfileViewModel.Theme.allCases) { theme in
                            Text(theme.rawValue).tag(theme)
                        }
                    }
                }

                Section("Уведомления") {
                    ForEach(viewModel.notificationToggles.keys.sorted(), id: \.self) { key in
                        Toggle(key, isOn: Binding(
                            get: { viewModel.notificationToggles[key] ?? false },
                            set: { viewModel.updateNotification(for: key, enabled: $0) }
                        ))
                    }
                }

                Section("Поддержка") {
                    Button("Чат с банком") {}
                    Button("Телефон 24/7") {}
                    Button("Документы") {}
                }
            }
            .navigationTitle("Профиль")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Сохранить") { viewModel.sync() }
                }
            }
        }
    }
}

#Preview {
    ProfileView()
        .environmentObject(ProfileViewModel(service: BankingService()))
}
