// TODO: perf: Improve Accessibility services

import {
  accessibility,
  AccessibilityElement,
  AccessibilityEvent,
  AccessibilityExtensionContext,
  ElementAttributeKeys,
  AccessibilityExtensionAbility,
  ElementAttributeValues
} from '@kit.AccessibilityKit';
import { Ability } from '@kit.AbilityKit';
import { Logger } from '@ohos/utils';

interface Rect {
  left: number,
  top: number,
  width: number,
  height: number,
}

// 想要查询的属性信息
let wantedAttribute: ElementAttributeKeys[] = ['bundleName', 'text', 'description', 'windowId'];
type attributeValues = string | number | boolean | AccessibilityElement | AccessibilityElement[] | string[] | Rect;

export default class AccessibilityManager {
  private static instance: AccessibilityManager;
  accessibleContext?: AccessibilityExtensionContext;
  currentPageElementArray: Array<AccessibilityElement> | null = null;

  static getInstance(): AccessibilityManager {
    if (!AccessibilityManager.instance) {
      AccessibilityManager.instance = new AccessibilityManager();
    }
    return AccessibilityManager.instance;
  }

  onStart(context: AccessibilityExtensionContext) {
    console.info(`AccessibilityManager onStart`);
    this.accessibleContext = context;
  }

  onStop() {
    console.info(`AccessibilityManager onStop`);
    this.accessibleContext = undefined;
  }

  async onEvent(accessibilityEvent: AccessibilityEvent): Promise<void> {
    if (accessibilityEvent.eventType == 'add') {
      // API 12 开始废弃 AccessibilityElement 方法，无法实现节点信息的读取
      let rootElement: AccessibilityElement;
      if (!this.accessibleContext) {
        return;
      }
      try {
        rootElement = await this.accessibleContext?.getWindowRootElement();
        let componentType = await this.getAttributeValue(rootElement, 'componentType');
        let clickable = await this.getAttributeValue(rootElement, 'clickable');
        let text = await this.getAttributeValue(rootElement, 'text');
        let screenRect = await this.getAttributeValue(rootElement, 'screenRect');
        if (componentType == 'Button' && clickable == true && (text == '跳过' || text == 'Skip')) {
          // 目前还没有实现点击操作的接口
        }
        
      } catch (error) {
        Logger.error(`AccessibilityExtAbility Failed to getWindowRootElement. Cause:${JSON.stringify(error)}`);
      }



    }
  }

  async getAttributeValue(accessibilityElement: AccessibilityElement, key: ElementAttributeKeys):
    Promise<attributeValues | null> {
    let value: attributeValues;
    let keys = await accessibilityElement.attributeNames();
    let isExit = false;
    for (let keyString of keys) {
      if (key == keyString) {
        isExit = true;
      }
    }
    if (isExit) {
      try {
        value = await accessibilityElement.attributeValue(key);
        return value;
      } catch (error) {
        Logger.error(`AccessibilityUtils Failed to get attributeValue of ${key} . Cause:  ${JSON.stringify(error)}`);
      }
    }
    return null;
  }
  }