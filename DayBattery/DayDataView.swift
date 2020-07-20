//
//  DayDataView.swift
//  DayBattery
//
//  Created by Andrey Efremov on 20.07.2020.
//

import SwiftUI

struct DayDataView: View {
    let dayData: DayData
    
    @State var numCell: CGFloat = 20
    @State var cellSize: CGFloat = 50
    @State var gridDraggedX: CGFloat = 0
    @State var gridDraggedY: CGFloat = 0
    @State var accumulatedGridDraggedX: CGFloat = 0
    @State var accumulatedGridDraggedY: CGFloat = 0

    var body: some View {
        let drag = DragGesture(minimumDistance: 10.0, coordinateSpace: .global).onChanged({ value in
             self.gridDraggedX = value.translation.width + self.accumulatedGridDraggedX
             self.gridDraggedY = value.translation.height + self.accumulatedGridDraggedY
         }).onEnded({ value in
            withAnimation(.easeIn(duration: 0.33), {
                self.gridDraggedX = 0
                self.gridDraggedY = 0
                self.accumulatedGridDraggedX = 0
                self.accumulatedGridDraggedY = 0
            })
         })

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date = Date()
        let str = formatter.string(from: date)
        
        let hour = Calendar.current.component(.hour, from: date)
        let minute = Calendar.current.component(.minute, from: date)
        let per = (Double(hour) + (Double(minute) / 60)) / 24
        
        let numformatter = NumberFormatter()
        numformatter.numberStyle = NumberFormatter.Style.decimal
        numformatter.maximumFractionDigits = 1
        
        let hourPers = "\( Float((per * 100).rounded(.up) / 100))"
        
        return HStack(content: {
            Text(hourPers).background(Color.red)
.gesture(drag).background(Color.green).offset(x: gridDraggedX, y: gridDraggedY).font(.system(size:20))
        })
    }
}


struct DayDataView_Previews: PreviewProvider {
    static var previews: some View {
        DayDataView(dayData: DayData(percent: "50", date: Date()))
    }
}

