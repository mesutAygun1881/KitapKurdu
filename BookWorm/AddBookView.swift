//
//  AddBookView.swift
//  BookWorm
//
//  Created by Mesut Aygün on 22.05.2021.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var moc
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = ""
    @State private var review = ""
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    var body: some View {
       
        
        NavigationView {
          
               
            Form {
                Section {
                    TextField("Kitap Adı", text: $title)
                    TextField("Yazar Adı", text: $author)

                    Picker("Türü", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }

                Section {
                   RatingView(rating: $rating)

                    TextField("Not Ekle", text: $review)
                }
            
                Section {
                    Button("Save") {
                        // add the book
                        let newBook = Book(context: self.moc)
                        newBook.title = self.title
                        newBook.author = self.author
                        newBook.rating = Int16(self.rating)
                        newBook.genre = self.genre
                        newBook.review = self.review

                        try? self.moc.save()
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            
            }
            .navigationBarTitle("Kitap Ekle").font(.subheadline)
        }
    }
   
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
