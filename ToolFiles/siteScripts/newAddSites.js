const axios = require('axios');
const fs = require('fs');
const path = require('path');
require('dotenv').config();

const config = {
  token: process.env.TOKEN,
  domain: process.env.DOMAIN
};

const hostID = 4;

const sites = [
  { name: "", primary: "xxx.com", ip: "", hostId: 1, templateId: 833 },
]

function sleep(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}

async function getDomainId(domain) {
  try {
    const response = await axios.get(
      `${config.domain}/api/managed/domain/list?pageNum=1&pageSize=30&name=${domain}&domains=&notIn=false`,
      {
        headers: {
          'Content-Type': 'application/json',
          'Authorization': config.token,
          'Site': ''
        }
      }
    );

    if (response.data.code === 200) {
      console.log(`✅ 获取域名ID成功: 《${domain}》`);
      return response.data.data.list[0].id
    } else {
      console.error(`⚠️ 获取域名ID失败 (状态码 ${response.status}): 《${domain}》`, response.data);
    }
  } catch (error) {
    console.error(`❌ 获取域名ID请求失败: 《${domain}》`, error.response?.data || error.message || error);
  }
}

async function addSites() {
  if (sites.length === 0) {
    console.log('没有新站点需要添加！');
    return;
  }

  const failedSites = []; // 记录失败的站点
  const outputFile = path.resolve(__dirname, `newOutput/newAddSites/hostID=${hostID}_siteMap.json`);

  if (!fs.existsSync(outputFile)) {
    fs.writeFileSync(outputFile, '[]', 'utf-8');
  }

  let siteMaps = JSON.parse(fs.readFileSync(outputFile, 'utf-8'));

  for (const item of sites) {
    console.log(`开始添加站点: 《${item.name}》`);
    try {
      const domainId = await getDomainId(item.primary);
      if (!domainId) {
        console.error(`❌ 跳过站点: 《${item.name}》，未找到域名ID`);
        failedSites.push(item.name);
        continue;
      }

      const response = await axios.post(
        `${config.domain}/api/managed/site/add`,
        {
          "name": item.name,
          "domainId": domainId,
          "hostId": item.hostId,
          "args": "",
          "templateId": item.templateId
        },
        {
          headers: {
            'Content-Type': 'application/json',
            'Authorization': config.token,
            'Site': ''
          }
        }
      );

      if (response.data.code === 200) {
        console.log(`✅ 添加成功: 《${item.name}》`);
        console.log(response.data.data);
        const newID = response.data.data.id;
        const siteMap = {
          oldID: item.id,
          newID
        };

        // 加入数组并写回文件
        siteMaps.push(siteMap);
        fs.writeFileSync(outputFile, JSON.stringify(siteMaps, null, 2), 'utf-8');
        console.log(`📁 已写入 siteMap.json:`, siteMap);

      } else {
        console.error(`⚠️ 添加失败 (状态码 ${response.status}): 《${item.name}》`, response.data);
        failedSites.push(item.name);
      }
    } catch (error) {
      console.error(`❌ 添加请求失败: 《${item.name}》`, error.response?.data || error.message || error);
      failedSites.push(item.name);
    }

    // await sleep(2000); // 等待2秒
  }

  console.log(`\n添加任务完成`);
  if (failedSites.length > 0) {
    console.log(`❌ 以下站点添加失败: ${failedSites.join(', ')}`);
  } else {
    console.log(`🎉 所有站点添加成功！`);
  }
}

addSites();
