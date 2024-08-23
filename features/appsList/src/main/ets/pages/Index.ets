import {ListView} from '../view/ListView'

@Entry({routeName: 'appsList'})
@Component
export struct appsList {
  @State message: Resource = $r('app.string.appList_HomeTitle');

  // TODO: perf: Use Navigation components to reconstruct the interface and optimize the user experience

  build() {
    Column() {
      Text(this.message)
        .fontSize($r('app.float.title'))
        .fontWeight(500)
        .fontFamily('HarmonyHeiTi-Bold')
        .backgroundColor($r('app.color.TitleBar'))
        .align(Alignment.Start)
        .padding({left: '3.6%'})
        .width('100%')
        .height('9.2%')
      ListView()
    }
    .height('100%')
    .width('100%')
    .backgroundColor($r('app.color.background'))
  }
}