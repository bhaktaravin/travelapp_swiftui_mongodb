//
//  ContentView.swift
//  Travel
//
//  Created by Ravin Bhakta on 9/12/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var country = ""
    @State private var dateVisited = Date.now
    @State private var pointOfInterest = ""
    @State private var dateUpdated = Date.now
    @State private var streetName = ""
    @State private var cityName = ""
    @State private var zipCode = 00000
    @State private var whoVisited = ["Mom", "Dad", "Dev","Me"]
    

    var body: some View {
        VStack {
            Text(country)
                .font(.headline)
            Text("\(dateVisited)")
                .font(.subheadline)
                .italic()
            Button(action: addDocument){
                Text("Add Document")
            }
        }
        
    }
    
    func addDocument(){
        let url = URL(string: "http://localhost:3000/addDocument")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let document = [
            "country": "Test",
            "dateVisited": "\(Date.now)",
            "pointOfInterest": "test",
            "dateUpdated": "\(Date.now)",
            "streetName" : "123 elm stree",
            "cityName" : "horror",
            "zipCode": 12345,
            "whoVisited": "Me" ] as [String : Any]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: document)
        
        let place = URLSession.shared.dataTask(with: request) { data, response, error in
            
            DispatchQueue.main.async {
                country = "County: \(country)"
                dateVisited = "Date Visited: \($dateVisited)"
                pointOfInterest = "Point of Interest: \(pointOfInterest)"
                dateUpdated = "Date Updated:\(dateUpdated)"
                streetName = "Street Number and Name: \(streetName)"
                cityName = "City Name: \(cityName)"
                zipCode = "Zip Code: \(zipCode)"
                whoVisited = "Who Visited: \(whoVisited)"
                
                
            }
            
        }
    }
}

#Preview {
    ContentView()
}
