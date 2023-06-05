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
			as: "restaurante" -- show option as array
		}
	},
	{ $unwind: "$restaurante" } -- show restaurante as object
])

-- https://www.youtube.com/watch?v=XinaNVwid9w
use baseJHerrera
db.grupos.insert({_id: 1.0, nombreg: 'ITIC81', carrera: 'Ingenieria TIC'})
db.grupos.insert({_id: 2.0, nombreg: 'ITIC82', carrera: 'Ingenieria TIC'})
db.grupos.insert({_id: 3.0, nombreg: 'RT 51', carrera: 'Redes'})

db.alumnos.insertMany([
	{'_id':1.0, matricula: '2233225566', nombre: 'Paty', app: 'Lopez', sexo: 'F', idg:1, edad: 20},
	{'_id':2.0, matricula: '2233225345', nombre: 'Joel', app: 'Mendez', sexo: 'M', idg:1, edad: 25},
	{'_id':3.0, matricula: '2233285868', nombre: 'Fernando', app: 'Ramirez', sexo: 'M', idg:2, edad: 30},
	{'_id':4.0, matricula: '2233756765', nombre: 'Laura', app: 'Herrera', sexo: 'F', idg:2, edad: 25},
	{'_id':5.0, matricula: '2234568596', nombre: 'Memo', app: 'Torres', sexo: 'M', idg:3, edad: 30},
	{'_id':6.0, matricula: '2296856777', nombre: 'Karla', app: 'Lopez', sexo: 'F', idg:3, edad: 23}
])

-- join collection alumnos and grupos
db.alumnos.aggregate([
{$lookup: {
         from: 'grupos',
         localField:'idg',
         foreignField: '_id',
         as: 'grupos'   
    }
}
])

-- only gender M and college career Redes
db.alumnos.aggregate([
{$lookup: {
         from: 'grupos',
         localField:'idg',
         foreignField: '_id',
         as: 'grupos'   
    }
},
{$match: {sexo: 'M', 'grupos.carrera': 'Redes'}}
])

-- using $project show only anywhere field
db.alumnos.aggregate([
{$lookup: {
         from: 'grupos',
         localField:'idg',
         foreignField: '_id',
         as: 'grupos'   
    }
},
{$match: {sexo: 'M', 'grupos.carrera': 'Redes'}},
{$project: {
    _id:0,
    matricula:1,
    nombre:1,
    sexo:1,
    carrera: '$grupos.carrera'
}}
])

-- show data grupo in root
db.alumnos.aggregate([
{$lookup: {
         from: 'grupos',
         localField:'idg',
         foreignField: '_id',
         as: 'grupos'   
    }
},
{
    $replaceRoot: {
        newRoot: {
            $mergeObjects: [{$arrayElemAt: ['$grupos',0]}, '$$ROOT']
        }
    }
},
{$match: {sexo: 'M', carrera: 'Redes'}},
/*{$project: {
    _id:0,
    matricula:1,
    nombre:1,
    sexo:1,
    carrera: '$grupos.carrera'
}}*/
])

-- sort asc
db.alumnos.aggregate([
{$lookup: {
         from: 'grupos',
         localField:'idg',
         foreignField: '_id',
         as: 'grupos'   
    }
},
{
    $replaceRoot: {
        newRoot: {
            $mergeObjects: [{$arrayElemAt: ['$grupos',0]}, '$$ROOT']
        }
    }
},
{$match: {edad: {$gte: 25}, carrera: 'Ingenieria TIC'}},
{
    $sort: {nombre: -1}
}
])

--using $project

db.alumnos.aggregate([
{$lookup: {
         from: 'grupos',
         localField:'idg',
         foreignField: '_id',
         as: 'grupos'   
    }
},
{
    $replaceRoot: {
        newRoot: {
            $mergeObjects: [{$arrayElemAt: ['$grupos',0]}, '$$ROOT']
        }
    }
},
{$match: {edad: {$gte: 25}, carrera: 'Ingenieria TIC'}},
{
    $sort: {nombre: -1}
},
{
    $project: {
        _id:0,
        matricula:1,
        nombre:1,
        carrera:1,
        nombreg:1
    }
}


--fullname

db.alumnos.aggregate([
{$lookup: {
         from: 'grupos',
         localField:'idg',
         foreignField: '_id',
         as: 'grupos'   
    }
},
{
    $replaceRoot: {
        newRoot: {
            $mergeObjects: [{$arrayElemAt: ['$grupos',0]}, '$$ROOT']
        }
    }
},
{$match: {edad: {$gte: 25}, carrera: 'Ingenieria TIC'}},
{
    $sort: {nombre: -1}
},
{
    $project: {
        _id:0,
        matricula:1,
        nombre:{$concat: ['$nombre',' ','$app']},
        carrera:1,
        nombreg:1
    }
}
])