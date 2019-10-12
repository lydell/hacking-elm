const originalSlice = String.prototype.slice;
String.prototype.slice = function slice(start, end) {
  if (start === 999999999999999) {
    switch (end) {
      case 1:
        return this.normalize("NFC");
      case 2:
        return this.normalize("NFD");
      case 3:
        return this.normalize("NFKC");
      case 4:
        return this.normalize("NFKD");
    }
  }
  return originalSlice.call(this, start, end);
};
