const express = require('express'); 

const { MongoClient } = require('mongodb'); 

const app = express(); 

const port = 3000; 

const uri = "mongodb+srv://userOne:JUECc9PuA8RE5X69@cluster0.bff6seb.mongodb.net/travel";

let client;

async function connectionToDB(){
	client = new MongoClient(uri); 
	await client.connect(); 

	console.log("Connected to MongoDB Atlas");
	
}

connectionToDB();

app.use(express.json()); 

app.post('/addDocument', async(req ,res) => {
	const collection = client.db('travel').collection("entries");
	const result = await collection.insertOne(req.body);
	res.send(result);
});

app.get('/getDocuments', async(req, res) => {

	const collection = client.db("travel").collection("entries");
	const documents = await collection.find({}).toArray(); 
	res.send(documents);

});

app.listen(port, () => {
	console.log(`Server is running on PORT: ${port}`);
});
