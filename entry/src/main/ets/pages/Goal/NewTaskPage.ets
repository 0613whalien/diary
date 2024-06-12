import router from '@ohos.router'
import { StorageUtils } from '../../utils/StorageUtils'
import { TextUtils } from '../../utils/TextUtil'
import TaskInfo from '../../viewmodel/TaskInfo'
import { addTask } from '../../viewmodel/TaskViewModel'

@Entry
@Component
struct NewTaskPage {

  @State taskInfo: TaskInfo = new TaskInfo(0, 0, false, 0, '', '')

  @State status:string='0'
  aboutToAppear(){
    this.initAccPreference()
  }
  async initAccPreference(){
    if (!TextUtils.isEmpty(await this.getAccPreference())) {
      var s=await this.getAccPreference()
      let data:string=JSON.parse(s)
      this.status=data
    }
  }

  async getAccPreference(): Promise<string> {
    let theme: string = ''
    theme = await StorageUtils.get('language') as string
    return theme
  }
  build() {
    Column() {
      Row({space: 10}) {
        Button(this.status=="1"?$r('app.string.net_task_back_en'):$r('app.string.net_task_back_cn'), {type: ButtonType.Capsule, stateEffect: true})
          .backgroundColor('#ff0be5dd')
          .height(30)
          .onClick(() => {
            router.back()
          })
        Blank().layoutWeight(1)
        Text(this.status=="1"?$r('app.string.net_task_add_en'):$r('app.string.net_task_add_cn'))

      }
      .width('100%')

      Text(this.status=="1"?$r('app.string.net_task_title_en'):$r('app.string.net_task_title_cn'))
        .alignSelf(ItemAlign.Start)
        .margin({top:20})

      TextInput({ placeholder: this.status=="1"?$r('app.string.net_task_input_hint_en'):$r('app.string.net_task_input_hint_cn')})
        .onChange((value) => {
          this.taskInfo.title = value
        })
        .margin({top:5})

      Text( this.status=="1"?$r('app.string.net_task_content_en'):$r('app.string.net_task_content_cn'))
        .alignSelf(ItemAlign.Start)
        .margin({top:20})

      TextArea({ placeholder:this.status=="1"?$r('app.string.net_task_input_content_en'):$r('app.string.net_task_input_content_cn') })
        .onChange((value) => {
          this.taskInfo.content = value
        })
        .margin({top:5})
        .height(200)

      //如果用户输入了标题，那么完成按钮再显示出来
      if (this.taskInfo?.title.length > 0) {
        Button(this.status=="1"?$r('app.string.net_task_submit_en'):$r('app.string.net_task_submit_cn'), {type: ButtonType.Capsule, stateEffect: true})
          .backgroundColor('#ff0be5dd')
          .width('90%')
          .height(50)
          .onClick(() => {
            this.addTask()
          })
          .margin({top: 20})
      }


    }
    .height('100%')
    .padding(16)
  }

  //添加待办事项到数据库
  addTask() {
    this.taskInfo.createTime = new Date().getTime()
    this.taskInfo.taskID = new Date().getTime()
    addTask(this.taskInfo).then(() => {
      router.back()
    })
  }

}