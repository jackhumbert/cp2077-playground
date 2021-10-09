// -----------------------------------------------------------------------------
// FNV1a64 Hasher
// -----------------------------------------------------------------------------
//
// This is a part of experimental code to understand what can be done in scripts.
// This is not really meant for production.
//

module BaseLib

public abstract class FNV1a64 {
	public static func Hash(str: String) -> Uint64 {
		let hash: Uint64 = Cast(-3750763034362895579l); // StringToUint64("14695981039346656037")
		let prime: Uint64 = Cast(1099511628211l);

		let chars: ref<inkStringMap> = FNV1a64.AsciiCharCodes();
		let length: Int32 = StrLen(str);
		let offset: Int32 = 0;

		while offset < length {
			hash = hash ^ chars.Get(StrMid(str, offset, 1));
			hash *= prime;
			offset += 1;
		}

		return hash;
	}

	public static func Hash(name: CName) -> Uint64 {
		return FNV1a64.Hash(NameToString(name));
	}

	private static func AsciiCharCodes() -> ref<inkStringMap> {
		let map: ref<inkStringMap> = GetAllBlackboardDefs().DebugData.AsciiCharCodes;

		if !IsDefined(map) {
			map = new inkStringMap();

			let code: Int32;
			while code <= 255 {
				map.Insert(StrChar(code), Cast(code));
				code += 1;
			}

			GetAllBlackboardDefs().DebugData.AsciiCharCodes = map;
		}

		return map;
	}
}

// -----------------------------------------------------------------------------

@addField(DebugDataDef)
private let AsciiCharCodes: ref<inkStringMap>;
