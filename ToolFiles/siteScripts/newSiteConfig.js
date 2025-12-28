const axios = require('axios');
const fs = require('fs');
const path = require('path');
require('dotenv').config();

const config = {
  token: process.env.TOKEN,
  domain: process.env.DOMAIN
};

const sites = [
  {
    "id": 2002,
    "name": "",
    "title": "",
    "keyword": "",
    "description": "",
    "logo": "",
    "copyright": "Copyright © 2025",
    "footLink": "<a href=\"/about\">关于我们</a>"
  },
]

function sleep(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}

async function changeConfig() {
  if (sites.length === 0) {
    console.log('没有新站点需要修改！');
    return;
  }

  const failedSites = []; // 记录失败的站点
  const outputFile = path.resolve(__dirname, `newOutput/config/fail_config.json`);

  if (!fs.existsSync(outputFile)) {
    fs.writeFileSync(outputFile, '[]', 'utf-8');
  }

  for (const item of sites) {
    console.log(`开始修改站点: 《${item.name}》`);
    try {
      const response = await axios.post(
        `${config.domain}/api/site_config/batchEdit`,
        {
          list: [
            // { key: "SITE_INDEX_TITLE", value: item.title },
            // { key: "SITE_INDEX_KEYWORDS", value: item.keyword },
            // { key: "SITE_INDEX_DESCRIPTION", value: item.description },
            // { key: "SITE_FOOTER_LINKS", value: item.footLink },
            // { key: "SITE_LOGO", value: item.logo },
            // { key: "SITE_COPYRIGHT", value: item.copyright },
            // { key: "SITE_NAME", value: item.name }
            { key: "SITE_ICON", value: ""}
          ],
          siteIds: [item.id]
        },
        {
          headers: {
            'Content-Type': 'application/json',
            'Authorization': config.token,
            'Site': ''
          }
        }
      );

      if (response.status === 200) {
        console.log(`✅ 修改成功: 《${item.name}》`);
        console.log(response.data.data);
      } else {
        console.error(`⚠️ 修改失败 (状态码 ${response.status}): 《${item.name}》`, response.data);
        failedSites.push(item);
      }
    } catch (error) {
      console.error(`❌ 修改请求失败: 《${item.name}》`, error.response?.data || error.message || error);
      failedSites.push(item);
    }

    await sleep(1000); // 等待2秒
  }

  console.log(`\n修改任务完成`);
  if (failedSites.length > 0) {
    console.log(`❌ 以下站点修改失败: ${failedSites.map(s => s.name).join(", ")}`);

    // ✅ 写入失败记录到文件（包含完整数据，方便重试）
    const prev = JSON.parse(fs.readFileSync(outputFile, "utf-8"));
    const allFails = [...prev, ...failedSites];
    fs.writeFileSync(outputFile, JSON.stringify(allFails, null, 2), "utf-8");

    console.log(`📁 已写入失败记录到: ${outputFile}`);
  } else {
    console.log(`🎉 所有站点修改成功！`);
  }
}

changeConfig();
