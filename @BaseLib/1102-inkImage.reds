// -----------------------------------------------------------------------------
// inkImage Imports
// -----------------------------------------------------------------------------
//
// - 9-slice scaling
// - Alignment options for tiles
//
// -----------------------------------------------------------------------------
//
// class inkImage extends inkLeafWidget {
//   public func IsNineSliceScale() -> Bool
//   public func GetNineSliceScale() -> inkMargin
//   public func SetNineSliceScale(enable: Bool, opt grid: inkMargin) -> Void
//   public func GetTileHAlign() -> inkEHorizontalAlign
//   public func SetTileHAlign(tileHAlign: inkEHorizontalAlign) -> Void
//   public func GetTileVAlign() -> inkEVerticalAlign
//   public func SetTileVAlign(tileVAlign: inkEVerticalAlign) -> Void
// }
//

@addField(inkImage)
native let useNineSliceScale: Bool;

@addField(inkImage)
native let nineSliceScale: inkMargin;

@addField(inkImage)
native let tileHAlign: inkEHorizontalAlign;

@addField(inkImage)
native let tileVAlign: inkEVerticalAlign;

@addMethod(inkImage)
public func IsNineSliceScale() -> Bool {
	return this.useNineSliceScale;
}

@addMethod(inkImage)
public func GetNineSliceScale() -> inkMargin {
	return this.nineSliceScale;
}

@addMethod(inkImage)
public func SetNineSliceScale(enable: Bool, opt grid: inkMargin) -> Void {
	this.useNineSliceScale = enable;
	this.nineSliceScale = grid;
}

@addMethod(inkImage)
public func GetTileHAlign() -> inkEHorizontalAlign {
	return this.tileHAlign;
}

@addMethod(inkImage)
public func SetTileHAlign(tileHAlign: inkEHorizontalAlign) -> Void {
	this.tileHAlign = tileHAlign;
}

@addMethod(inkImage)
public func GetTileVAlign() -> inkEVerticalAlign {
	return this.tileVAlign;
}

@addMethod(inkImage)
public func SetTileVAlign(tileVAlign: inkEVerticalAlign) -> Void {
	this.tileVAlign = tileVAlign;
}
