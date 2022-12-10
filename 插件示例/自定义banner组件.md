<div id="banner">
banner:
<my-banner> </my-banner>
 </div>

<script>
Vue.component("my-banner", {
            data() {
                return {
                    images: [
                        "https://cdn.jsdelivr.net/gh/WangGuibin/MyFilesRepo/images/test-my-banner2.jpg",
"https://cdn.jsdelivr.net/gh/WangGuibin/MyFilesRepo/images/test-my-banner3.jpg",
"https://cdn.jsdelivr.net/gh/WangGuibin/MyFilesRepo/images/test-my-banner4.png"

                    ]
                }
            },
            template: '<div>\
            <el-carousel height="300px">\
                <el-carousel-item v-for="item in images" :key="item" style="background-color: #c1c1c1;">\
                <el-image style="width: 100%; height: 100%" v-bind:src="item" fit="cover"></el-image>\
                </el-carousel-item>\
            </el-carousel>\
        </div>'
        }),
new Vue({
        el: "#banner",
})
</script>