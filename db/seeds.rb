# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require "open-uri"

puts "Destryoing horses"
Horse.destroy_all
puts "Destroyed Horses"
puts "Destryoing users"
User.destroy_all
puts "Destroyed Users"

puts "Creatting Users"
user1 = User.new(email: "clari@gmail.com", password: "123456", nombre: "Clari", apellido: "Ursini", age: 34, pais: "Argentina", provincia: "Capital Federal", ciudad: "Capital Federal", direccion: "Viamonte 2040", phone: "+5491149608212", description: "I love horses", establishment: "Haras La Clari")
file = URI.open("https://ca.slack-edge.com/T02NE0241-U03PQPPGXUG-abbe6fa51dcc-512")
user1.photo.attach(io: file, filename: "clari.png", content_type: "image/png")
user1.save!

user2 = User.new(email: "nacho@gmail.com", password: "123456", nombre: "Nacho", apellido: "Zanotto", age: 27, pais: "Argentina", provincia: "Buenos Aires", ciudad: "Moreno", direccion: "La Rioja 2020", phone: "+5491159614875", description: "I love horses", establishment: "Haras El Nacho")
file = URI.open("https://ca.slack-edge.com/T02NE0241-U03NVDNP02Z-8e39c56cb377-512",)
user2.photo.attach(io: file, filename: "nacho.png", content_type: "image/png")
user2.save!

user3 = User.new(email: "sofi@gmail.com", password: "123456", nombre: "Sofi", apellido: "Larrea", age: 33, pais: "Argentina", provincia: "Mendoza", ciudad: "Mendoza", direccion: "Av. Lastarria 2045", phone: "+54926456148954", description: "I love horses", establishment: "Haras La Sofi")
file = URI.open("https://ca.slack-edge.com/T02NE0241-U03NNS0RVHV-360467752b45-512")
user3.photo.attach(io: file, filename: "sofi.png", content_type: "image/png")
user3.save

user4 = User.new(email: "beni@gmail.com", password: "123456", nombre: "Beni", apellido: "Yuchi Hsueh", age: 27, pais: "Argentina", provincia: "Capital Federal", ciudad: "Capital Federal", direccion: "Av. Santa Fe 3894", phone: "+54911515611234", description: "I love horses", establishment: "Haras El Beni")
file = URI.open("https://ca.slack-edge.com/T02NE0241-U03NY6P9V52-c21424e32e07-512")
user4.photo.attach(io: file, filename: "beni.png", content_type: "image/png")
user4.save!

user5 = User.new(email: "maki@gmail.com", password: "123456", nombre: "Ryusei", apellido: "Makiguchi", age: 30, pais: "Argentina", provincia: "Capital Federal", ciudad: "Capital Federal", direccion: "Av. Montes de Oca 2945", phone: "+5491149851247", description: "I love horses", establishment: "Haras El Maki")
file = URI.open("https://ca.slack-edge.com/T02NE0241-U03PTAN9ARE-e0ff21331654-512")
user5.photo.attach(io: file, filename: "maki.png", content_type: "image/png")
user5.save!

user6 = User.new(email: "admin@gmail.com", password: "123456", nombre: "Admin", apellido: "1", age: 30, pais: "Argentina", provincia: "Capital Federal", ciudad: "Capital Federal", direccion: "Av. Montes de Oca 2945", phone: "+5491149851247", description: "I love horses", establishment: "Haras El Maki", admin: true)
file = URI.open("https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png")
user6.photo.attach(io: file, filename: "foto.png", content_type: "image/png")
user6.save!

puts "Created users"

puts "Creating horses"

horse1 = Horse.new(name: "Luqui", rider: "Beni", alzada: "21", height: "100", birthday: "22/10/2022", video: "https://www.youtube.com/watch?v=Socb6o6VKGE", gender: "M", user_id: user1.id, description: "Descripión caballo texto con info. descripión caballo. Texto con info. Descripión caballo texto con info. Descripión caballo, texto con info.", age: 20)
file = URI.open("https://www.robertogarrudo.com/blog/wp-content/uploads/2014/10/412_79231_6753136_997956.jpg")
horse1.photos.attach(io: file, filename: "horse.png", content_type: "image/png")
horse1.save!

horse2 = Horse.new(name: "Valentina", rider: "Maki", alzada: "21", height: "100", birthday: "22/10/2019", video: "https://www.youtube.com/watch?v=Socb6o6VKGE", gender: "F", user_id: user1.id, description: "Descripión caballo texto con info. descripión caballo. Texto con info. Descripión caballo texto con info. Descripión caballo, texto con info.", age: 20)
file = URI.open("https://conceptodefinicion.de/wp-content/uploads/2019/05/Caballo-.jpg")
horse2.photos.attach(io: file, filename: "horse.png", content_type: "image/png")
horse2.save!

horse3 = Horse.new(name: "Pedro", rider: "Juan Carlos", alzada: "22", height: "200", birthday: "22/10/2018", video: "https://www.youtube.com/watch?v=Socb6o6VKGE", gender: "M", user_id: user5.id, description: "Descripión caballo texto con info. descripión caballo. Texto con info. Descripión caballo texto con info. Descripión caballo, texto con info.", age: 20)
file = URI.open("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR-TP7Id5jPDWEny_-x1R6AgpbIfuVyy0v8HwQ-XiWrC63-q87_VBucXNICkNagn2ywX8M&usqp=CAU")
horse3.photos.attach(io: file, filename: "horse.png", content_type: "image/png")
horse3.save!

horse4 = Horse.new(name: "Juana", rider: "Nestor", alzada: "23", height: "150", birthday: "22/10/2021", video: "https://www.youtube.com/watch?v=Socb6o6VKGE", gender: "F", user_id: user5.id, description: "Descripión caballo texto con info. descripión caballo. Texto con info. Descripión caballo texto con info. Descripión caballo, texto con info.", age: 20)
file = URI.open("https://madridhipica.com/wp-content/uploads/2022/06/Caballos-de-sangre-caliente-y-de-sangre-fria.jpg")
horse4.photos.attach(io: file, filename: "horse.png", content_type: "image/png")
horse4.save!

puts "Creating auctions"

auction1 = Auction.new(
  name: "Remate Haras Victoria",
  location: "Buenos Aires",
  date: Date.new(2023, 05, 27),
  user_id: user1.id, start: DateTime.new(2023, 5, 27, 4, 0, 0),
  finish: DateTime.new(2023, 5, 27, 5, 0, 0),
  condiciones: "https://www.caccm.com.ar/remates/prod.php?col=93&sec=23",
  link_auction: "https://www.caccm.com.ar/remates/prod.php?col=93&sec=23"
)
file = URI.open("https://mir-s3-cdn-cf.behance.net/projects/404/e4104d112052313.Y3JvcCwxNjYzLDEzMDAsMCwxMjM.png")
auction1.photo.attach(io: file, filename: "auction.png", content_type: "image/png")
auction1.save!

auction2 = Auction.new(
  name: "Haras Remate AlBar",
  location: "Capitan Sarmiento",
  date: Date.new(2023, 04, 27),
  user_id: user1.id, start: DateTime.new(2023, 4, 27, 4, 0, 0),
  finish: DateTime.new(2023, 4, 27, 5, 0, 0),
  condiciones: "https://www.caccm.com.ar/remates/prod.php?col=93&sec=23",
  link_auction: "https://www.caccm.com.ar/remates/prod.php?col=93&sec=23"
)
file = URI.open("https://www.guerra-creativa.com/img/uploads/designs/850x566/bimzp3p0.jpg")
auction2.photo.attach(io: file, filename: "auction.png", content_type: "image/png")
auction2.save!

auction3 = Auction.new(
  name: "Haras Selva de Pedra",
  location: "Rio Cuarto",
  date: Date.new(2023, 03, 27),
  user_id: user5.id, start: DateTime.new(2023, 3, 27, 4, 0, 0),
  finish: DateTime.new(2023, 3, 27, 5, 0, 0),
  condiciones: "https://www.caccm.com.ar/remates/prod.php?col=93&sec=23",
  link_auction: "https://www.caccm.com.ar/remates/prod.php?col=93&sec=23"
)
file = URI.open("https://s3-sa-east-1.amazonaws.com/projetos-artes/fullsize%2F2018%2F03%2F07%2F20%2FLogo-234918_70207_204757969_278263886.jpg")
auction3.photo.attach(io: file, filename: "auction.png", content_type: "image/png")
auction3.save!

auction4 = Auction.new(
  name: "Haras San Pablo",
  location: "Pergamino",
  date: Date.new(2023, 06, 27),
  user_id: user5.id, start: DateTime.new(2023, 6, 27, 4, 0, 0),
  finish: DateTime.new(2023, 6, 27, 5, 0, 0),
  condiciones: "https://www.caccm.com.ar/remates/prod.php?col=93&sec=23",
  link_auction: "https://www.caccm.com.ar/remates/prod.php?col=93&sec=23"
)
file = URI.open("https://carolinalascano.com.ar/esp/wp-content/uploads/haras-san-pablo-trabajo1.jpg")
auction4.photo.attach(io: file, filename: "auction.png", content_type: "image/png")
auction4.save!

puts "Created auctions"
