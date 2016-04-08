module windows.runtime.metadata;

import windows.config;
import windows.com;
import windows.runtime.types;
import windows.runtime.hstring;

public alias HANDLE ROPARAMIIDHANDLE;

public alias uint mdToken;
public alias mdToken mdTypeDef;

public extern (Windows) nothrow @nogc
{
	HRESULT RoResolveNamespace(const HSTRING name, const HSTRING windowsMetaDataDir, const DWORD packageGraphDirsCount, const HSTRING *packageGraphDirs, DWORD *metaDataFilePathsCount, HSTRING **metaDataFilePaths, DWORD *subNamespacesCount, HSTRING **subNamespaces);
	HRESULT RoGetMetaDataFile(const HSTRING name, IMetaDataDispenserEx metaDataDispenser, HSTRING *metaDataFilePath, IMetaDataImport2 *metaDataImport, mdTypeDef *typeDefToken);

	HRESULT RoFreeParameterizedTypeExtra(ROPARAMIIDHANDLE extra);
	HRESULT RoGetParameterizedTypeInstanceIID(uint nameElementCount, PCWSTR* nameElements, const IRoMetaDataLocator* metaDataLocator, GUID *iid, ROPARAMIIDHANDLE *pExtra);
	HRESULT RoParseTypeName(HSTRING typename, DWORD *partsCount, HSTRING **typeNameParts);
	HRESULT RoParameterizedTypeExtraGetTypeSignature(ROPARAMIIDHANDLE extra);
}

public extern(Windows)
{
	mixin(uuid!(IMetaDataDispenser, "809C652E-7396-11D2-9771-00A0C9B4D50C"));
	interface IMetaDataDispenser : IUnknown
	{
		HRESULT DefineScope(REFCLSID rclsid, DWORD dwCreateFlags, REFIID riid, IUnknown *ppIUnk);
		HRESULT OpenScope(LPCWSTR szScope, DWORD dwOpenFlags, REFIID riid, IUnknown *ppIUnk);
		HRESULT OpenScopeOnMemory(const BYTE *pData, ULONG cbData, DWORD dwOpenFlags, REFIID riid, IUnknown *ppIUnk);
	}

	mixin(uuid!(IMetaDataDispenserEx, "31BCFCE2-DAFB-11D2-9F81-00C04F79A0A3"));
	interface IMetaDataDispenserEx : IMetaDataDispenser
	{
		HRESULT FindAssembly(LPCWSTR szAppBase, LPCWSTR szPrivateBin, LPCWSTR szGlobalBin, LPCWSTR szAssemblyName, LPWSTR szName, ULONG cchName, ULONG *pchName);
		HRESULT FindAssemblyModule(LPCWSTR szAppBase, LPCWSTR szPrivateBin, LPCWSTR szGlobalBin, LPCWSTR szAssemblyName, LPCWSTR szModuleName, LPWSTR szName, ULONG cchName, ULONG *pcName);
		HRESULT GetCORSystemDirectory(LPWSTR szBuffer, DWORD cchBuffer, DWORD *pchBuffer);
		HRESULT GetOption(REFGUID optionId, VARIANT *pValue);
		HRESULT OpenScopeOnITypeInfo(ITypeInfo *pITI, DWORD dwOpenFlags, REFIID riid, IUnknown *ppIUnk);
		HRESULT SetOption(REFGUID optionId, VARIANT *pValue);
	}

	mixin(uuid!(IMetaDataImport, "7DAC8207-D3AE-4C75-9B67-92801A497D44"));
	interface IMetaDataImport : IUnknown
	{
	}

	mixin(uuid!(IMetaDataImport2, "FCE5EFA0-8BBA-4f8E-A036-8F2022B08466"));
	interface IMetaDataImport2 : IMetaDataImport
	{
	}

	struct IRoMetaDataLocator
	{
		HRESULT Locate(PCWSTR nameElement, IRoSimpleMetaDataBuilder *metaDataDestination);
	}

	struct IRoSimpleMetaDataBuilder
	{
		HRESULT SetWinRtInterface(GUID iid);
		HRESULT SetDelegate(GUID iid);
		HRESULT SetInterfaceGroupSimpleDefault(PCWSTR name, PCWSTR defaultInterfaceName, const GUID* defaultInterfaceIID);
		HRESULT SetInterfaceGroupParameterizedDefault(PCWSTR name, uint elementCount, PCWSTR* defaultInterfaceNameElements);
		HRESULT SetRuntimeClassSimpleDefault(PCWSTR name, PCWSTR defaultInterfaceName, const GUID* defaultInterfaceIID);
		HRESULT SetRuntimeClassParameterizedDefault(PCWSTR name, uint elementCount, const PCWSTR* defaultInterfaceNameElements);
		HRESULT SetStruct(PCWSTR name, uint numFields, const PCWSTR*  fieldTypeNames);
		HRESULT SetEnum(PCWSTR name, PCWSTR baseType);
		HRESULT SetParameterizedInterface(GUID piid, uint numArgs);
		HRESULT SetParameterizedDelegate(GUID piid, uint numArgs);
	}
}