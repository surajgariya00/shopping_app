const express = require('express');
const User = require('../models/user');
const bcryptjs = require('bcryptjs');

const authRouter = express.Router();
// authRouter.get('/user',(req, res) => {res.json({msg:'success'});});


//SignUp 
authRouter.post('/api/signup',async(req, res) => {
    try {
        const {name,email,password} = req.body;
        // get the user from client
    
        const existingUser = await User.findOne({email});
        if(existingUser){
            return res.status(400).json({msg:'User with same email already exists'});
        }
       const hashedPassword= await bcryptjs.hash(password, 8);
    
        let user = new User({
            email,password:hashedPassword,name,
    
        })
        user= await user.save();
        res.json(user);
    } catch(e) {
        res.status(500).json({error:e.message});
    }
  


    //post the data to the database
    //return  the data to the user
})  
// authRouter.get('/api/signup',async(req, res) => {
//     const {name,email,password} = req.body;
//      // get the user from client
 
//      const existingUser = await User.findOne({email});
//      if(existingUser){
//          return res.status(400).json({msg:'User with same email already exists'});
//      }
 
//      let user = new User({
//          email,password,name,
 
//      })
//      user= await user.save();
//      res.json(user);
 
 
//      //post the data to the database
//      //return  the data to the user
//  })  


module.exports = authRouter;