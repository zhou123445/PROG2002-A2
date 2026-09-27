const apiBase = "http://localhost:3000/api";
const eventListEl = document.getElementById("eventList");
const categorySelectEl = document.getElementById("categorySelect");
const modalEl = document.getElementById("detailModal");
const detailBodyEl = document.getElementById("detailBody");
const closeBtn = document.querySelector(".close-btn");

// 加载全部活动
async function loadAllEvents(){
    const res = await fetch(`${apiBase}/home-events`);
    const events = await res.json();
    renderEvents(events);
}

// 加载分类下拉框
async function loadCategories(){
    const res = await fetch(`${apiBase}/categories`);
    const categories = await res.json();
    categories.forEach(cat=>{
        const opt = document.createElement("option");
        opt.value = cat.category_id;
        opt.textContent = cat.category_name;
        categorySelectEl.appendChild(opt);
    })
}

// 渲染活动卡片
function renderEvents(events){
    eventListEl.innerHTML = "";
    events.forEach(evt=>{
        const card = document.createElement("div");
        card.className = "event-card";
        card.innerHTML = `
            <h3>${evt.event_name}</h3>
            <p>${evt.event_description}</p>
            <p>Location: ${evt.location}</p>
            <p>Goal: $${evt.charity_goal}</p>
        `;
        card.onclick = ()=> openDetail(evt.event_id);
        eventListEl.appendChild(card);
    })
}

// 打开详情弹窗（新版：格式化日期 + 筹款进度条）
async function openDetail(id){
    const res = await fetch(`${apiBase}/event/${id}`);
    const data = await res.json();
    if(!res.ok){
        detailBodyEl.innerHTML = `<h3>Event Not Found</h3>`;
    }else{
        // 澳洲日期格式 DD/MM/YYYY
        const rawDate = new Date(data.event_date);
        const formatDate = rawDate.toLocaleDateString('en-AU');
        // 计算筹款百分比，上限100%
        const goal = Number(data.charity_goal);
        const progress = Number(data.current_progress);
        const percent = Math.min(100, Math.round(progress / goal * 100));

        detailBodyEl.innerHTML = `
            <h2>${data.event_name}</h2>
            <p>${data.event_description}</p>
            <p>Date: ${formatDate}</p>
            <p>Location: ${data.location}</p>
            <p>Ticket Price: $${data.ticket_price}</p>
            <p>Charity Goal: $${data.charity_goal}</p>
            <div style="margin:10px 0;">
                <p>Fundraising Progress: ${percent}%</p>
                <div style="width:100%;background:#eee;border-radius:6px;height:20px;">
                    <div style="width:${percent}%;background:#28a745;height:20px;border-radius:6px;"></div>
                </div>
                <p>Current Raised: $${data.current_progress}</p>
            </div>
            <p>Category: ${data.category_name}</p>
            <p>Organiser: ${data.org_name}</p>
        `;
    }
    modalEl.style.display = "block";
}

// 分类筛选
categorySelectEl.addEventListener("change", async ()=>{
    const cid = categorySelectEl.value;
    let url = `${apiBase}/search-events`;
    if(cid){
        url += `?category_id=${cid}`;
    }
    const res = await fetch(url);
    const events = await res.json();
    renderEvents(events);
})

// 关闭弹窗
closeBtn.onclick = ()=> modalEl.style.display = "none";
window.onclick = (e)=>{
    if(e.target === modalEl) modalEl.style.display = "none";
}

// 页面初始化
loadAllEvents();
loadCategories();
