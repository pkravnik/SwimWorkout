//
// Created for Custom Calendar
// by  Stewart Lynch on 2024-01-22
//
// Follow me on Mastodon: @StewartLynch@iosdev.space
// Follow me on Threads: @StewartLynch (https://www.threads.net)
// Follow me on X: https://x.com/StewartLynch
// Follow me on LinkedIn: https://linkedin.com/in/StewartLynch
// Subscribe on YouTube: https://youTube.com/@StewartLynch
// Buy me a ko-fi:  https://ko-fi.com/StewartLynch


import SwiftUI
import SwiftData

struct CalendarView: View {
    let date: Date
    let daysOfWeek = Date.capitalizedFirstLettersOfWeekdays
    let columns = Array(repeating: GridItem(.flexible()), count: 7)
    let color: Color = .blue
    @State private var days: [Date] = []
    let workouts: [Workout]
    @State private var counts = [Int : Int]()
    let tapAction: (Date) -> Void
    
    var body: some View {
        VStack {
            HStack {
                ForEach(daysOfWeek.indices, id: \.self) { index in
                Text(daysOfWeek[index])
                        .fontWeight(.black)
                        .foregroundStyle(color)
                        .frame(maxWidth: .infinity)
                }
            }
            LazyVGrid(columns: columns) {
                ForEach(days, id: \.self) { day in
                    if day.monthInt != date.monthInt {
                        Text("")
                    } else {
                        Text(day.formatted(.dateTime.day()))
                            .fontWeight(.bold)
                            .foregroundStyle(.secondary)
                            .frame(maxWidth: .infinity, minHeight: 40)
                            .background(
                                Circle()
                                    .foregroundStyle(
                                        Date.now.startOfDay == day.startOfDay
                                        ? .red.opacity(counts[day.dayInt] != nil ? 0.8 : 0.3)
                                        :  color.opacity(counts[day.dayInt] != nil ? 0.8 : 0.3)
                                    )
                            )
                            .onTapGesture {
                                tapAction(day)
                            }
                            .overlay(alignment: .bottomTrailing) {
                                if let count = counts[day.dayInt] {
                                    Image(systemName: count <= 50 ? "\(count).circle.fill" : "plus.circle.fill")
                                        .foregroundColor(.secondary)
                                        .imageScale(.medium)
                                        .background (
                                            Color(.systemBackground)
                                                .clipShape(.circle)
                                        )
                                        .offset(x: 5, y: 5)
                                }
                            }
                    }
                }
            }
            Spacer()
        }
        .padding()
        .onAppear {
            days = date.calendarDisplayDays
            setupCounts()
        }
        .onChange(of: date) {
            days = date.calendarDisplayDays
//            setupCounts()
        }
    }
    
    func setupCounts() {
        let endOfMonthAdjustment = Calendar.current.date(byAdding: .day, value: 1, to: date.endOfMonth)!
        let filteredWorkouts = workouts.filter { $0.startDate >= date.startOfMonth.startOfDay && $0.startDate <= endOfMonthAdjustment }
        let mappedItems = filteredWorkouts.map{($0.startDate.dayInt, 1)}
        counts = Dictionary(mappedItems, uniquingKeysWith: +)
    }
}

//#Preview {
//    CalendarView(date: .now)
//        .environment(WorkoutStore(dataProvider: .testSuccess, loadingState: .loading))
//}
