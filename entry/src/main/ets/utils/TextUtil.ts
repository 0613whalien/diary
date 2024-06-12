
export class TextUtils {
  static isEmpty(str: string): boolean {
    if (typeof str != 'string') {
      return true;
    }else {
      return !str || str.trim().length === 0;

    }
  }
}