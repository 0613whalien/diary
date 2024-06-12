import router from '@ohos.router'
import { StorageUtils } from '../../utils/StorageUtils'
import { TextUtils } from '../../utils/TextUtil'
import TaskInfo from '../../viewmodel/TaskInfo'
import { addTask, updateTask} from '../../viewmodel/TaskViewModel'
@Entry
@Component
struct EditTaskPage {
  @State taskInfo:TaskInfo = null
  @State status:string='0'
  aboutToAppear() {
    this.taskInfo = router.getParams() as TaskInfo
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

        Text(this.status=="1"?$r('app.string.net_task_edit_en'):$r('app.string.net_task_edit_cn'))
      }
      .width('100%')

      Text(this.status=="1"?$r('app.string.net_task_add_en'):'标题').fontSize(20)
        .margin({top:20}).width('100%')

      TextInput({ placeholder: this.status=="1"?$r('app.string.net_task_title_en'):$r('app.string.net_task_input_hint_cn'), text: this.taskInfo?.title})
        .onChange((value) => {
          this.taskInfo.title = value
        })
        .margin({top:10})

      Text(this.status=="1"?$r('app.string.net_task_content_en'):$r('app.string.net_task_content_cn'))
        .margin({top:20}).width('100%').fontSize(20)

      TextArea({ placeholder: this.status=="1"?$r('app.string.net_task_content_en'):$r('app.string.net_task_input_content_cn'), text: this.taskInfo?.content})
        .onChange((value) => {
          this.taskInfo.content = value
        })
        .margin({top:10})
        .height(200)

      Button(this.status=="1"?$r('app.string.net_task_submit_en'):'保存', {type: ButtonType.Capsule, stateEffect: true})
        .backgroundColor('#ff0be5dd')
        .width('90%')
        .height(50)
        .onClick(() => {
          this.updateTask()
        })
        .margin({top: 20})
    }
    .padding(16)
  }

  //更新待办事项到数据库
  updateTask() {
    this.taskInfo.createTime = new Date().getTime()
    updateTask(this.taskInfo).then(() => {
      router.back()
    })
  }
}