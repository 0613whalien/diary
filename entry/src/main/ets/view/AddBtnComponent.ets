

import CommonConstants  from '../common/constants/CommonConstants';

@Styles function allSize () {
  .width(CommonConstants.THOUSANDTH_1000)
  .height(CommonConstants.THOUSANDTH_1000)
}

@Preview
@Component
export default struct AddBtn {
  clickAction: Function = () => {};

  build() {
    Button({ type: ButtonType.Circle, stateEffect: false }) {
      Image($r('app.media.ic_home_add'))
        .allSize()
        .borderRadius(CommonConstants.BORDER_RADIUS_PERCENT_50)
    }
    .onClick(() => this.clickAction())
    .zIndex(CommonConstants.HOME_BTN_Z)
    .position({ x: CommonConstants.THOUSANDTH_830, y: CommonConstants.THOUSANDTH_750 })
    .width("48vp")
    .height("48vp")
  }
}