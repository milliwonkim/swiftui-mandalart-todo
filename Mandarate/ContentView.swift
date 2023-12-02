import SwiftUI

struct TodoItem: Identifiable {
    let id = UUID()
    var title: String
    var description: String
    var isChecked: Bool?
}



struct ContentView: View {
    @StateObject var realmManager = RealmManager()
    @State private var selectedTodoItem: Task?
    @State private var showBottomSheet = false
    @State private var openTodoView = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(realmManager.tasks, id: \.id) { task in
                    HStack {
                        HStack {
                            Image(systemName: task.completed ? "checkmark.circle.fill" : "checkmark.circle").onTapGesture {
                                realmManager.updateTask(id: task.id, completed:task.completed ? false : true)
                            }
                            
                            Text(task.title)
                            Text(task.descriptions)
                            Spacer()
                        }
                        .frame(maxWidth: .infinity)
                        .contentShape(Rectangle())
                    }.onTapGesture {
                        self.selectedTodoItem = task
                        self.showBottomSheet = true
                    }
                }
                .onDelete(perform: { indexSet in
                        for index in indexSet {
                            let task = realmManager.tasks[index]
                            realmManager.deleteTask(id: task.id)
                        }
                    })
                
            }
                .navigationTitle(getTodayDateString())
                .navigationBarItems(trailing: Button(action: {
                openTodoView = true
            }) {
                    Text("할 일 추가")
                })
                .sheet(isPresented: $openTodoView) {
                    AddTodoView(isDismiss: $openTodoView).environmentObject(realmManager)
            }
                .sheet(item: $selectedTodoItem) { item in
                BottomSheetView(todoItem: item)
            }

        }

        
    }

}


struct BottomSheetView: View {
    var todoItem: Task
    var body: some View {

        NavigationStack {
            VStack {
                Text(todoItem.descriptions)
            }
            .navigationTitle(todoItem.title)
            .navigationBarTitle(todoItem.descriptions)
        }
        
    }
}


struct ListRowView: View {
    var body: some View {
        HStack {
            Image(systemName: "checkmark.circle")
            Text("This is the first item!")
            Spacer()
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

func getTodayDateString() -> String {
    let currentDate = Date()
    let formatter = DateFormatter()
    formatter.dateFormat = "YYYY-MM-dd"
    return formatter.string(from: currentDate)
}
