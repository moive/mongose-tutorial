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


-- insert 1000 documents in collections 'cards'
for(var i = 0; i < 100; i++){
	var d = {
		"title": "Card # " + (i+1),
		"random1":Math.trunc(Math.random() * 1000),
		"random2":Math.trunc(Math.random() * 1000),
		"random3":Math.trunc(Math.random() * 1000),
	};

	db.cards.insertOne(d);
}
-- display count all documents in cards
db.cards.countDocuments();

-- In SQL: select * from cards where random3 > 900
db.cards.find({"random3": {$gt: 900}})

-- In SQL: select * from cards where random3 >= 900
db.cards.find({"random3": {$gte: 900}})

-- shows numbers of elements according to search
db.cards.countDocuments({"random3": {$gt: 900}})


-- In SQL: select * from cards where random3 < 100
db.cards.find({"random3": {$lt: 100}})

-- In SQL: select * from cards where random3 <= 100
db.cards.find({"random3": {$lte: 100}})


-- In SQL: select * from cards where random3 <> 100
db.cards.find({"random3": {$ne: 100}})


-- create object
var n = {
	"sku": "000012123",
	"product": "Acetaminofen",
	"activePrinciple": ["acetaminofen", "dextrometorfano"],
	"almacenes": [
		{"store":"main", "stock": 10},
		{"store":"branch 1", "stock": 50},
	]
}

--create and insert n in products collection
db.products.insertOne(n)

--other register
var n = {
	"sku": "0000121111",
	"product": "Migradoxina",
	"activePrinciple": ["cafeina", "amoxilina"],
	"almacenes": [
		{"store":"main", "stock": 40},
		{"store":"branch 1", "stock": 10},
	]
}

db.products.insertOne(n)

var n = {
	"sku": "0000121001",
	"product": "Clavulin",
	"activePrinciple": ["amoxicilina", "acido clavulinico"],
	"almacenes": [
		{"store":"main", "stock": 400},
		{"store":"branch 1", "stock": 210},
	]
}

db.products.insertOne(n)

--search q = {"activePrinciple":"cafeina"}
db.products.find({"activePrinciple":"cafeina"})

-- search complex

var q = {"$or": [{"almacenes.stock": {$lt: 10}},{"almacenes.stock": {$gt: 200}}]}
db.products.find(q)

-- update data

-- insert 3 times: {"a":1,"b":2,"c":3} in db.updatecol
db.updatecol.insertOne({"a":1,"b":2,"c":3})

--search with objectId
var q = {"_id": ObjectId("644079e2ab2e4d925acbb4ff")}

--or
var q = {"_id": new ObjectId("644079e2ab2e4d925acbb4ff")}

-- update value
db.updatecol.updateOne(q, {$set:{"a":10, "b":20, "c": 60}})

-- other way
-- { new: true } return new value
db.updatecol.findOneAndUpdate(q, {$set:{"a":110,"b":75}},{new: true})

-- increment {$inc: {c:2}}
db.updatecol.updateOne(q,{$inc: {c:2}})

--add new element to array $push
-- {
--     _id: ObjectId("644079e2ab2e4d925acbb4ff"),
--     a: 110,
--     b: 75,
--     c: 64,
--     d: [ 'hello', 'bye' ]
-- }
db.updatecol.updateOne(q,{$push: {d:"hello"}})
db.updatecol.updateOne(q,{$push: {d:"bye"}})