// Import from package
const express = require('express');
const mongoose = require('mongoose');
// Create app instance before using it
const PORT = 3000;
const app = express();
// Import from other files
const authRouter = require('./routes/auth');

// Middleware
app.use(express.json());
app.use(authRouter);

//connections
mongoose.connect(DB).then(()=>{console.log('Connection successful');}).catch(err=>{console.log(err);});

app.listen(PORT,"0.0.0.0",()=>{
    console.log(`connected at port ${PORT}`);
});
