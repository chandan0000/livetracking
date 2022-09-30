const express = require('express');
const app = express();
const http = require('http');
const server = http.createServer(app);
const { Server } = require("socket.io");
const PORT = process.env.PORT || 3700;
const io = new Server(server);

io.on('connection', (socket) => {
    socket.on('position-change', (data) => {
        console.log(data);});



});

server.listen(PORT, () => {
    console.log(`listening on *:${PORT}`);
});