import SwiftUI

struct AddTodoView: View {
    @Binding var isDismiss: Bool
    @State private var title: String = ""
    @State private var descriptions: String = ""
    @EnvironmentObject var realmManager: RealmManager

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("할 일 정보")) {
                    TextField("제목", text: $title)
                    TextField("설명", text: $descriptions)
                }
                Section {
                    Button(action: {
                        if title != "" {
                            realmManager.addTask(taskTitle: title, taskDescription: descriptions)
                        }

                        self.isDismiss = false
                    }) {
                        Text("저장")
                    }
                }
            }
                .navigationTitle("새 할 일 추가")
        }
    }
}
