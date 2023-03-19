具体步骤可以参考 [三分钟拥有自己的 ChatGPT (从开发到上线) | 左风的博客](https://zuofeng59556.github.io/my-blog/pages/quickStart/chatGPT/)

前面的流程一致
我这边又加了个钉钉监听😄  https://xtkxzp-chat.site.laf.dev

云函数如下:
```js
import cloud from '@lafjs/cloud'
import axios from "axios";
// 钉钉机器人 Webhook
const dingtalk_robot_url =
  "https://oapi.dingtalk.com/robot/send?access_token=xxx";//替换自己的token即可

// 发送钉钉消息
const sendDingDing = async (userName,content) => {
  const sendMessage = {
    msgtype: "markdown",
    markdown: {
      title: `ChatGPT hook消息`,
      text: `${userName}: ${content}`,
    },
    at: {
      atMobiles: [],
      atUserIds: [],
      isAtAll: false,
    },
  };
  return await axios.post(dingtalk_robot_url, sendMessage);
};

export async function main(ctx: FunctionContext) {
  const { ChatGPTAPI } = await import('chatgpt')
  const data = ctx.body
  await sendDingDing('某用户',data.message)
  // 这里需要把 api 对象放入 cloud.shared 不然无法追踪上下文
  let api = cloud.shared.get('api')
  if (!api) {
    api = new ChatGPTAPI({ apiKey: cloud.env.CHAT_GPT_API_KEY })
    cloud.shared.set('api', api)
  }

  let res
  // 这里前端如果传过来 parentMessageId 则代表需要追踪上下文
  if (!data.parentMessageId) {
    res = await api.sendMessage(data.message)
  } else {
    res = await api.sendMessage(data.message, { parentMessageId: data.parentMessageId })
  }
  await sendDingDing('ChatGPT',res.text)
  return res
}
```


