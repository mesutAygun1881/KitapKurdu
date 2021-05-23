//
//  DetailView.swift
//  BookWorm
//
//  Created by Mesut Aygün on 23.05.2021.
//

import SwiftUI
import CoreData

struct DetailView: View {
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.presentationMode) var presentationmode
    @State private var showingDeleteAlert = false
    let book : Book
    var body: some View {
        GeometryReader { geo in
            VStack{
                ZStack(alignment: .bottomTrailing) {
                    Image(self.book.genre ?? "Fantasy")
                        .frame(maxWidth : geo.size.width)
                    
                    Text(self.book.genre?.uppercased() ?? "FANTASY")
                        .font(.caption)
                        .fontWeight(.black)
                        .padding(8)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                        .background(Color.black.opacity(0.75))
                        .offset(x: -5, y: -5)
                }
                Text(self.book.author ?? "")
                    .font(.title)
                    .foregroundColor(.secondary)
                Text(self.book.review ?? "")
                    .padding()
                
                RatingView(rating: .constant(Int(self.book.rating)))
                    .font(.largeTitle)
            }
        }
        .navigationBarTitle(Text(book.title ?? ""), displayMode: .inline)
        .alert(isPresented: $showingDeleteAlert) {
            Alert(title: Text("Delete book"), message: Text("Are you sure"), primaryButton: .destructive(Text("Delete"), action: {
                self.deleteBook()
            }), secondaryButton: .cancel())
        }
        
        .navigationBarItems(trailing: Button(action: {
            self.showingDeleteAlert = true
        }, label: {
            Image(systemName: "thrash")
        }))
    
        .navigationBarItems(trailing: Button(action: {
            self.showingDeleteAlert = true
        }) {
            Image(systemName: "trash")
        })
    }
    
    func deleteBook() {
        viewContext.delete(book)
        
        presentationmode.wrappedValue.dismiss()
    }
}

struct DetailView_Previews: PreviewProvider {
    static let viewContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    static var previews: some View {
        let book = Book(context: viewContext)
        book.title = "Text book"
        book.author = "test authot"
        book.genre = "Fantasy"
        book.rating = 4
        book.review = "awesome book"
        return NavigationView {
        DetailView(book: book)
        }
    }
}
