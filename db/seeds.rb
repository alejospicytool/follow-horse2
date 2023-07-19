# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

require "open-uri"

puts "Destroying Favorites"
Favorite.destroy_all
puts "Destroyed Favorites"
puts "----------------------"
puts "Destryoing horses"
Horse.destroy_all
puts "Destroyed Horses"
puts "----------------------"
puts "Destryoing auctions"
Auction.destroy_all
puts "Destroyed Auctions"
puts "----------------------"
puts "Destryoing users"
User.destroy_all
puts "Destroyed Users"
puts "----------------------"

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

user5 = User.new(email: "maki@gmail.com", password: "123456", nombre: "Ryusei", apellido: "Makiguchi", age: 30, pais: "Argentina", provincia: "Buenos Aires", ciudad: "Benavidez", direccion: "Av. Montes de Oca 2945", phone: "+5491149851247", description: "I love horses", establishment: "Haras El Maki")
file = URI.open("https://ca.slack-edge.com/T02NE0241-U03PTAN9ARE-e0ff21331654-512")
user5.photo.attach(io: file, filename: "maki.png", content_type: "image/png")
user5.save!

user6 = User.new(email: "admin@gmail.com", password: "123456", nombre: "Admin", apellido: "1", age: 30, pais: "Argentina", provincia: "Capital Federal", ciudad: "Capital Federal", direccion: "Av. Montes de Oca 2945", phone: "+5491149851247", description: "I love horses", establishment: "Haras El Maki", admin: true)
file = URI.open("https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png")
user6.photo.attach(io: file, filename: "foto.png", content_type: "image/png")
user6.save!

puts "Created users"
puts "----------------------"
puts "Creating horses"

horse1 = Horse.new(name: "Luqui", rider: "Beni", alzada: "21", height: "1.0", birthday: "22/10/2022", gender: "M", user_id: user1.id, description: "Descripión caballo texto con info. descripión caballo. Texto con info. Descripión caballo texto con info. Descripión caballo, texto con info.", age: 3, video: "http://embed.wistia.com/deliveries/f05edc86686dd1401fac203f004096fb.bin")
horse1.save!

horse2 = Horse.new(name: "Valentina", rider: "Maki", alzada: "21", height: "1.5", birthday: "22/10/2019", gender: "F", user_id: user1.id, description: "Descripión caballo texto con info. descripión caballo. Texto con info. Descripión caballo texto con info. Descripión caballo, texto con info.", age: 5, video: "http://embed.wistia.com/deliveries/ad85ed31d149d7a4cf8ef9559a22288f.bin")
horse2.save!

horse3 = Horse.new(name: "Pedro", rider: "Juan Carlos", alzada: "22", height: "2.0", birthday: "22/10/2018", gender: "M", user_id: user5.id, description: "Descripión caballo texto con info. descripión caballo. Texto con info. Descripión caballo texto con info. Descripión caballo, texto con info.", age: 2, video: "http://embed.wistia.com/deliveries/55ae5115a46fe6a4292868be702c06d3.bin")
horse3.save!

horse4 = Horse.new(name: "Juana", rider: "Nestor", alzada: "23", height: "1.5", birthday: "22/10/2021", gender: "F", user_id: user5.id, description: "Descripión caballo texto con info. descripión caballo. Texto con info. Descripión caballo texto con info. Descripión caballo, texto con info.", age: 10, video: "http://embed.wistia.com/deliveries/d69342f6c4e927079fb358327ebbe914.bin")
horse4.save!

puts "Created horses"
puts "----------------------"
puts "Creating auctions"

auction1 = Auction.new(
  name: "Remate Haras Victoria",
  location: "Buenos Aires",
  user_id: user1.id,
  start: Time.now + 1.hour,
  finish: Time.now + 2.days,
  condiciones: "https://www.caccm.com.ar/remates/prod.php?col=93&sec=23",
  link_auction: "https://www.caccm.com.ar/remates/prod.php?col=93&sec=23"
)
file = URI.open("https://mir-s3-cdn-cf.behance.net/projects/404/e4104d112052313.Y3JvcCwxNjYzLDEzMDAsMCwxMjM.png")
auction1.photo.attach(io: file, filename: "auction.png", content_type: "image/png")
auction1.save!

auction2 = Auction.new(
  name: "Haras Remate AlBar",
  location: "Capitan Sarmiento",
  user_id: user1.id,
  start: Time.now + 1.hour,
  finish: Time.now + 2.days,
  condiciones: "https://www.caccm.com.ar/remates/prod.php?col=93&sec=23",
  link_auction: "https://www.caccm.com.ar/remates/prod.php?col=93&sec=23"
)
file = URI.open("https://www.guerra-creativa.com/img/uploads/designs/850x566/bimzp3p0.jpg")
auction2.photo.attach(io: file, filename: "auction.png", content_type: "image/png")
auction2.save!

auction3 = Auction.new(
  name: "Haras Selva de Pedra",
  location: "Rio Cuarto",
  user_id: user5.id,
  start: Time.now + 2.days,
  finish: Time.now + 4.days,
  condiciones: "https://www.caccm.com.ar/remates/prod.php?col=93&sec=23",
  link_auction: "https://www.caccm.com.ar/remates/prod.php?col=93&sec=23"
)
file = URI.open("https://s3-sa-east-1.amazonaws.com/projetos-artes/fullsize%2F2018%2F03%2F07%2F20%2FLogo-234918_70207_204757969_278263886.jpg")
auction3.photo.attach(io: file, filename: "auction.png", content_type: "image/png")
auction3.save!

auction4 = Auction.new(
  name: "Haras San Pablo",
  location: "Pergamino",
  user_id: user5.id,
  start: Time.now + 4.days,
  finish: Time.now + 6.days,
  condiciones: "https://www.caccm.com.ar/remates/prod.php?col=93&sec=23",
  link_auction: "https://www.caccm.com.ar/remates/prod.php?col=93&sec=23"
)
file = URI.open("https://carolinalascano.com.ar/esp/wp-content/uploads/haras-san-pablo-trabajo1.jpg")
auction4.photo.attach(io: file, filename: "auction.png", content_type: "image/png")
auction4.save!

auction5 = Auction.new(
  name: "Haras Remate Carampagne",
  location: "Hipoódromo de San Isidro",
  user_id: user4.id,
  start: Time.now + 1.hour,
  finish: Time.now + 2.days,
  condiciones: "https://www.caccm.com.ar/remates/prod.php?col=93&sec=23",
  link_auction: "https://www.arg-sales.com/remates/view/301"
)
file = URI.open("https://www.arg-sales.com/mydocuments/cd18e3a8-21d3-4c57-8149-a3a2776df442.png")
auction5.photo.attach(io: file, filename: "auction.png", content_type: "image/png")
auction5.save!

auction6 = Auction.new(
  name: "Haras El Rincon",
  location: "Buenos Aires",
  user_id: user3.id,
  start: Time.now + 2.days,
  finish: Time.now + 4.days,
  condiciones: "https://www.saenz-valiente.com/remate/22219",
  link_auction: "https://www.saenz-valiente.com/remate/22219"
)
file = URI.open("https://criolloselrincon.com.ar/img/logo.png")
auction6.photo.attach(io: file, filename: "auction.png", content_type: "image/png")
auction6.save!

puts "Created auctions"
