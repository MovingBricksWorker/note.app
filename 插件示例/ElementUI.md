<div id="app1">
  <div>
    <el-button @click="show3 = !show3">Click Me</el-button>
    <div style="margin-top: 20px; height: 200px;">
      <el-collapse-transition>
        <div v-show="show3">
          <div class="transition-box">el-collapse-transition</div>
          <div class="transition-box">el-collapse-transition</div>
        </div>
      </el-collapse-transition>
    </div>
  </div>
<br>
  <div class="date-picker">
     <el-date-picker
      v-model="value1"
      type="datetime"
      placeholder="选择日期时间">
    </el-date-picker>
  </div>
<br>
<div>
<el-tag>标签一</el-tag>
<el-tag type="success">标签二</el-tag>
<el-tag type="info">标签三</el-tag>
<el-tag type="warning">标签四</el-tag>
<el-tag type="danger" closable>标签五</el-tag>
</div>
<br>
<div>
<el-progress :text-inside="true" :stroke-width="26" :percentage="70"></el-progress>
<el-progress :text-inside="true" :stroke-width="24" :percentage="100" status="success"></el-progress>
<el-progress :text-inside="true" :stroke-width="22" :percentage="80" status="warning"></el-progress>
<el-progress :text-inside="true" :stroke-width="20" :percentage="50" status="exception"></el-progress>
<el-progress type="circle" :percentage="0"></el-progress>
<el-progress type="circle" :percentage="25"></el-progress>
<el-progress type="circle" :percentage="100" status="success"></el-progress>
<el-progress type="circle" :percentage="70" status="warning"></el-progress>
<el-progress type="circle" :percentage="50" status="exception"></el-progress>
</div>
<br>
<div> 
  <el-avatar icon="el-icon-user-solid"></el-avatar>
    <el-avatar src="https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png"></el-avatar>
     <el-avatar> 👤 </el-avatar>
    <el-avatar> 王 </el-avatar>
 </div>
  <br>
  <div class="alert-demo">
    <el-alert
    title="不可关闭的 alert"
    type="success"
    :closable="false" show-icon>
  </el-alert>
<el-alert
    title="这是一条错误❌的示范"
    type="error"
    :closable="false" show-icon>
  </el-alert>
  <el-alert
    title="自定义 close-text"
    type="info"
    close-text="知道了" show-icon>
  </el-alert>
  <el-alert
    title="设置了回调的 alert"
    type="warning"
    @close="hello" show-icon>
  </el-alert>
  </div>
<br>
  <div>
  <el-steps :active="0" align-center>
  <el-step title="步骤1" description="这是一段很长很长很长的描述性文字"></el-step>
  <el-step title="步骤2" description="这是一段很长很长很长的描述性文字"></el-step>
  <el-step title="步骤3" description="这是一段很长很长很长的描述性文字"></el-step>
  <el-step title="步骤4" description="这是一段很长很长很长的描述性文字"></el-step>
</el-steps>  
</div>
<br>
<div style="height: 300px;">
  <el-steps direction="vertical" :active="3">
    <el-step title="步骤 1" description="初始化"></el-step>
    <el-step title="步骤 2" description="写代码"></el-step>
    <el-step title="步骤 3" description="上线了"></el-step>
  </el-steps>
</div>
<br>
<div>
  <el-popover
    placement="top-start"
    title="标题"
    width="200"
    trigger="hover"
    content="这是一段内容,这是一段内容,这是一段内容,这是一段内容。">
    <el-button slot="reference">hover 激活</el-button>
  </el-popover>
</div>
<br>
<div>
  <el-row>
  <el-col :span="8" v-for="(o, index) in 2" :key="o" :offset="index > 0 ? 2 : 0">
    <el-card :body-style="{ padding: '0px' }">
      <img src="https://shadow.elemecdn.com/app/element/hamburger.9cf7b091-55e9-11e9-a976-7f4d0b07eef6.png" class="image" data-no-zoom>
      <div style="padding: 14px;">
        <span>好吃的汉堡</span>
        <div class="bottom clearfix">
          <time class="time">{{ currentDate }}</time>
          <el-button type="text" class="button">操作按钮</el-button>
        </div>
      </div>
    </el-card>
  </el-col>
</el-row>
</div>
<br>
<div style="text-align:center;">
  <el-carousel :interval="3000" arrow="always">
    <el-carousel-item v-for="item in 4" :key="item">
      <span style="font-size:50px;color:#fff;">{{ item }}</span>
    </el-carousel-item>
  </el-carousel>
</div>
<br>
<div>
<!-- <el-collapse  accordion> 手风琴模式 -->
  <el-collapse>
  <el-collapse-item title="一致性 Consistency">
    <div>与现实生活一致：与现实生活的流程、逻辑保持一致，遵循用户习惯的语言和概念；</div>
    <div>在界面中一致：所有的元素和结构需保持一致，比如：设计样式、图标和文本、元素的位置等。</div>
  </el-collapse-item>
  <el-collapse-item title="反馈 Feedback" >
    <div>控制反馈：通过界面样式和交互动效让用户可以清晰的感知自己的操作；</div>
    <div>页面反馈：操作后，通过页面元素的变化清晰地展现当前状态。</div>
  </el-collapse-item>
  <el-collapse-item title="效率 Efficiency">
    <div>简化流程：设计简洁直观的操作流程；</div>
    <div>清晰明确：语言表达清晰且表意明确，让用户快速理解进而作出决策；</div>
    <div>帮助用户识别：界面简单直白，让用户快速识别而非回忆，减少用户记忆负担。</div>
  </el-collapse-item>
  <el-collapse-item title="可控 Controllability">
    <div>用户决策：根据场景可给予用户操作建议或安全提示，但不能代替用户进行决策；</div>
    <div>结果可控：用户可以自由的进行操作，包括撤销、回退和终止当前操作等。</div>
  </el-collapse-item>
</el-collapse>
</div>
<br>
<div class="timeLine">
  <el-timeline>
    <el-timeline-item timestamp="2018/4/12" placement="top">
      <el-card>
        <h4>更新 Github 模板</h4>
        <p>王小虎 提交于 2018/4/12 20:46</p>
      </el-card>
    </el-timeline-item>
    <el-timeline-item timestamp="2018/4/3" placement="top">
      <el-card>
        <h4>更新 Github 模板</h4>
        <p>王小虎 提交于 2018/4/3 20:46</p>
      </el-card>
    </el-timeline-item>
    <el-timeline-item timestamp="2018/4/2" placement="top">
      <el-card>
        <h4>更新 Github 模板</h4>
        <p>王小虎 提交于 2018/4/2 20:46</p>
      </el-card>
    </el-timeline-item>
  </el-timeline>
</div>
<br>
<div>
<el-calendar v-model="currentDate">
</el-calendar> 
</div>
<br>
<div>
  <el-badge :value="12" class="item">
  <el-button size="small">评论</el-button>
</el-badge>
<el-badge :value="3" class="item">
  <el-button size="small">回复</el-button>
</el-badge>
<el-badge :value="1" class="item" type="primary">
  <el-button size="small">评论</el-button>
</el-badge>
<el-badge :value="2" class="item" type="warning">
  <el-button size="small">回复</el-button>
</el-badge>

<el-dropdown trigger="click">
  <span class="el-dropdown-link">
    点我查看<i class="el-icon-caret-bottom el-icon--right"></i>
  </span>
  <el-dropdown-menu slot="dropdown">
    <el-dropdown-item class="clearfix">
      评论
      <el-badge class="mark" :value="12" />
    </el-dropdown-item>
    <el-dropdown-item class="clearfix">
      回复
      <el-badge class="mark" :value="3" />
    </el-dropdown-item>
  </el-dropdown-menu>
</el-dropdown>
 </div>
  <br>
<div>
  <el-rate
  v-model="rate"
  disabled
  show-score
  text-color="#ff9900"
  score-template="{value}分">
</el-rate>
<el-rate
  v-model="rate"
  disabled
  show-score
  text-color="#ff9900"
  score-template="{value}分">
</el-rate>
<el-rate
  v-model="rate"
  disabled
  show-score
  text-color="#ff9900"
  score-template="{value}分">
</el-rate>
</div>
</div>
<script>
new Vue({ 
el: "#app1",
data(){
return {
  rate: 4.7,
  show3: true,
  drawer: false,
  currentDate: new Date(),
  options: [{
          value: '选项1',
          label: '黄金糕'
        }, {
          value: '选项2',
          label: '双皮奶'
        }, {
          value: '选项3',
          label: '蚵仔煎'
        }, {
          value: '选项4',
          label: '龙须面'
        }, {
          value: '选项5',
          label: '北京烤鸭'
        }],
        value1: ''
   }
 },
methods: {
      hello() {
        this.$message({
          message: '世界,你好!',
          type: 'success'
        });
      }
    }
})
</script>

<style>
.item {
  margin-top: 10px;
  margin-right: 40px;
  font-size:15px;
}
  .transition-box {
    margin-bottom: 10px;
    width: 200px;
    height: 100px;
    border-radius: 4px;
    background-color: #409EFF;
    text-align: center;
    color: #fff;
    padding: 40px 20px;
    box-sizing: border-box;
    margin-right: 20px;
  }
.time {
    font-size: 13px;
    color: #999;
  }
  
  .bottom {
    margin-top: 13px;
    line-height: 12px;
  }

  .button {
    padding: 0;
    float: right;
  }

  .image {
    width: 100%;
    display: block;
  }

  .clearfix:before,
  .clearfix:after {
      display: table;
      content: "";
  }
  
  .clearfix:after {
      clear: both
  }
.el-carousel__item h3 {
    color: #475669;
    font-size: 18px;
    opacity: 0.75;
    line-height: 300px;
    margin: 0;
  }
  
  .el-carousel__item:nth-child(2n) {
    background-color: #99a9bf;
  }
  
  .el-carousel__item:nth-child(2n+1) {
    background-color: #d3dce6;
  }
  .el-timeline-item {
    position: relative;
    padding-bottom: 20px;
    list-style-type: none !important;
}
</style>
