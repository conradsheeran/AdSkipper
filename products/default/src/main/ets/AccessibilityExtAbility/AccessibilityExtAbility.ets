// TODO: perf: Improve Accessibility services

import { AccessibilityExtensionAbility, AccessibilityEvent,
  AccessibilityExtensionContext,
  accessibility} from '@kit.AccessibilityKit';
import AccessibilityManager from './AccessibilityManager';

class AccessibilityExtAbility extends AccessibilityExtensionAbility {
  onConnect() {
    console.info(`AccessibilityExtAbility onConnect`);
    // 执行初始化业务逻辑的操作
    AccessibilityManager.getInstance().onStart(this.context);
  }

  onDisconnect() {
    console.info(`AccessibilityExtAbility onDisconnect`);
    // 执行资源回收退出业务逻辑的操作
    AccessibilityManager.getInstance().onStop();
  }

  onAccessibilityEvent(accessibilityEvent: AccessibilityEvent) {
    console.info(`AccessibilityExtAbility onAccessibilityEvent: ${JSON.stringify(accessibilityEvent)}`);
    // 根据事件信息进行业务逻辑处理
    AccessibilityManager.getInstance().onEvent(accessibilityEvent);
  }
}

export default AccessibilityExtAbility;