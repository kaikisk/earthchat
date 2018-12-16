
var earthchat = require('./earthchat.js');
var http = require('http');
var url = require('url');
var fs = require('fs');
var path = require('path');
var form = fs.readFileSync('index.html');
http.createServer(function (request, response) {
		var lookup = url.parse(decodeURI(request.url)).pathname;
		lookup = path.normalize(lookup);
		if (lookup === '/index.html') {
			response.writeHead(200, { 'Content-Type': 'text/html' });
			response.end(form);
			return;
		} 
		response.writeHead(200, { 'Content-Type': 'urf-8' });
		var chats = earthchat.getChat()
		console.log(chats)
		var result = {};
		response.end(JSON.stringify(chats));
}).listen(8080);
