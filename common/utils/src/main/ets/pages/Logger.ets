import { hilog } from '@kit.PerformanceAnalysisKit';

/**
 * Log printing tool class.
 */
export class Logger {
  static error(arg0: string) {
    throw new Error('Method not implemented.');
  }
  private domain: number;
  private prefix: string;
  private format: string = '%{public}s, %{public}s';

  /**
   * Constructor.
   *
   * @param Prefix Identifies the log tag.
   * @param domain Domain Indicates the service domain, which is a hexadecimal integer ranging from 0x0 to 0xFFFFF.
   */
  constructor(prefix: string = '', domain: number = 0xFF00) {
    this.prefix = prefix;
    this.domain = domain;
  }

  public debug(...args: string[]): void {
    hilog.debug(this.domain, this.prefix, this.format, args);
  }

  public info(...args: string[]): void {
    hilog.info(this.domain, this.prefix, this.format, args);
  }

  public warn(...args: string[]): void {
    hilog.warn(this.domain, this.prefix, this.format, args);
  }

  public error(...args: string[]): void {
    hilog.error(this.domain, this.prefix, this.format, args);
  }
}

export default new Logger('[AccessibilityBasedCapabilities]');