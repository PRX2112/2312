//server site

>>server.js
const express=require('express')
const mongoose=require('mongoose')
const app=express()
const routesBlog=require('./routes/blog_routes')
const cors=require('cors')

mongoose.connect('mongodb://localhost:27017/blog')
app.use(express.json())
app.use(cors())
app.use('/blog',routesBlog)



app.listen(5000,()=>{
    console.log('server is running')
})

test.rest

POST http://localhost:5000/blog/register


###

GET http://localhost:5000/blog/dispBlog

###

GET http://localhost:5000/blog/getOneBlog/634f7c7282759c5f47f49ae8

###

PATCH http://localhost:5000/blog/updateBlog/634ebe225c97f13f8b7305c9

###

GET http://localhost:5000/blog/search/PHP

>>model>>blog_models

const mongoose=require('mongoose')
const submit=new mongoose.Schema({
    blog_type:{
        type:String,
        require:true,
    },
    blog:{
        type:String,
        require:true,
    },
    description:{
        type:String,
        require:true,
    },
    created_by:{
        type:String,
        require:true
    }
})

module.exports=mongoose.model('blog_master',submit)

>>routes>>blog_routes

const express=require('express')
const router=express.Router()
const bloginfo=require('../models/blog_models')


router.post('/register', async (req,res)=>{
    const blogentry=new bloginfo({
        blog_type:req.body.type,
        blog:req.body.name,
        description:req.body.description,
        created_by:req.body.created,
    })
    blogentry.save()
})
router.get('/dispBlog',async(req,res)=>{
    const data= await bloginfo.find()
    res.json(data)
})


router.delete('/delete/:id',async(req,res)=>{
    try{
        const id=req.params.id
        const data=await bloginfo.findByIdAndDelete(id)
        res.send('Blog data is deleted')
    }
    catch(error)
    {
        res.json({message:error.message})
    }
})

// //get data by id


router.get('/getOneBlog/:id',async(req,res)=>{
    try{
        const data=await bloginfo.findById(req.params.id)
        res.json(data)
    }
    catch(error)
    {
        res.json({message:error.message})
    }
})

router.patch('/updateBlog/:id',async(req,res)=>{
    const result = await bloginfo.findByIdAndUpdate(req.params.id,{
        blog_type:req.body.type,
        blog:req.body.name,
        description:req.body.description,
        created_by:req.body.created,
    })
    res.send("Updated Successfully")
})

router.get('/search/:key',async(req,res)=>{
    const result = await bloginfo.find({
        "$or":[
            {blog_type : {$regex : req.params.key}}
            
        ]
    })
    res.json(result)
})

module.exports=router

Client Side

BlogDisplay.js

import React, { useEffect, useState } from 'react'
import axios from 'axios'
import { NavLink } from 'react-router-dom'

const BlogDisplay = () => {
    const [data,setData]=useState([])
    const[key,setKey]=useState('')
    useEffect(()=>{
        
        getdata()
    },[])
    const getdata= async()=>{
      try{
      const result=await axios.get('http://localhost:5000/blog/dispBlog')
      setData(result.data)
      }
      catch(error)
      {
          console.log(error)
      }
  }
    const deleteBlog=async(id)=>{
      let result= await axios.delete(`http://localhost:5000/blog/delete/${id}`)
      if(result){
        alert("Blog deleted")
        getdata()
      }
    }
    const searchBlog = async(e)=>{
      let key=e.target.value
      if(key)
      {
      const result = await axios.get(`http://localhost:5000/blog/search/${key}`)
      if(result)
      {
        setData(result.data)
      }
      else
      {
        getdata()
      }
      }
      
    }
    const Blogrecord=data.map((d)=>{
        return(
            <tr key={d}>
                <td>{d.blog_type}</td>
                <td>{d.blog}</td>
                <td>{d.description}</td>
                <td>{d.created_by}</td>
                <td><button><NavLink to={`Blogupdate/`+d._id}>Update</NavLink></button></td>
                <td><button onClick={()=>deleteBlog(d._id)}>Delete</button></td>
            </tr>
        )
    })
  return (
    <div className='App'>
    <div className='App-header'>
        Search : <input type="text" onChange={searchBlog}/>
      <table className='table table-hover'>
        <tr>
            <th>Blog Type</th>
            <th>Blog Name</th>
            <th>Description</th>
            <th>Created By</th>
            <th>Update</th>
            <th>Delete</th>
        </tr>
        {Blogrecord}
      </table>
    </div>
    </div>
  )
}

export default BlogDisplay

>>BlogInsert

import React,{useState} from 'react'
import axios from 'axios'
import { useNavigate } from 'react-router-dom'

const BlogInsert = () => {
    let navigate=useNavigate()
    const [type,setType]=useState('')
    const [name,setName]=useState('')
    const [description,setDes]=useState('')
    const [created,setCreated]=useState('')
    const handleType=(e)=>{
        setType(e.target.value)
    }
    const handleName=(e)=>{
        setName(e.target.value)
    }
    const handleDes=(e)=>{
        setDes(e.target.value)
    }
    const handleCreated=(e)=>{
        setCreated(e.target.value)
    }
    const collectData=()=>{
        try{
        let insertData=axios.post('http://localhost:5000/blog/register',{
            type,
            name,
            description,
            created

        });
        if(insertData)
        {
            navigate('/',{replace:true})
            navigate(0)
            console.log('inserted')
        }
    }
    catch(error)
    {
        console.log(error)
    }
}
  return (
    <div className='App'>
      <header className='App-header'>
        <h3>Blog</h3>
        <label>
            Blog Type:
        </label>
        <input type="text" name="type" value={type} required onChange={(e)=>handleType(e)}/><br/>
        <label>
            Blog Name:
        </label>
        <input type="text" name="name" value={name} required onChange={(e)=>handleName(e)}/><br/>
        <label>
            Description:
        </label>
        <input type="text" name="description" value={description} required onChange={(e)=>handleDes(e)}/><br/>
        <label>
            Created By:
        </label>
        <input type="text" name="created" value={created} required onChange={(e)=>handleCreated(e)}/><br/>
        <button type="button" name='submit'onClick={collectData}>Submit</button>
      </header>
    </div>
  )
}

export default BlogInsert

>>blogupdate

import React,{useState} from 'react'
import axios from 'axios'
import { useNavigate} from 'react-router-dom'
import { useEffect } from 'react'
import { useParams } from 'react-router-dom'


const BlogUpdate = () => {
    let navigate=useNavigate()
    const [type,setType]=useState('')
    const [name,setName]=useState('')
    const [description,setDes]=useState('')
    const [created,setCreated]=useState('')
    const params=useParams()
    const handleType=(e)=>{
        setType(e.target.value)
    }
    const handleName=(e)=>{
        setName(e.target.value)
    }
    const handleDes=(e)=>{
        setDes(e.target.value)
    }
    const handleCreated=(e)=>{
        setCreated(e.target.value)
    }
    const dispData= async() =>{
        const result=await axios.get(`http://localhost:5000/blog/getOneBlog/${params.id}`)
        setType(result.data.blog_type)
        setName(result.data.blog)
        setDes(result.data.description)
        setCreated(result.data.created_by)
    }
    useEffect(()=>{
        dispData()
    },[])
    const collectData=async()=>{
        const result = await axios.patch(`http://localhost:5000/blog/updateBlog/${params.id}`,{
            type,
            name,
            description,
            created
        })

        if(result){
            navigate('/')
        }
}
  return (
    <div className='App'>
      <header className='App-header'>
        <h3>Blog</h3>
        <label>
            Blog Type:
        </label>
        <input type="text" name="type" value={type} required onChange={(e)=>handleType(e)}/><br/>
        <label>
            Blog Name:
        </label>
        <input type="text" name="name" value={name} required onChange={(e)=>handleName(e)}/><br/>
        <label>
            Description:
        </label>
        <input type="text" name="description" value={description} required onChange={(e)=>handleDes(e)}/><br/>
        <label>
            Created By:
        </label>
        <input type="text" name="created" value={created} required onChange={(e)=>handleCreated(e)}/><br/>
        <button type="button" name='submit'onClick={collectData}>Submit</button>
      </header>
    </div>
  )
}

export default BlogUpdate

>>App.js

import './App.css';
import { Route,Routes } from 'react-router-dom';
import Header from './comp/Header';
import BlogInsert from './comp/BlogInsert';
import BlogDisplay from './comp/BlogDisplay';
import BlogUpdate from './comp/BlogUpdate';
function App() {
  return (
    <div>
      <Header/>
      <Routes>
        <Route path='/' element={<BlogDisplay/>} exact/>
        <Route path='/Bloginsert' element={<BlogInsert/>} exact/>
        <Route path='/Blogupdate/:id' element={<BlogUpdate/>} exact/>
        <Route path='*' element={<BlogDisplay/>} exact/>
      </Routes>  

    </div>
  );
}

export default App;


>>header.js

import React from 'react'
import { NavLink } from 'react-router-dom'
const Header = () => {
  return (
    <div className='App'>
      <nav>
      <button>
      <NavLink to= '/'>Home</NavLink>
      </button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      {
        <>
        <button>
        <NavLink to= '/Bloginsert'>Insert Blog</NavLink>
        </button>

        {/* <NavLink to= '/Blogupdate'>Update Blog</NavLink> */}
        </>
        }
      </nav>
    </div>
  )
}

export default Header

