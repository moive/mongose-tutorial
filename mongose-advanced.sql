-- insert data restaurante
var n = {
	"nombre": "Pizza el Horno",
	"rating": 4.7,
	"fechaInauguracion": new Date(),
	"categorias":["Tostadas","Cocteles","Bebidas"]
}

db.restaurantes.insertOne(n)

-- insert first document in repartidores collections
var m = {
	"nombre":"María",
	"curp": "ERMA567823NK1",
	"vehiculos": [
		{
			"placa": "YUR1202",
			"modelo":2020,
			"marca": "Mortalica"
		},
		{
			"placa": "IUT1202",
			"modelo":2018,
			"marca": "Susiki"
		}
	],
	"idRestaurante": ObjectId("644b2f8ea65a77e371671f14")
}

db.respartidores.insertOne(m)

-- join in mongodb with aggregate and $lookup

db.getCollection('respartidores').aggregate([
	{
		$lookup: {
			from: "restaurantes",
			localField: "idRestaurante",
			foreignField: "_id",
			as: "restaurante"
		}
	}
])