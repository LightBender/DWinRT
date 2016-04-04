module windows.runtime.hstring;

public import windows.com;
import windows.config;

public struct HSTRING__ {
align(1):
	int unused;
}
public alias HSTRING__* HSTRING;

public alias HANDLE HSTRING_BUFFER;

public struct HSTRING_HEADER {
	union {
		void* Reserved1;
		version(X86_64)
			char[24] Reserved2;
		version(X86)
			char[20] Reserved2;
	}
}

public extern(Windows) HRESULT WindowsCompareStringOrdinal(HSTRING string1, HSTRING string2, int* result);
public extern(Windows) HRESULT WindowsConcatString(HSTRING string1, HSTRING string2, HSTRING* newString);
public extern(Windows) HRESULT WindowsCreateString(const(wchar*) sourceString, uint length, HSTRING* string);
public extern(Windows) HRESULT WindowsCreateStringReference(const(wchar*) sourceString, uint length, HSTRING_HEADER* hstringHeader, HSTRING* string);
public extern(Windows) HRESULT WindowsDeleteString(HSTRING string);
public extern(Windows) HRESULT WindowsDeleteStringBuffer(HSTRING_BUFFER bufferHandle);
public extern(Windows) HRESULT WindowsDuplicateString(HSTRING string, HSTRING* newString);
public extern(Windows) int WindowsGetStringLen(HSTRING string);
public extern(Windows) const(wchar*) WindowsGetStringRawBuffer(HSTRING string, uint* length);
public extern(Windows) BOOL WindowsIsStringEmpty(HSTRING string);
public extern(Windows) HRESULT WindowsPreallocateStringBuffer(uint length, wchar** mutableBuffer, HSTRING_BUFFER bufferHandle);
public extern(Windows) HRESULT WindowsPromoteStringBuffer(HSTRING_BUFFER bufferHandle, HSTRING* string);
public extern(Windows) HRESULT WindowsReplaceString(HSTRING string, HSTRING stringReplace, HSTRING stringReplaceWith, HSTRING* newString);
public extern(Windows) HRESULT WindowsStringHasEmbeddedNull(HSTRING string, BOOL* hasEmbedNull);
public extern(Windows) HRESULT WindowsSubstring(HSTRING string, uint startIndex, HSTRING* newString);
public extern(Windows) HRESULT WindowsSubstringWithSpecifiedLength(HSTRING string, uint startIndex, uint length, HSTRING* newString);
public extern(Windows) HRESULT WindowsTrimStringEnd(HSTRING string, HSTRING trimString, HSTRING* newString);
public extern(Windows) HRESULT WindowsTrimStringStart(HSTRING string, HSTRING trimString, HSTRING* newString);

public extern(Windows) void HSTRING_UserFree(ulong *flags, HSTRING* ppidl);
public extern(Windows) void HSTRING_UserFree64(ulong *flags, HSTRING* ppidl);
public extern(Windows) void HSTRING_UserMarshal(ulong *flags, ubyte *pBuffer, HSTRING* ppidl);
public extern(Windows) void HSTRING_UserMarshal64(ulong *flags, ubyte *pBuffer, HSTRING* ppidl);
public extern(Windows) void HSTRING_UserUserSize(ulong *flags, ulong StartingSize, HSTRING* ppidl);
public extern(Windows) void HSTRING_UserUserSize64(ulong *flags, ulong StartingSize, HSTRING* ppidl);
public extern(Windows) void HSTRING_UserUnmarshal(ulong *flags, ubyte *pBuffer, HSTRING* ppidl);
public extern(Windows) void HSTRING_UserUnmarshal64(ulong *flags, ubyte *pBuffer, HSTRING* ppidl);
