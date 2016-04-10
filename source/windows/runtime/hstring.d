module windows.runtime.hstring;
version (Windows):

public import windows.com;
import windows.config;

import std.utf;

public alias HANDLE HSTRING_BUFFER;
public struct HSTRING__ {
align(1):
	int unused;
}
public alias HSTRING__* HSTRING;

public struct HSTRING_HEADER {
	union {
		void* Reserved1;
		version(X86_64)
			char[24] Reserved2;
		version(X86)
			char[20] Reserved2;
	}
}


immutable(wchar)* toStringz(const(wchar)[] s) @trusted pure nothrow
{
	import std.exception : assumeUnique;
	auto copy = new wchar[s.length + 1];
	copy[0..s.length] = s[];
	copy[s.length] = 0;

	return assumeUnique(copy).ptr;
}

immutable(wchar)* toStringz(in wstring s) @trusted pure nothrow
{
	immutable p = s.ptr + s.length;
	if ((cast(size_t) p & 3) && *p == 0)
		return s.ptr;
	return toStringz(cast(const wchar[]) s);
}


public extern (Windows) nothrow @nogc
{
	HRESULT WindowsCompareStringOrdinal(HSTRING string1, HSTRING string2, int* result);
	HRESULT WindowsConcatString(HSTRING string1, HSTRING string2, HSTRING* newString);
	HRESULT WindowsCreateString(const(wchar*) sourceString, uint length, HSTRING* string);
	HRESULT WindowsCreateStringReference(const(wchar*) sourceString, uint length, HSTRING_HEADER* hstringHeader, HSTRING* string);
	HRESULT WindowsDeleteString(HSTRING string);
	HRESULT WindowsDeleteStringBuffer(HSTRING_BUFFER bufferHandle);
	HRESULT WindowsDuplicateString(HSTRING string, HSTRING* newString);
	int WindowsGetStringLen(HSTRING string);
	const(wchar*) WindowsGetStringRawBuffer(HSTRING string, uint* length);
	BOOL WindowsIsStringEmpty(HSTRING string);
	HRESULT WindowsPreallocateStringBuffer(uint length, wchar** mutableBuffer, HSTRING_BUFFER bufferHandle);
	HRESULT WindowsPromoteStringBuffer(HSTRING_BUFFER bufferHandle, HSTRING* string);
	HRESULT WindowsReplaceString(HSTRING string, HSTRING stringReplace, HSTRING stringReplaceWith, HSTRING* newString);
	HRESULT WindowsStringHasEmbeddedNull(HSTRING string, BOOL* hasEmbedNull);
	HRESULT WindowsSubstring(HSTRING string, uint startIndex, HSTRING* newString);
	HRESULT WindowsSubstringWithSpecifiedLength(HSTRING string, uint startIndex, uint length, HSTRING* newString);
	HRESULT WindowsTrimStringEnd(HSTRING string, HSTRING trimString, HSTRING* newString);
	HRESULT WindowsTrimStringStart(HSTRING string, HSTRING trimString, HSTRING* newString);

	void HSTRING_UserFree(ulong *flags, HSTRING* ppidl);
	void HSTRING_UserFree64(ulong *flags, HSTRING* ppidl);
	void HSTRING_UserMarshal(ulong *flags, ubyte *pBuffer, HSTRING* ppidl);
	void HSTRING_UserMarshal64(ulong *flags, ubyte *pBuffer, HSTRING* ppidl);
	void HSTRING_UserUserSize(ulong *flags, ulong StartingSize, HSTRING* ppidl);
	void HSTRING_UserUserSize64(ulong *flags, ulong StartingSize, HSTRING* ppidl);
	void HSTRING_UserUnmarshal(ulong *flags, ubyte *pBuffer, HSTRING* ppidl);
	void HSTRING_UserUnmarshal64(ulong *flags, ubyte *pBuffer, HSTRING* ppidl);
}

public class WinString
{
	private shared static WinString spaceStr;
	private shared static WinString tabStr;
	private shared static WinString vtabStr;
	private shared static WinString backStr;

	private shared static this()
	{
		spaceStr = cast(shared) new WinString(" ");
		tabStr = cast(shared) new WinString("\t");
		vtabStr = cast(shared) new WinString("\v");
		backStr = cast(shared) new WinString("\b");
	}

	private HSTRING _str;
	private int _len;
	private bool _empty;

	public @property int length() { return _len; }
	public @property bool empty() { return _empty; }

	~this()
	{
		WindowsDeleteString(_str);
	}

	public this(HSTRING str)
	{
		_str = str;
		_len = WindowsGetStringLen(_str);
		_empty = WindowsIsStringEmpty(_str) == 0;
	}

	public this(string str)
	{
		WindowsCreateString(toUTF16z(str), toUTF16(str).length, &_str);
		_len = WindowsGetStringLen(_str);
		_empty = WindowsIsStringEmpty(_str) == 0;
	}

	public this(wstring str)
	{
		WindowsCreateString(toUTF16z(str), toUTF16(str).length, &_str);
		_len = WindowsGetStringLen(_str);
		_empty = WindowsIsStringEmpty(_str) == 0;
	}

	public this(dstring str)
	{
		WindowsCreateString(toUTF16z(str), toUTF16(str).length, &_str);
		_len = WindowsGetStringLen(_str);
		_empty = WindowsIsStringEmpty(_str) == 0;
	}

	public this(in char[] str)
	{
		WindowsCreateString(toUTF16z(str), toUTF16(str).length, &_str);
		_len = WindowsGetStringLen(_str);
		_empty = WindowsIsStringEmpty(_str) == 0;
	}

	public this(in wchar[] str)
	{
		WindowsCreateString(toUTF16z(str), toUTF16(str).length, &_str);
		_len = WindowsGetStringLen(_str);
		_empty = WindowsIsStringEmpty(_str) == 0;
	}

	public this(in dchar[] str)
	{
		WindowsCreateString(toUTF16z(str), toUTF16(str).length, &_str);
		_len = WindowsGetStringLen(_str);
		_empty = WindowsIsStringEmpty(_str) == 0;
	}

	public WinString trim()
	{
		HSTRING temp;
		WindowsTrimStringEnd(_str, (cast(WinString)spaceStr)._str, &temp);
		WindowsTrimStringEnd(temp, (cast(WinString)tabStr)._str, &temp);
		WindowsTrimStringEnd(temp, (cast(WinString)vtabStr)._str, &temp);
		WindowsTrimStringEnd(temp, (cast(WinString)backStr)._str, &temp);
		WindowsTrimStringStart(temp, (cast(WinString)spaceStr)._str, &temp);
		WindowsTrimStringStart(temp, (cast(WinString)tabStr)._str, &temp);
		WindowsTrimStringStart(temp, (cast(WinString)vtabStr)._str, &temp);
		WindowsTrimStringStart(temp, (cast(WinString)backStr)._str, &temp);
		return new WinString(temp);
	}

	public WinString trimStart()
	{
		HSTRING temp;
		WindowsTrimStringStart(_str, (cast(WinString)spaceStr)._str, &temp);
		WindowsTrimStringStart(temp, (cast(WinString)tabStr)._str, &temp);
		WindowsTrimStringStart(temp, (cast(WinString)vtabStr)._str, &temp);
		WindowsTrimStringStart(temp, (cast(WinString)backStr)._str, &temp);
		return new WinString(temp);
	}

	public WinString trimEnd()
	{
		HSTRING temp;
		WindowsTrimStringEnd(_str, (cast(WinString)spaceStr)._str, &temp);
		WindowsTrimStringEnd(temp, (cast(WinString)tabStr)._str, &temp);
		WindowsTrimStringEnd(temp, (cast(WinString)vtabStr)._str, &temp);
		WindowsTrimStringEnd(temp, (cast(WinString)backStr)._str, &temp);
		return new WinString(temp);
	}

	public WinString replace(dstring oldValue, dstring newValue)
	{
		auto ov = new WinString(oldValue);
		auto nv = new WinString(newValue);

		HSTRING temp;
		WindowsReplaceString(_str, ov._str, nv._str, &temp);
		return new WinString(temp);
	}

	public WinString substring(uint startIndex)
	{
		HSTRING temp;
		WindowsSubstring(_str, startIndex, &temp);
		return new WinString(temp);
	}

	public WinString substring(uint startIndex, uint length)
	{
		HSTRING temp;
		WindowsSubstringWithSpecifiedLength(_str, startIndex, length, &temp);
		return new WinString(temp);
	}

	public bool opEquals()(auto ref const S s) const {
		int ret = 0;
		WindowsCompareStringOrdinal(_str, s._str, &ret);
		return ret == 0;
	}

	public WinString opBinary(string op)(WinString rhs)
	{
		static if (op == "~")
		{
			HSTRING temp;
			WindowsConcatString(_str, rhs._str, &temp);
			return new WinString(temp);
		}
		else static assert(0, "Operator "~op~" not supported");
	}

	public void opAssign(string str)
	{
		WindowsCreateString(toUTF16z(str), toUTF16(str).length, &_str);
		_len = WindowsGetStringLen(_str);
		_empty = WindowsIsStringEmpty(_str) == 0;
	}

	public void opAssign(wstring str)
	{
		WindowsCreateString(toUTF16z(str), toUTF16(str).length, &_str);
		_len = WindowsGetStringLen(_str);
		_empty = WindowsIsStringEmpty(_str) == 0;
	}

	public void opAssign(dstring str)
	{
		WindowsCreateString(toUTF16z(str), toUTF16(str).length, &_str);
		_len = WindowsGetStringLen(_str);
		_empty = WindowsIsStringEmpty(_str) == 0;
	}

	public void opAssign(in char[] str)
	{
		WindowsCreateString(toUTF16z(str), toUTF16(str).length, &_str);
		_len = WindowsGetStringLen(_str);
		_empty = WindowsIsStringEmpty(_str) == 0;
	}

	public void opAssign(in wchar[] str)
	{
		WindowsCreateString(toUTF16z(str), toUTF16(str).length, &_str);
		_len = WindowsGetStringLen(_str);
		_empty = WindowsIsStringEmpty(_str) == 0;
	}

	public void opAssign(in dchar[] str)
	{
		WindowsCreateString(toUTF16z(str), toUTF16(str).length, &_str);
		_len = WindowsGetStringLen(_str);
		_empty = WindowsIsStringEmpty(_str) == 0;
	}

	public override string toString()
	{
		uint strlen = 0;
		auto str = WindowsGetStringRawBuffer(_str, &strlen);
		return toUTF8(str[0..strlen]);
	}

	public wstring toString16()
	{
		uint strlen = 0;
		auto str = WindowsGetStringRawBuffer(_str, &strlen);
		return toUTF16(str[0..strlen]);
	}

	public dstring toString32()
	{
		uint strlen = 0;
		auto str = WindowsGetStringRawBuffer(_str, &strlen);
		return toUTF32(str[0..strlen]);
	}

	public HSTRING toHString()
	{
		return _str;
	}
}
