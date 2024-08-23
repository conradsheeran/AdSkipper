import {appNameClass} from '../model/AppNameClass';
import { bufferToString } from '@ohos/utils';

@Component
struct AppListItem {
  @Prop appListItem: appNameClass;

  build() {
    Row({space: 24}) {
      Image($r(this.appListItem.imageSrc))
        .objectFit(ImageFit.Cover)
        .height($r('app.float.IconSize'))
        .width($r('app.float.IconSize'))
        .borderRadius($r('app.float.IconSize'))
        .margin({left: '2%'})

      Text(this.appListItem.name)
        .height('100%')
        .width('100%')
        .fontSize($r('app.float.subtitle'))
        .textAlign(TextAlign.Start)
    }
    .width('100%')
    .height($r('app.float.ListHeight'))
    .borderRadius($r('app.float.BorderRadius'))
    .backgroundColor(Color.White)
    .padding(12)
    .margin({top: 16})
    .justifyContent(FlexAlign.Start)
  }
}

@Component
export struct ListView {
  @State appNameList: appNameClass[] = [];

  aboutToAppear(): void {
    this.getEnablementDataFromJSON();
  }

  getEnablementDataFromJSON(){
    getContext(this).resourceManager.getRawFileContent('appNameData.json').then(value => {
      let buffer: ArrayBufferLike = value.buffer;
      let res:string = bufferToString(buffer);
      this.appNameList = JSON.parse(res) as appNameClass[];
    })
  }

  build() {
    List({space: 10}) {
      ForEach(
        this.appNameList,
        (item: appNameClass) => {
          ListItem() {
            AppListItem({appListItem: item})
          }
        }, (item: appNameClass) => item.id
      )
    }
    .width('100%')
    .height('100%')
    .scrollBar(BarState.Off)
    .padding({left: 16, right: 16})
  }
}