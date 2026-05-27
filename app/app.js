const express = require('express')
const app = express()

app.get('/', (req,res)=>{
    res.send('CURE backend running')
})

app.get('/health', (req,res)=>{
    res.status(200).json({
        status:'OK'
    })
})

app.listen(3000, '0.0.0.0', ()=>{
    console.log('Running on port 3000')
})