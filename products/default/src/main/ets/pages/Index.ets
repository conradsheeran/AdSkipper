// TODO: refactor: Merge various parameters in all files into the resources folder

import { HomePage } from '@ohos/HomePage';
import '@ohos/settings/src/main/ets/pages/index';
import { router, SymbolGlyphModifier } from '@kit.ArkUI';
import { BrowsableAbility, JumpToApp } from '@ohos/utils';
import { common } from '@kit.AbilityKit';
import { accessibility } from '@kit.AccessibilityKit';

@CustomDialog
struct CustomDialog_HomePage {
  controller: CustomDialogController = new CustomDialogController({
    builder: CustomDialog_HomePage()
  })
  @State message_1: Resource = $r('app.string.WarningPageButton_1');
  @State message_2: Resource = $r('app.string.WarningPageButton_2');

  // TODO: perf: Use Navigation components to reconstruct the interface and optimize the user experience

  build() {
    Column() {
      Text($r('app.string.WarningTitle'))
        .fontSize($r('app.float.title'))
        .textAlign(TextAlign.Start)
        .margin({top: '7%'})
        .width('90%')

      Text($r('app.string.WarningContent_1'))
        .fontSize($r('app.float.WarningContent'))
        .textAlign(TextAlign.Start)
        .margin({top: '3%'})
        .width('90%')

      Text($r('app.string.WarningContent_2'))
        .fontSize($r('app.float.WarningContent'))
        .textAlign(TextAlign.Start)
        .margin({top: '3%'})
        .width('90%')

      Blank()

      Row() {
        Button(this.message_1, {type: ButtonType.Normal})
          .onClick(() => {
            const context: common.UIAbilityContext = getContext(this) as common.UIAbilityContext;
            const bundleName: string = 'com.huawei.hmos.settings'
            const abilityName: string = 'com.huawei.hmos.settings.MainAbility'
            const uri: string = 'accessibility_feature'
            JumpToApp(context, bundleName, abilityName, uri);
          })
          .backgroundColor(Color.Transparent)
          .fontColor($r('sys.color.font_primary'))
          .borderRadius($r('app.float.BorderRadius'))
          .width('48%')

        Divider().vertical(true).height(22).color($r('sys.color.font_primary')).opacity(0.6).margin({ left: 8, right: 8 })

        Button(this.message_2, {type: ButtonType.Normal})
          .onClick(() => {
            this.controller.close()
          })
          .backgroundColor(Color.Transparent)
          .fontColor(Color.Black)
          .borderRadius($r('app.float.BorderRadius'))
          .width('48%')
      }
      .width('90%')
      .margin({bottom: '7%'})
    }
    .height('50%')
    .width('100%')

  }
}

@Entry
@Component
struct Index {
  @State message: Resource = $r('app.string.HomeTitle');
  @State  gearshape: SymbolGlyphModifier = new SymbolGlyphModifier($r('sys.symbol.gearshape')).fontSize('24vp');
  @State  arrow_right_up_and_square: SymbolGlyphModifier = new SymbolGlyphModifier($r('sys.symbol.arrow_right_up_and_square')).fontSize('24vp')
  @State  heart: SymbolGlyphModifier = new SymbolGlyphModifier($r('sys.symbol.heart')).fontSize('24vp');
  dialogController: CustomDialogController = new CustomDialogController({
    builder: CustomDialog_HomePage(),
  })

  onPageShow(): void {
    let accessibilityStatus: boolean = accessibility.isOpenAccessibilitySync();
    if (!accessibilityStatus) {
      this.dialogController.open()
    }
  }

  build() {
    Column() {
      Row() {
        Text(this.message)
          .fontSize($r('app.float.title'))
          .fontWeight(500)
          .fontFamily('HarmonyHeiTi-Bold')
          .align(Alignment.Start)
          .padding({ left: '3.6%' })
          .height('9.2%')

        Blank()

        Image($r('app.media.dot_grid_2x2'))
          .margin({ right: '3.6%' })
          .width(36)
          .bindMenu([
            {
              value: $r('app.string.menuContent_1'),
              symbolIcon: this.gearshape,
              action: () => {
                router.pushNamedRoute({
                  name: "setup"
                })
              }
            },
            {
              value: $r('app.string.menuContent_2'),
              symbolIcon: this.arrow_right_up_and_square,
              action: () => {
                // 用浏览器跳转至Github仓库
                const context: common.UIAbilityContext = getContext(this) as common.UIAbilityContext;
                const uriContent: string = 'https://github.com/'
                BrowsableAbility(context, uriContent);
              }
            },
            {
              value: $r('app.string.menuContent_3'),
              symbolIcon: this.heart,
              action: () => {

                // TODO: feat: Add donation interface pop-up window(CustomDialog)

              }
            }
          ])
      }
      .backgroundColor($r('app.color.TitleBar'))
      .width('100%')

      HomePage()
    }
    .height('100%')
    .width('100%')
    .backgroundColor($r('app.color.background'))
  }
}