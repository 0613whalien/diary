import router from '@ohos.router';
import { StorageUtils } from '../../utils/StorageUtils';
import { TextUtils } from '../../utils/TextUtil';
import showToast from '../../utils/ToastUtils';

@Entry
@Component
struct Index {
  @State switchLanguage: number = 0 //0 中文 1英语
  @State muser: string = "";
  @State mpassword: string = "";
  @State save_acc: string = ''
  @State save_psw: string = ''

  async initAccPreference() {     //检查本地存储中是否有保存的账号信息,如果有，则提取并设置给save_acc变量
    if (!TextUtils.isEmpty(await this.getAccPreference())) {
      var s = await this.getAccPreference()
      let data: string = JSON.parse(s)
      this.save_acc = data
      console.log("userInfo_acc" + data)

    }
  }

  async aboutToAppear() {

    await  this.initAccPreference()
    await  this.initPswPreference()

  }

  async onPageShow() {

    await  this.initAccPreference()
    await  this.initPswPreference()
  }

  async initPswPreference() {     //检查本地存储中是否有保存的密码信息,如果有，则提取并设置给save_psw变量
    if (!TextUtils.isEmpty(await this.getPswPreference())) {
      var s = await this.getPswPreference()
      let data: string = JSON.parse(s)
      this.save_psw = data
      console.log("userInfo_psw" + data)

    }
  }

  async getAccPreference(): Promise<string> {   //从本地存储中获取保存的账户信息并返回
    let theme: string = ''
    theme = await StorageUtils.get('acc') as string
    return theme
  }

  async getPswPreference(): Promise<string> {    //从本地存储中获取保存的密码信息并返回
    let theme: string = ''
    theme = await StorageUtils.get('pwd') as string
    return theme
  }

  build() {      //页面构建
    Column() {
      Column() {

        Text(this.switchLanguage == 0 ? $r('app.string.login_title_cn') : $r('app.string.login_title_en'))  //中英文设置
          .fontColor('#ff04d6f3')
          .fontSize(24)
      }
      .height('30%')
      .justifyContent(FlexAlign.Center)

      Column() {
        Row() {
          // 用户名输入框
          TextInput({
            placeholder: this.switchLanguage == 0 ? "请输入账户" : $r('app.string.login_account_en')
          })
            .type(InputType.Normal)
            .width('80%')
            .height(55)
            .placeholderColor(Color.Black)
            .backgroundColor('#ffd2d7d2')
            .borderRadius(13)
            .margin({ bottom: 12 })
            .onChange((value: string) => {
              this.muser = value
            })
        }

        Row() {
          TextInput({
            placeholder: this.switchLanguage == 0 ? $r('app.string.login_password_cn') : $r('app.string.login_password_en')
          })
            .type(InputType.Password)
            .width('80%')
            .height(55)
            .placeholderColor(Color.Black)
            .backgroundColor('#ffd2d7d2')
            .borderRadius(13)
            .onChange((value: string) => {
              this.mpassword = value
            })
        }


        Row() {
          Select([{ value: '中文简体', icon: $r('app.media.china') },
            { value: 'English', icon: $r('app.media.english') }
          ])
            .selected(2)
            .value('中文简体')
            .font({ size: 16, weight: 500 })
            .fontColor('#182431')
            .selectedOptionFont({ size: 16, weight: 400 })
            .optionFont({ size: 16, weight: 400 })
            .onSelect((index: number) => {
              if (index == 0) {
                this.switchLanguage = 0
                StorageUtils.put("language", "0")
              }

              if (index == 1) {
                this.switchLanguage = 1
                StorageUtils.put("language", "1")

              }
            })
            .height(40)
        }
        .margin({ top: 10 })
        .justifyContent(FlexAlign.End)
        .width('80%')


        Column() {
          Button(this.switchLanguage == 0 ? $r('app.string.login_landing_cn') : $r('app.string.login_landing_en'))
            .width(220)
            .height(40)
            .fontColor(Color.White)
            .onClick(() => {
              if (this.muser == '' && this.mpassword == '') {
                showToast(this.switchLanguage == 0 ? $r('app.string.login_toast_acc_cn') : $r('app.string.login_toast_acc_en'))
              } else {
                if (this.muser == this.save_acc && this.mpassword == this.save_psw) {
                  router.replaceUrl({
                    url: "pages/Goal/Index2"
                  })
                } else {
                  showToast(this.switchLanguage == 0 ? $r('app.string.login_toast_acc_error_cn') : $r('app.string.login_toast_acc_error_en'))
                }
              }

            })
            .backgroundColor('#ff13e3c5')
            .borderStyle(BorderStyle.Dotted)
          Button(this.switchLanguage == 0 ? $r('app.string.login_register_cn') : $r('app.string.login_register_en'))
            .width(220)
            .height(40)
            .fontColor(Color.White)
            .onClick(() => {
              if (this.save_acc != "" && this.save_psw != "") {
                showToast(this.switchLanguage == 0 ? $r('app.string.login_toast_acc_exists_cn') : $r('app.string.login_toast_acc_exists_en'))
              } else {
                router.pushUrl({
                  url: "pages/Mine/zhuce"
                })
              }

            })
            .margin({ top: 20 })
            .backgroundColor('#ff0be5dd')
        }
        .margin({ top: 20 })
        .justifyContent(FlexAlign.SpaceEvenly)
      }
      .width("100%")
      .height("30%")

    }
    .height('100%')
    .width('100%')
    .margin({ bottom: 20 })

  }
}
