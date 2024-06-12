import router from '@ohos.router';
import prompt from '@system.prompt';
import { StorageUtils } from '../../utils/StorageUtils';
import { TextUtils } from '../../utils/TextUtil';
import showToast from '../../utils/ToastUtils';
@Entry
@Component
export struct zhuce {
  @State message: string = "";
  @State mima1: string="";
  @State mima2: string="";
  @State status:string='0'
  aboutToAppear(){
    this.initAccPreference()
  }

  async initAccPreference(){   //检查存储中是否存在语言偏好设置，存在则将其解析并更新到组件状态中的status属性中
    if (!TextUtils.isEmpty(await this.getAccPreference())) {
      var s=await this.getAccPreference()      //从存储中获取语言偏好设置
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
    Column(){
      Column() {

        Text(this.status=='0'?$r('app.string.login_register_cn'):$r('app.string.login_register_en'))
          .fontColor('#ff13e3c5')
          .fontSize(24)
      }.margin({ bottom: 20 })
      .height('20%')
      .justifyContent(FlexAlign.Center)
      Column()
      {
        Row()
        {
          // 用户名输入框
          TextInput({ placeholder: this.status=="0"?$r('app.string.login_account_cn'):$r('app.string.login_account_en')})
            .type(InputType.Normal)
            .width('80%')
            .height(55)
            .placeholderColor(Color.Black)
            .backgroundColor('#ffd2d7d2')
            .borderRadius(13)
            .margin({ bottom: 12})
            .onChange((value:string)=>{
              this.message=value
            })
        }
        Row()
        {
          TextInput({ placeholder: this.status=="0"?$r('app.string.login_password_cn'):$r('app.string.login_password_en')})
            .type(InputType.Password)
            .width('80%')
            .height(55)
            .placeholderColor(Color.Black)
            .backgroundColor('#ffd2d7d2')
            .borderRadius(13)
            .margin({ bottom: 12})
            .onChange((value:string)=>{
              this.mima1=value
            })
        }
        Row()
        {
          TextInput({ placeholder:this.status=="0"?'再次输入密码':$r('app.string.login_password_en')})
            .type(InputType.Password)
            .width('80%')
            .height(55)
            .placeholderColor(Color.Black)
            .backgroundColor('#ffd2d7d2')
            .borderRadius(13)
            .margin({ bottom: 12})
            .onChange((value:string)=>{
              this.mima2=value
            })
        }
        Row()
        {

          Button(this.status=='0'?$r('app.string.net_new_acc_cn'):$r('app.string.net_new_acc_en'))
            .margin({bottom:50})
            .width(120)
            .height(40)
            .fontColor(Color.White)
            .onClick(() => {


              if (this.message==''&&this.mima1==''&&this.mima2=='') {
                showToast(this.status=="0"?$r('app.string.login_toast_acc_cn'):$r('app.string.login_toast_acc_en'))

              }else {

                if(this.mima1==this.mima2){
                  StorageUtils.put("acc",this.message)
                  StorageUtils.put("pwd",this.mima1)
                  prompt.showToast({
                    message: 'success！',
                    duration: 2000,
                  });
                  router.back({
                    url: 'pages/Mine/denglu',
                  })

                }
                else{

                  showToast(this.status=="0"?$r('app.string.net_new_query_cn'):$r('app.string.net_new_query_en'))

                }

              }


            })
            .backgroundColor('#ff13e3c5')
            .width('80%')
            .borderStyle(BorderStyle.Dotted)
        }
        .justifyContent(FlexAlign.SpaceEvenly)
      }
      .width("100%")
      .height("30%")

    }
    .height('100%')
    .width('100%')
    .margin({bottom:20})

  }
}
