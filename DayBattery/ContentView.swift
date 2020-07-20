import SwiftUI

struct ContentView: View {
    let dayDatas = [DayData(percent: "low battery", date: Date())]
    var body: some View {
        VStack (spacing: 20) {
            ForEach(dayDatas) {
                dayData in DayDataView(dayData: dayData)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
