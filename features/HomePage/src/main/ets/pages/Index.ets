import { router } from '@kit.ArkUI'
import '@ohos/appsList/src/main/ets/pages/Index'
import { accessibility } from '@kit.AccessibilityKit';
import { common } from '@kit.AbilityKit';
import { JumpToApp } from '@ohos/utils';

@Component
export struct HomePage {
  @State handlePopup: boolean = false

  build() {
    Column() {
      Image($r('app.media.questionmark_circle'))
        .width(36)
        .margin({top: '7%', right: '7%'})
        .onClick(() => {
          this.handlePopup = !this.handlePopup
        })
        .bindPopup(this.handlePopup, {
          message: "试试点击史努比吧",
          messageOptions: {
            font: {
              size: $r('app.float.subtitle')
            }
          }
        })

      Row() {
        Image($r('app.media.vendorIcon'))
          .width(124)
          .margin({left: '15%'})
          .onClick(() => {
            router.pushNamedRoute({
              name: 'appsList'
            })
          })

        Blank()

        Toggle({ type: ToggleType.Switch, isOn: false })
          .onChange((isOn: boolean) => {
            if(isOn) {
              let accessibilityStatus: boolean = accessibility.isOpenAccessibilitySync();
              if (!accessibilityStatus) {
                const context: common.UIAbilityContext = getContext(this) as common.UIAbilityContext;
                const bundleName: string = 'com.huawei.hmos.settings'
                const abilityName: string = 'com.huawei.hmos.settings.MainAbility'
                const uri: string = 'accessibility_feature'
                JumpToApp(context, bundleName, abilityName, uri);
              }
            }
            if (!isOn) {

              // TODO: perf: Improve the function of turning off skipping ads

            }
          })
          .size({
            "width": 72,
            "height": 40
          })
          .selectedColor($r('app.color.ToggleBackground'))
          .margin({right: '15%'})
      }
      .width('100%')
      .height('50%')
      .margin({top: '20%'})
      .alignItems(VerticalAlign.Center)

    }
    .height('100%')
    .width('100%')
    .alignItems(HorizontalAlign.End)
    .backgroundColor($r('app.color.background'))
  }
}
