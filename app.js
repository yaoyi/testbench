var express = require('express')
	, http = require('http')
	, mongoose = require('mongoose')
	, qrcode = require('./models/qrcode')
	, QrcodeModel = require('mongoose').model('Qrcode')
	, app = express()

mongoose.connect('mongodb://localhost:27017/testbench_development');

app.get('/:id', function (req, res){
	console.log('get request id: ' + req.params.id)
	QrcodeModel.findOne({'_id':req.params.id}, function (err, qrcode) {
		res.send(qrcode)
	})
})

app.get('/', function (req, res){
	res.send('Hello World')
})

app.listen(9000, function(){
	console.log("Express server listening on port 9000" );
})