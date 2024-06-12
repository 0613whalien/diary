import CommonConstant from '../../common/constants/CommonConstants'
import { addTask, deleteTask, getAllTask, updateTask } from '../../viewmodel/TaskViewModel'
import TaskView from '../../view/TaskView'
import AddBtn from '../../view/AddBtnComponent'
import router from '@ohos.router'
import TaskInfo from '../../viewmodel/TaskInfo'
import PreferencesUtil from '../../common/database/PreferencesUtil'
import hilog from '@ohos.hilog'
import { getTextByFontSize } from '../../common/utils/Utils'
import Logger from '../../common/utils/Logger'
import { StorageUtils } from '../../utils/StorageUtils'
import { TextUtils } from '../../utils/TextUtil'

const TAG = '[IndexMain]';


@Entry
@Component
export struct Index2 {
  @State todoTask: Array<TaskInfo> = null
  taskId: number = 0
  @State changeFontSize: number = 1;
  @State status:string='0'

  @State bannerList:any[]=[
    {"img":$r('app.media.banner1')},
    {"img":$r('app.media.banner2')},

    {"img":$r('app.media.banner3')},

    {"img":$r('app.media.banner4')},

  ]

aboutToAppear(){
  this.refreshTaskList()
  this.initAccPreference()

}

  onPageShow() {
    this.refreshTaskList()
    //从Preferences里面读取保存的字体大小
    PreferencesUtil.getChangeFontSize().then((value) => {
      this.changeFontSize = value;
      Logger.info(TAG, 'Get the value of changeFontSize: ' + this.changeFontSize);
    });
  }

  //从数据库获取最新的代办列表数据
  refreshTaskList() {
    getAllTask().then((res: TaskInfo[]) => {
      this.todoTask = res;
    })
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
    Stack() {
      Column({ space: CommonConstant.COLUMN_SPACE }) {

        Row(){
          Text(" ")
          Text("日记")
            .fontSize(30)
            .fontWeight(FontWeight.Bold)
          Text(this.status=="0"?$r('app.string.net_new_quit_cn'):$r('app.string.net_new_quit_en'))
            .fontSize(12)
            .fontColor(Color.Red)
            .onClick(()=>{
              // StorageUtils.clear()
              router.replaceUrl({url:'pages/Mine/denglu'})
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .padding({left:15,right:15,top:16})



        Swiper() {
          ForEach(this.bannerList, (item: any) => {
            Image(item.img).width('90%').height(160)
              .borderRadius(10)
          })
        }
        .cachedCount(2)
        .index(1)
        .autoPlay(true)
        .interval(4000)
        .indicator(true)
        .loop(true)
        .duration(1000)
        .itemSpace(0)
        .curve(Curve.Linear)
        .onChange((index: number) => {
          console.info(index.toString())
        })

        //如果代办的数据数量大于0，那么显示列表，否则显示空页面
        if (this.todoTask?.length > 0) {
          List({ space: CommonConstant.COLUMN_SPACE }) {
            ForEach(this.todoTask, (item: TaskInfo) => {
              ListItem() {
                TaskView({
                  changeFontSize: $changeFontSize,
                  taskInfo: item,
                  editTaskClick: () => {
                    this.editTaskAction(item)
                  },

                  onLongTaskClick: () => {
                    this.deleteTask(item)
                  }
                })
              }
            }, (item: string) => JSON.stringify(item))
          }
          .width('100%')
          .layoutWeight(1)



        }
      }
      .width('100%')
      .height('100%')
      .backgroundColor("#FFFFFF")

      AddBtn({ clickAction: () => {
        this.newTaskAction()
      } })
    }
  }



  //删除待办事项
  deleteTask(taskInfo: TaskInfo) {
    AlertDialog.show(
      {
        title: '删除记录', // 标题
        message: '是否需要删除该记录?', // 内容
        autoCancel: false, // 点击遮障层时，是否关闭弹窗。
        alignment: DialogAlignment.Bottom, // 弹窗在竖直方向的对齐方式
        offset: { dx: 0, dy: -20 }, // 弹窗相对alignment位置的偏移量
        primaryButton: {
          value: '取消',
          action: () => {
            console.info('Callback when the first button is clicked');
          }
        },
        secondaryButton: {
          value: '删除',
          fontColor: '#D94838',
          action: () => {
            deleteTask(taskInfo).then(() => {
              this.refreshTaskList()
            })
          }
        },
        cancel: () => { // 点击遮障层关闭dialog时的回调
          console.info('Closed callbacks');
        }
      }
    )

  }

  //跳转新建待办事项页面
  newTaskAction() {
    router.pushUrl({ url: 'pages/Goal/NewTaskPage' });
  }

  //编辑待办事项，跳转编辑页面
  editTaskAction(taskInfo: TaskInfo) {
    router.pushUrl({ url: 'pages/Goal/EditTaskPage', params: taskInfo });
  }
}


