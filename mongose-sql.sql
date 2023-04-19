-- For see: https://www.youtube.com/playlist?list=PLvimn1Ins-43y_9RNEo4JIFdpA5SJCYey
-- For see: https://www.youtube.com/playlist?list=PL1BztTYDF-QM6KSVfrbSyJNTU9inyBqYF

-- https://www.youtube.com/watch?v=4q2DRov45uQ
-- https://www.youtube.com/watch?v=SgP0dpHqT3A&list=PLctyDGmPjnNyvjAlN4N_zo488-U6wRX2N&index=14

--ubicarse donde se a guardar el backup
mongodump --db <database name>

-- ubicarse donde están los backup database
mongorestore --db <database name> <"dump/<folder name database>">

db.users.count() -- deprecated total count users

db.usuarios.countDocuments()
db.usuarios.estimatedDocumentCount()

db.users.find() -- list all users - mongodb only 20 then type 'it' for more


db.users.find({age: 30}) -- list all documents age = 30

db.users.find({age: 34, name: 'Luis'}) -- list all documents age = 34 and name = 'Luis'

var query = {"age": {"$lt": 18}} -- < 18 (less then: <) with equal ({"$lte": 18})
db.users.find(query).count() -- cantidad menores de 18

var query = {"age": {"$gt":18}} -- > 18 (greater than: >) with equal ({"$gte: 18"})
db.users.find({query}) -- list all documents then age > 18

-- (!=) not equal ({"$ne": 18})

var query = {"edad": {"$gte": 30, "$lte":60}}
db.usuarios.count(query) -- count
db.usuarios.find(query) -- show data validate query

-- conectores logicos
var query = {"$and": [{"edad": 34},{"edad": 38}]}

db.usuarios.count(query); -- 0  no hay edad de 34 y 38 a la vez

var query = {"$or": [{"edad": 34}, {"edad": 38}]}
clients> db.usuarios.count(query)
clients> db.usuarios.find(query)

var query = {"$or": [{"$and": [{"edad": {"$gt": 10}}, {"edad": {"$lt": 20}}]}, {"edad": {"$gt": 50, "$lt": 60}}]}

db.usuarios.count(query)
db.usuarios.find(query)

var query = {"colores": "rojo"} -- buscar items colores: ['azul', 'rojo']
db.usuarios.find(query)
db.usuarios.count(query)

var query = {"colores": ["verde", "rojo"]} -- buscar "verde" y "rojo"
db.usuarios.find(query)
db.usuarios.count(query)


--display all databases
show dbs

-- create database
use kanban

--create new collection
db.createCollection('cards')

-- display collection
show collection
-- or
show tables

-- insert document in collection 'cards'
var d = {"title":"A card"}
db.cards.insertOne(d)