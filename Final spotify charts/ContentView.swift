//
//  ContentView.swift
//  final ranks
//
//  Created by Student on 4/7/22.
//

import SwiftUI

struct ContentView: View {
    @State private var songs = [Song]()
    @State private var showingAlert = false
    var body: some View {
        NavigationView {
            List(songs) { song in
                NavigationLink(
                    destination: Text(song.uri)
                        .padding(),
                    label: {
                        Text(song.uri)
                    })
            }
            .navigationTitle("Search Artists")
        }
        .onAppear(perform: {
            queryAPI()
        })
    }
    
    func queryAPI() {
        let apiKey = "rapidapi-key=8bee3d0e18msh210c3ba33ed813ap1e9ee4jsn67e4d58bb576"
        let query = "https://spotify23.p.rapidapi.com/search/?q=LUCKI&type=Artists&offset=0&limit=10&numberOfTopResults=5?&\(apiKey)"
        if let url = URL(string: query) {
            if let data = try? Data(contentsOf: url) {
                let json = try! JSON(data: data)
                let albums = json["albums"].dictionaryValue
                let items = albums["items"].arrayValue
                let 
                for item in items {
                    let uri: Dictionary<String, JSON> = json["uri"].dictionaryValue
                    let song = Song(uri: uri)
                    songs.append(song)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Song: Identifiable {
    let id = UUID()
    var uri: String
}








