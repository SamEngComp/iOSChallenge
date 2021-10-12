//
//  CoreDataManager.swift
//  iosTest
//
//  Created by Nathalia Cardoso on 11/10/21.
//

import CoreData

class CoreDataManager {
    private let container: NSPersistentContainer
    static var shared = CoreDataManager()
    
    var viewContext: NSManagedObjectContext {
        return self.container.viewContext
    }
    
    init() {
        self.container = NSPersistentContainer(name: "FavoriteMovieModel")
        self.container.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
    
    func createFavoriteMovie(movie: MovieModelParse) {
        let favoriteMovie = FavoriteMovie(context: viewContext)
        favoriteMovie.overview = movie.overview
        favoriteMovie.title = movie.title
        favoriteMovie.id = Int32(movie.id)
        favoriteMovie.poster_img = movie.poster_img
//        if let url = URL(string: "https://image.tmdb.org/t/p/w500\(movie.poster_path)") {
//            if let data = try? Data(contentsOf: url) {
//                favoriteMovie.poster_img = data
//            }
//        }
        self.save()
    }
    
    func save() {
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            print("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func fetchAll() -> [FavoriteMovie] {
        
        let request: NSFetchRequest<FavoriteMovie> = FavoriteMovie.fetchRequest()
        do {
            return try viewContext.fetch(request)
        } catch {
            return []
        }
    }
    
    func remove(id: Int32) {
        if let movie = fetchID(id: id) {
            viewContext.delete(movie)
        }
        self.save()
    }
    
    func removeAll() {
        let favoriteMovies = self.fetchAll()
        favoriteMovies.forEach { movie in
            viewContext.delete(movie)
            
        }
        self.save()
    }
    
    func fetchID(id: Int32) -> FavoriteMovie? {
        let favoriteMovies = self.fetchAll()
        var favMovie: FavoriteMovie?
        favoriteMovies.forEach { movie in
            if movie.id == id {
                favMovie = movie
            }
        }
        return favMovie
    }
    
    func parse(favoriteMovie: FavoriteMovie) -> MovieModelParse {
        return  MovieModelParse(id: Int(favoriteMovie.id),
                                title: favoriteMovie.title ?? "",
                                overview: favoriteMovie.overview ?? "",
                                poster_img: favoriteMovie.poster_img ?? Data())
        
    }
}
