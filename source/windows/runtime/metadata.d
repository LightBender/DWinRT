module windows.runtime.metadata;

import windows.config;
import windows.com;
import windows.runtime.types;
import windows.runtime.hstring;

public alias HANDLE ROPARAMIIDHANDLE;

public extern (Windows) nothrow @nogc
{
	HRESULT RoResolveNamespace(const HSTRING name, const HSTRING windowsMetaDataDir, const DWORD packageGraphDirsCount, const HSTRING *packageGraphDirs, DWORD *metaDataFilePathsCount, HSTRING **metaDataFilePaths, DWORD *subNamespacesCount, HSTRING **subNamespaces);

	HRESULT RoFreeParameterizedTypeExtra(ROPARAMIIDHANDLE extra);
	HRESULT RoGetParameterizedTypeInstanceIID(uint nameElementCount, PCWSTR* nameElements, const IRoMetaDataLocator* metaDataLocator, GUID *iid, ROPARAMIIDHANDLE *pExtra);
	HRESULT RoParseTypeName(HSTRING typename, DWORD *partsCount, HSTRING **typeNameParts);
	HRESULT RoParameterizedTypeExtraGetTypeSignature(ROPARAMIIDHANDLE extra);
}

public extern(Windows)
{
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