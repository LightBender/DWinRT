module windows.runtime.iinspectable;

import windows.config;
import windows.com;
import windows.runtime.types;
import windows.runtime.hstring;

public extern (Windows) nothrow @nogc
{
	HRESULT RoInitialize(RO_INIT_TYPE = RO_INIT_TYPE.RO_INIT_MULTITHREADED);
	void RoUninitialize();
	HRESULT RoUnregisterForApartmentShutdown(APARTMENT_SHUTDOWN_REGISTRATION_COOKIE regCookie);
	HRESULT RoGetActivationFactory(HSTRING activatableClassId, REFIID iid, void** factory);
	HRESULT RoActivateInstance(HSTRING activatableClassId, IInspectable *instance);
	void RoRevokeActivationFactories(RO_REGISTRATION_COOKIE cookie);

	HRESULT RoGetBufferMarshaler(IMarshal bufferMarshaler);
	HRESULT RoGetApartmentIdentifier(ulong *apartmentIdentifier);
	HRESULT RoGetServerActivatableClasses(HSTRING serverName, HSTRING **activatableClassIds, DWORD *count);

	//Error handling
	HRESULT RoCaptureErrorContext(HRESULT hrError);
	void RoClearError();
	void RoFailFastWithErrorContext(HRESULT hrError);
	HRESULT RoGetErrorReportingFlags(uint *pflags);
	//HRESULT RoInspectThreadErrorInfo(uint *targetTebAddress, ushort machine, PINSPECT_MEMORY_CALLBACK readMemoryCallback, void *context, uint **targetErrorInfoAddress);
	//HRESULT RoInspectCapturedStackBackTrace(uint *targetErrorInfoAddress, ushort machine, PINSPECT_MEMORY_CALLBACK readMemoryCallback, void *context, uint *frameCount,uint **targetBackTraceAddress);
	BOOL RoOriginateError(HRESULT error, HSTRING message);
	BOOL RoOriginateErrorW(HRESULT error, uint cchMax, const(wchar)* message);
	BOOL RoOriginateLanguageException(HRESULT error, HSTRING message, IUnknown languageException);
	HRESULT RoReportUnhandledError(IRestrictedErrorInfo pRestrictedErrorInfo);
	HRESULT RoReportFailedDelegate(IUnknown punkDelegate, IRestrictedErrorInfo pRestrictedErrorInfo);
	HRESULT RoResolveRestrictedErrorInfoReference(const(wchar)* reference, IRestrictedErrorInfo *ppRestrictedErrorInfo);
	HRESULT RoSetErrorReportingFlags(uint flags);
	BOOL RoTransformError(HRESULT oldError, HRESULT newError, HSTRING message);
	BOOL RoTransformErrorW(HRESULT oldError, HRESULT newError, uint cchMax, const(wchar)* message);
	HRESULT GetRestrictedErrorInfo(IRestrictedErrorInfo *ppRestrictedErrorInfo);
	BOOL IsErrorPropagationEnabled();
	HRESULT SetRestrictedErrorInfo(IRestrictedErrorInfo pRestrictedErrorInfo);
}

public extern(Windows)
{
	mixin(uuid!(IInspectable, "AF86E2E0-B12D-4C6A-9C5A-D7AA65101E90"));
	interface IInspectable : IUnknown
	{
		HRESULT GetIids(ulong *iidCount, IID **iids);
		HRESULT GetRuntimeClassName(HSTRING *className);
		HRESULT GetTrustLevel(TrustLevel *trustLevel);
	}

	mixin(uuid!(IRestrictedErrorInfo, "82BA7092-4C88-427D-A7BC-16DD93FEB67E"));
	interface IRestrictedErrorInfo : IUnknown
	{
		HRESULT GetErrorDetails(BSTR *description, HRESULT *error, BSTR *restrictedDescription);
		HRESULT GetReference(BSTR *reference);
	}
}

static if(Runtime81)
{
	public extern (Windows) nothrow @nogc HRESULT RoGetAgileReference(AgileReferenceOptions options, REFIID riid, IUnknown *pUnk, IAgileReference *ppAgileReference);

	mixin(uuid!(IAgileReference, "C03F6A43-65A4-9818-987E-E0B810D2A6F2"));
	public interface IAgileReference : IUnknown
	{
		extern (Windows) HRESULT Resolve(REFIID riid, void **ppvObjectReference);
	}
}
