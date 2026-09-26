const express = require('express');
const db = require('./event_db');
const cors = require('cors');
const app = express();
const PORT = 3000;

app.use(cors());
app.use(express.json());

// 获取首页即将到来、未封禁活动
app.get('/api/home-events', async (req,res)=>{
    try{
        const sql = `SELECT e.*, c.category_name, o.org_name 
                    FROM events e
                    JOIN categories c ON e.category_id = c.category_id
                    JOIN charity_organisations o ON e.organisation_id = o.organisation_id
                    WHERE e.is_suspended = 0 AND e.event_date >= CURDATE()
                    ORDER BY e.event_date ASC`;
        const [rows] = await db.query(sql);
        return res.status(200).json(rows);
    }catch(err){
        return res.status(500).json({error: err.message});
    }
});

// 获取全部活动分类
app.get('/api/categories', async(req,res)=>{
    try{
        const [rows] = await db.query("SELECT * FROM categories");
        return res.status(200).json(rows);
    }catch(err){
        return res.status(500).json({error:err.message});
    }
});

// 多条件搜索接口
app.get('/api/search-events', async(req,res)=>{
    try{
        let baseSql = `SELECT e.*,c.category_name,o.org_name FROM events e
        JOIN categories c ON e.category_id=c.category_id
        JOIN charity_organisations o ON e.organisation_id=o.organisation_id
        WHERE e.is_suspended = 0 `;
        let params = [];

        if(req.query.category_id){
            baseSql += " AND e.category_id = ? ";
            params.push(req.query.category_id);
        }
        if(req.query.location){
            baseSql += " AND e.location LIKE ? ";
            params.push(`%${req.query.location.trim()}%`);
        }
        if(req.query.event_date){
            baseSql += " AND e.event_date = ? ";
            params.push(req.query.event_date);
        }
        baseSql += " ORDER BY e.event_date";
        const [rows] = await db.query(baseSql,params);
        return res.status(200).json(rows);
    }catch(err){
        return res.status(500).json({error:err.message});
    }
});

// 获取单个活动详情
app.get('/api/event/:id', async(req,res)=>{
    try{
        const eventId = req.params.id;
        const sql = `SELECT e.*,c.category_name,o.* FROM events e
        JOIN categories c ON e.category_id=c.category_id
        JOIN charity_organisations o ON e.organisation_id=o.organisation_id
        WHERE e.event_id = ?`;
        const [rows] = await db.query(sql,[eventId]);
        if(rows.length===0){
            return res.status(404).json({message:"Event not found"});
        }
        return res.status(200).json(rows[0]);
    }catch(err){
        return res.status(500).json({error:err.message});
    }
});

app.listen(PORT, ()=>{
    console.log(`API server running http://localhost:${PORT}`);
})
