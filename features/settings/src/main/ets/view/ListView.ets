import { ListItemClass } from '../model/ListItemClass';
import { bufferToString } from '@ohos/utils';

@Component
struct AppListItem {
  @Prop ListItem: ListItemClass;

  build() {
    Row({space: 24}) {
      Column() {
        Text(this.ListItem.title)
          .height('40%')
          .width('100%')
          .fontSize($r('app.float.subtitle'))
          .margin({top: '3%', left: '3%'})
          .textAlign(TextAlign.Start)

        Text(this.ListItem.remark)
          .height('50%')
          .width('100%')
          .margin({left: '3%'})
          .fontSize($r('app.float.content'))
          .textAlign(TextAlign.Start)
      }
      .width('65%')
      .height('100%')

      Blank()

      Toggle({ type: ToggleType.Switch, isOn: false })
        .onChange((isOn: boolean) => {
          if(isOn) {
            // 需要执行的操作
          }
        })
        .size({
          "width": 57.6,
          "height": 32
        })
        .selectedColor($r('app.color.ToggleBackground'))
        .margin({right: '15%'})
    }
    .width('100%')
    .height($r('app.float.setup_ListHeight'))
    .borderRadius($r('app.float.BorderRadius'))
    .backgroundColor(Color.White)
    .padding(12)
    .margin({top: 16})
    .justifyContent(FlexAlign.Start)
  }
}

@Component
export struct ListView {
  @State ListItem: ListItemClass[] = [];

  aboutToAppear(): void {
    this.getEnablementDataFromJSON();
  }

  getEnablementDataFromJSON(){
    getContext(this).resourceManager.getRawFileContent('ListItemData.json').then(value => {
      let buffer: ArrayBufferLike = value.buffer;
      let res:string = bufferToString(buffer);
      this.ListItem = JSON.parse(res) as ListItemClass[];
    })
  }

  build() {
    List({space: 10}) {
      ForEach(
        this.ListItem,
        (item: ListItemClass) => {
          ListItem() {
            AppListItem({ListItem: item})
          }
        }, (item: ListItemClass) => item.id
      )
    }
    .width('100%')
    .height('100%')
    .scrollBar(BarState.Off)
    .padding({left: 16, right: 16})
  }
}