

@CustomDialog
export  default  struct CustomDialogWidget{
  @State cancelBtText:string='';
  @State confirmBtText:string='';
  controller: CustomDialogController
  confirm:()=>void;
build(){
  Column(){
    Text("提示").margin({top:10})
      .fontSize(18)
    Text("注销后账号也将销毁，是否注销？").margin({top:20,bottom:20})

    Flex({direction:FlexDirection.Row}){
      Text("取消").onClick(()=>{
        this.controller.close()
      }).padding({bottom:20}).width('50%')
        .textAlign(TextAlign.Center)
      Text("确认").onClick(()=>{
        this.controller.close()
        this.confirm()
      }).padding({bottom:20}).width('50%')
        .textAlign(TextAlign.Center)

    }
    .width('100%')
  }
}
}