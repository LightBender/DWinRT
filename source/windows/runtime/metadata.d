module windows.runtime.metadata;
version (Windows):

import windows.config;
import windows.com;
import windows.runtime.types;
import windows.runtime.hstring;

public alias HANDLE ROPARAMIIDHANDLE;

public alias ULONG32 HCORENUM;

public alias ubyte COR_SIGNATURE;
public alias COR_SIGNATURE* PCOR_SIGNATURE;
public alias const(COR_SIGNATURE)* PCCOR_SIGNATURE;

//public alias const(char)* MDUTF8CSTR; //Obsolete
public alias const(char)* UVCP_CONSTANT;

public alias uint mdToken;
public alias mdToken mdModule;
public alias mdToken mdTypeRef;
public alias mdToken mdTypeDef;
public alias mdToken mdFieldDef;
public alias mdToken mdMethodDef;
public alias mdToken mdParamDef;
public alias mdToken mdInterfaceImpl;
public alias mdToken mdMemberRef;
public alias mdToken mdCustomAttribute;
public alias mdToken mdPermission;
public alias mdToken mdSignature;
public alias mdToken mdEvent;
public alias mdToken mdProperty;
public alias mdToken mdModuleRef;
public alias mdToken mdAssembly;
public alias mdToken mdAssemblyRef;
public alias mdToken mdFile;
public alias mdToken mdExportedType;
public alias mdToken mdManifestResource;
public alias mdToken mdTypeSpec;
public alias mdToken mdGenericParam;
public alias mdToken mdMethodSpec;
public alias mdToken mdGenericParamConstraint;
public alias mdToken mdString;

public enum uint IMAGE_FILE_MACHINE_I386 = 0x014C;
public enum uint IMAGE_FILE_MACHINE_IA64 = 0x0200;
public enum uint IMAGE_FILE_MACHINE_AMD64 = 0x8664;

public enum uint RO_E_METADATA_NAME_NOT_FOUND = 0x8000000F;
public enum uint ERROR_NO_PACKAGE = 0x0;
public enum uint RO_E_METADATA_NAME_IS_NAMESPACE = 0x80000010;

public enum CorPEKind : DWORD {

	peNot           = 0x00000000,
	peILonly        = 0x00000001,
	pe32BitRequired = 0x00000002,
	pe32Plus        = 0x00000004,
	pe32Unmanaged   = 0x00000008,
	pe32BitPreferred= 0x00000010
}

public enum CorTypeAttr : uint {

	tdVisibilityMask        =   0x00000007,
	tdNotPublic             =   0x00000000,
	tdPublic                =   0x00000001,
	tdNestedPublic          =   0x00000002,
	tdNestedPrivate         =   0x00000003,
	tdNestedFamily          =   0x00000004,
	tdNestedAssembly        =   0x00000005,
	tdNestedFamANDAssem     =   0x00000006,
	tdNestedFamORAssem      =   0x00000007,

	tdLayoutMask            =   0x00000018,
	tdAutoLayout            =   0x00000000,
	tdSequentialLayout      =   0x00000008,
	tdExplicitLayout        =   0x00000010,

	tdClassSemanticsMask    =   0x00000020,
	tdClass                 =   0x00000000,
	tdInterface             =   0x00000020,

	tdAbstract              =   0x00000080,
	tdSealed                =   0x00000100,
	tdSpecialName           =   0x00000400,

	tdImport                =   0x00001000,
	tdSerializable          =   0x00002000,
	tdWindowsRuntime        =   0x00004000,

	tdStringFormatMask      =   0x00030000,
	tdAnsiClass             =   0x00000000,
	tdUnicodeClass          =   0x00010000,
	tdAutoClass             =   0x00020000,
	tdCustomFormatClass     =   0x00030000,
	tdCustomFormatMask      =   0x00C00000,

	tdBeforeFieldInit       =   0x00100000,
	tdForwarder             =   0x00200000,

	tdReservedMask          =   0x00040800,
	tdRTSpecialName         =   0x00000800,
	tdHasSecurity           =   0x00040000,
}

public enum CorOpenFlags : uint {
	ofRead              =   0x00000000,
	ofWrite             =   0x00000001,
	ofReadWriteMask     =   0x00000001,
	ofCopyMemory        =   0x00000002,
	ofCacheImage        =   0x00000004,
	ofManifestMetadata  =   0x00000008,
	ofReadOnly          =   0x00000010,
	ofTakeOwnership     =   0x00000020,
	ofNoTypeLib         =   0x00000080,
	ofNoTransform       =   0x00001000,
	ofReserved1         =   0x00000100,
	ofReserved2         =   0x00000200,
	ofReserved          =   0xffffff40
}

public struct COR_FIELD_OFFSET
{
	mdFieldDef ridOfField;
	ULONG32 ulOffset;
}

public struct OSINFO
{
	DWORD dwOSPlatformId;
	DWORD dwOSMajorVersion;
	DWORD dwOSMinorVersion;
}

public struct ASSEMBLYMETADATA
{
	USHORT usMajorVersion;
	USHORT usMinorVersion;
	USHORT usBuildNumber;
	USHORT usRevisionNumber;
	LPWSTR szLocale;
	ULONG cbLocale;
	DWORD *rProcessor;
	ULONG ulProcessor;
	OSINFO *rOS;
	ULONG ulOS;
}

public extern (Windows) nothrow @nogc
{
	HRESULT MetaDataGetDispenser(REFCLSID rclsid, REFIID riid, LPVOID *ppv);

	HRESULT RoResolveNamespace(const HSTRING name, const HSTRING windowsMetaDataDir, const DWORD packageGraphDirsCount, const HSTRING *packageGraphDirs, DWORD *metaDataFilePathsCount, HSTRING **metaDataFilePaths, DWORD *subNamespacesCount, HSTRING **subNamespaces);
	HRESULT RoGetMetaDataFile(const HSTRING name, IMetaDataDispenserEx metaDataDispenser, HSTRING *metaDataFilePath, IMetaDataImport2 *metaDataImport, mdTypeDef *typeDefToken);

	HRESULT RoFreeParameterizedTypeExtra(ROPARAMIIDHANDLE extra);
	HRESULT RoGetParameterizedTypeInstanceIID(uint nameElementCount, PCWSTR* nameElements, const IRoMetaDataLocator* metaDataLocator, GUID *iid, ROPARAMIIDHANDLE *pExtra);
	HRESULT RoParseTypeName(HSTRING typename, DWORD *partsCount, HSTRING **typeNameParts);
	HRESULT RoParameterizedTypeExtraGetTypeSignature(ROPARAMIIDHANDLE extra);
}

public
{
	mixin(uuid!(IMetaDataDispenser, "809C652E-7396-11D2-9771-00A0C9B4D50C"));
	mixin(clsid!(IMetaDataDispenser, "E5CB7A31-7512-11D2-89CE-0080C792E5D8"));
	interface IMetaDataDispenser : IUnknown
	{
		HRESULT DefineScope(REFCLSID rclsid, DWORD dwCreateFlags, REFIID riid, IUnknown *ppIUnk);
		HRESULT OpenScope(LPCWSTR szScope, DWORD dwOpenFlags, REFIID riid, IUnknown *ppIUnk);
		HRESULT OpenScopeOnMemory(const BYTE *pData, ULONG cbData, DWORD dwOpenFlags, REFIID riid, IUnknown *ppIUnk);
	}

	mixin(uuid!(IMetaDataDispenserEx, "31BCFCE2-DAFB-11D2-9F81-00C04F79A0A3"));
	mixin(clsid!(IMetaDataDispenserEx, "E5CB7A31-7512-11D2-89CE-0080C792E5D8"));
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
		void CloseEnum(HCORENUM hEnum);
		HRESULT CountEnum(HCORENUM hEnum, ULONG *pulCount);
		HRESULT EnumCustomAttributes(HCORENUM *phEnum, mdToken tk, mdToken tkType, mdCustomAttribute* rgCustomAttributes, ULONG cMax, ULONG *pcCustomAttributes);
		HRESULT EnumEvents(HCORENUM *phEnum, mdTypeDef tkTypDef, mdEvent* rgEvents, ULONG cMax, ULONG *pcEvents);
		HRESULT EnumFields(HCORENUM *phEnum, mdTypeDef tkTypeDef, mdFieldDef* rgFields, ULONG cMax, ULONG *pcTokens);
		HRESULT EnumFieldsWithName(HCORENUM *phEnum, mdTypeDef tkTypeDef, LPCWSTR szName, mdFieldDef* rFields, ULONG cMax, ULONG *pcTokens);
		HRESULT EnumInterfaceImpls(HCORENUM *phEnum, mdTypeDef td, mdInterfaceImpl* rImpls, ULONG cMax, ULONG *pcImpls);
		HRESULT EnumMemberRefs(HCORENUM *phEnum, mdToken tkParent, mdMemberRef* rgMemberRefs, ULONG cMax, ULONG *pcTokens);
		HRESULT EnumMembers(HCORENUM *phEnum, mdTypeDef tkTypeDef, mdToken* rgMembers, ULONG cMax, ULONG *pcTokens);
		HRESULT EnumMembersWithName(HCORENUM *phEnum, mdTypeDef tkTypeDef, LPCWSTR szName, mdToken* rgMembers, ULONG cMax, ULONG *pcTokens);
		HRESULT EnumMethodImpls(HCORENUM *phEnum, mdTypeDef tkTypeDef, mdToken* rMethodBody, mdToken* rMethodDecl, ULONG cMax, ULONG *pcTokens);
		HRESULT EnumMethods(HCORENUM *phEnum, mdTypeDef tkTypeDef, mdMethodDef* rgMethods, ULONG cMax, ULONG *pcTokens);
		HRESULT EnumMethodSemantics(HCORENUM *phEnum, mdMethodDef tkMethodDef, mdToken* rgEventProp, ULONG cMax, ULONG *pcEventProp);
		HRESULT EnumMethodsWithName(HCORENUM *phEnum, mdTypeDef tkTypeDef, LPCWSTR szName, mdMethodDef* rgMethods, ULONG cMax, ULONG *pcTokens);
		HRESULT EnumModuleRefs(HCORENUM *phEnum, mdModuleRef* rgModuleRefs, ULONG cMax, ULONG *pcModuleRefs);
		HRESULT EnumParams(HCORENUM *phEnum, mdMethodDef tkMethodDef, mdParamDef* rParams, ULONG cMax, ULONG *pcTokens);
		HRESULT EnumPermissionSets(HCORENUM *phEnum, mdToken tk, DWORD dwActions, mdPermission* rPermission, ULONG cMax, ULONG *pcTokens);
		HRESULT EnumProperties(HCORENUM *phEnum, mdTypeDef tkTypDef, mdProperty* rgProperties, ULONG cMax, ULONG *pcProperties);
		HRESULT EnumSignatures(HCORENUM *phEnum, mdSignature* rgSignatures, ULONG cMax, ULONG *pcSignatures);
		HRESULT EnumTypeDefs(HCORENUM *phEnum, mdTypeDef* rgTypeDefs, ULONG cMax, ULONG *pcTypeDefs);
		HRESULT EnumTypeRefs(HCORENUM *phEnum, mdTypeRef* rgTypeRefs, ULONG cMax, ULONG *pcTypeRefs);
		HRESULT EnumTypeSpecs(HCORENUM *phEnum, mdTypeSpec* rgTypeSpecs, ULONG cMax, ULONG *pcTypeSpecs);
		HRESULT EnumUnresolvedMethods(HCORENUM *phEnum, mdToken* rgMethods, ULONG cMax, ULONG *pcTokens);
		HRESULT EnumUserStrings(HCORENUM *phEnum, mdString* rgStrings, ULONG cMax, ULONG *pcStrings);
		HRESULT FindMemberRef(mdTypeRef tkTypeRef, LPCWSTR szName, PCCOR_SIGNATURE pvSigBlob, ULONG cbSigBlob, mdMemberRef *pMemberRef);
		HRESULT FindTypeDefByName(LPCWSTR szTypeDef, mdToken tkEnclosingClass, mdTypeDef *ptkTypeDef);
		HRESULT FindTypeRef(mdToken tkResolutionScope, LPCWSTR szName, mdTypeRef *tkTypeRef);
		HRESULT GetCustomAttributeByName(mdToken tkObj, LPCWSTR szName, BYTE attr, ULONG *pcbData);
		HRESULT GetCustomAttributeProps( mdCustomAttribute cv, mdToken *ptkObj, mdToken *ptkType, BYTE attr, ULONG *pcbBlob);
		HRESULT GetFieldMarshal(mdToken tk, PCCOR_SIGNATURE *ppvNativeType, ULONG *pcbNativeType);
		HRESULT GetFieldProps(mdFieldDef tkFieldDef, mdTypeDef *ptkTypeDef, LPWSTR szField, ULONG cchField, ULONG *pchField, DWORD *pdwAttr, PCCOR_SIGNATURE *ppvSigBlob, ULONG *pcbSigBlob, DWORD *pdwCPlusTypeFlag, UVCP_CONSTANT *ppValue, ULONG *pcchValue);
		HRESULT GetInterfaceImplProps(mdInterfaceImpl tkInterfaceImpl, mdTypeDef *ptkClass, mdToken *ptkIface);
		HRESULT GetMemberProps(mdToken tkMember, mdTypeDef *ptkTypeDef, LPWSTR szMember, ULONG cchMember, ULONG *pchMember, DWORD *pdwAttr, PCCOR_SIGNATURE *ppvSigBlob, ULONG *pcbSigBlob, ULONG *pulCodeRVA, DWORD *pdwImplFlags, DWORD *pdwCPlusTypeFlag, UVCP_CONSTANT *ppValue, ULONG *pcchValue);
		HRESULT GetMemberRefProps(mdMemberRef tkMemberRef, mdToken *ptk, LPWSTR szMember, ULONG cchMember, ULONG *pchMember, PCCOR_SIGNATURE *ppvSigBlob, ULONG *pcbSigBlob );
		HRESULT GetMethodProps(mdMethodDef tkMethodDef, mdTypeDef *ptkClass, LPWSTR szMethod, ULONG cchMethod, ULONG *pchMethod, DWORD *pdwAttr, PCCOR_SIGNATURE *ppvSigBlob, ULONG *pcbSigBlob, ULONG *pulCodeRVA, DWORD *pdwImplFlags);
		HRESULT GetMethodSemantics(mdMethodDef tkMethodDef, mdToken tkEventProp, DWORD *pdwSemanticsFlags);
		HRESULT GetModuleFromScope(mdModule *ptkModule);
		HRESULT GetModuleRefProps(mdModuleRef tkModuleRef,LPWSTR szName, ULONG cchName, ULONG *pchName);
		//HRESULT GetNameFromToken(mdToken tk, MDUTF8CSTR *pszUtf8NamePtr); //Obsolete
		HRESULT GetNativeCallConvFromSig(BYTE cons, ULONG cbSig, ULONG *pCallConv);
		HRESULT GetNestedClassProps(mdTypeDef tdNestedClass, mdTypeDef *ptdEnclosingClass);
		HRESULT GetParamForMethodIndex(mdMethodDef tkMethodDef, ULONG ulParamSeq, mdParamDef *ptkParamDef);
		HRESULT GetParamProps(mdParamDef tkParamDef, mdMethodDef *ptkMethodDef, ULONG *pulSequence, LPWSTR szName, ULONG cchName, ULONG *pchName, DWORD *pdwAttr, DWORD *pdwCPlusTypeFlag, UVCP_CONSTANT *ppValue, ULONG *pcchValue);
		HRESULT GetPermissionSetProps(mdPermission tk, DWORD *pdwAction, BYTE cons, ULONG *pcbPermission);
		HRESULT GetPinvokeMap(mdToken tk, DWORD *pdwMappingFlags, LPWSTR szImportName, ULONG cchImportName, ULONG *pchImportName, mdModuleRef *ptkImportDLL);
		HRESULT GetRVA(mdToken tk, ULONG *pulCodeRVA, DWORD *pdwImplFlags);
		HRESULT GetScopeProps(LPWSTR szName, ULONG cchName, ULONG *pchName, GUID *pmvid);
		HRESULT GetSigFromToken(mdSignature tkSignature, PCCOR_SIGNATURE *ppvSig, ULONG *pcbSig);
		HRESULT GetTypeDefProps(mdTypeDef tkTypeDef, LPWSTR szTypeDef, ULONG cchTypeDef, ULONG *pchTypeDef, DWORD *pdwTypeDefFlags, mdToken *ptkExtends);
		HRESULT GetTypeRefProps(mdTypeRef tkTypeRef, mdToken *ptkResolutionScope, LPWSTR szName, ULONG cchName, ULONG *pchName);
		HRESULT GetTypeSpecFromToken(mdTypeSpec tkTypeSpec, PCCOR_SIGNATURE *ppvSig, ULONG *pcbSig);
		HRESULT GetUserString(mdString tkString, LPWSTR szString, ULONG cchString, ULONG *pchString);
		HRESULT IsGlobal(mdToken tk, int *pbIsGlobal);
		BOOL IsValidToken(mdToken tk);
		HRESULT ResetEnum(HCORENUM hEnum, ULONG ulPos);
		HRESULT ResolveTypeRef(mdTypeRef tkTypeRef, REFIID riid, IUnknown *ppIScope, mdTypeDef *ptkTypeDef);
	}

	mixin(uuid!(IMetaDataImport2, "FCE5EFA0-8BBA-4f8E-A036-8F2022B08466"));
	interface IMetaDataImport2 : IMetaDataImport
	{
		HRESULT EnumGenericParamConstraints(HCORENUM *phEnum, mdGenericParam tk, mdGenericParamConstraint* rGenericParamConstraints, ULONG cMax, ULONG *pcGenericParamConstraints);
		HRESULT EnumGenericParams(HCORENUM *phEnum, mdToken tk, mdGenericParam* rGenericParams, ULONG cMax, ULONG *pcGenericParams);
		HRESULT EnumMethodSpecs(HCORENUM *phEnum, mdToken tk, mdMethodSpec* rMethodSpecs, ULONG cMax, ULONG *pcMethodSpecs);
		HRESULT GetGenericParamConstraintProps(mdGenericParamConstraint gpc, mdGenericParam *ptGenericParam, mdToken *ptkConstraintType);
		HRESULT GetGenericParamProps(mdGenericParam gp, ULONG *pulParamSeq, DWORD *pdwParamFlags, mdToken *ptOwner, DWORD *reserved, LPWSTR wzname, ULONG cchName, ULONG *pchName);
		HRESULT GetMethodSpecProps(mdMethodSpec mi, mdToken *tkParent, PCCOR_SIGNATURE *ppvSigBlob, ULONG *pcbSigBlob);
		HRESULT GetPEKind(DWORD *pdwPEKind, DWORD *pdwMachine);
		HRESULT GetVersionString(LPWSTR pwzBuf, DWORD ccBufSize, DWORD *pccBufSize);
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