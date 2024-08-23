export class ListItemClass {
  id: string = '';
  title: string = '';
  remark: string = '';

  constructor(id: string, title: string, remark: string) {
    this.id = id;
    this.title = title;
    this.remark = remark;
  }
}