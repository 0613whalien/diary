import CommonConstant from '../common/constants/CommonConstants'
import TaskInfo from '../viewmodel/TaskInfo'
import { formatTimestamp } from '../common/utils/Utils'
import Logger from '../common/utils/Logger'

@Preview
@Component
export default struct TaskView {
  private taskInfo?: TaskInfo
  @Link changeFontSize: number;

  // @Builder loadLabel(icon: Resource) {
  //   Image(icon)
  //     .objectFit(ImageFit.Contain)
  //     .width(28 * this.changeFontSize)
  //     .height(28 * this.changeFontSize)
  //     .margin({ right: "12vp", left: 5 })
  //     .onClick(() => this.completeTaskClick())
  // }

  build() {
    Row() {

      // if (this.taskInfo.isDone) {
      //   this.loadLabel($r('app.media.ic_task_complete'))
      // } else {
      //   this.loadLabel($r('app.media.ic_task_not_complete'))
      // }


      Column() {

        Row() {
          Text(this.taskInfo.title)
            .fontSize(25 * this.changeFontSize)
            .fontWeight(500)
            .width(this.changeFontSize <= 1? 200 : (200 / this.changeFontSize))
            .opacity(this.taskInfo.isDone ? 0.4 : 1)
            .decoration({ type: this.taskInfo.isDone ? TextDecorationType.LineThrough : TextDecorationType.None })

          Blank()

          Text(formatTimestamp(this.taskInfo.createTime)).fontSize(16 * this.changeFontSize)
            .opacity(this.taskInfo.isDone ? 0.4 : 1)
            .decoration({ type: this.taskInfo.isDone ? TextDecorationType.LineThrough : TextDecorationType.None })
            .margin({ top: 2})

        }.width('100%')
        .clip(true)
        .padding({right: 5})
        .alignItems(VerticalAlign.Center)

        if (this.taskInfo.content.length > 0) {
          Text(this.taskInfo.content).fontSize(16 * this.changeFontSize).fontWeight(400)
            .opacity(this.taskInfo.isDone ? 0.4 : 1)
            .decoration({ type: this.taskInfo.isDone ? TextDecorationType.LineThrough : TextDecorationType.None })
            .maxLines(2)
            .textOverflow({overflow: TextOverflow.Ellipsis})
        }
      }.layoutWeight(1).alignItems(HorizontalAlign.Start)

    }
    .borderRadius(CommonConstant.BORDER_RADIUS)
    .width(CommonConstant.TASK_WIDTH)
    .margin({left: 16, right: 20})
    .backgroundColor($r('app.color.start_window_background'))
    .padding(12 * this.changeFontSize)
    .onClick(() => {
      this.editTaskClick()
    })
    .gesture(LongPressGesture()
      .onAction((event?: GestureEvent) => {
        this.onLongTaskClick()
        Logger.info(`onLongPress`);
      }))
  }

  private editTaskClick: Function = () => {
  }
  private completeTaskClick: Function = () => {
  }
  private onLongTaskClick: Function = () => {
  }
}