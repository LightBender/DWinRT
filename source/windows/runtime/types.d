module windows.runtime.types;

import windows.config;

//
// Enumerations
//

enum RO_ERROR_REPORTING_NONE                  = 0x00000000;
enum RO_ERROR_REPORTING_SUPPRESSEXCEPTIONS    = 0x00000001;
enum RO_ERROR_REPORTING_FORCEEXCEPTIONS       = 0x00000002;
enum RO_ERROR_REPORTING_USESETERRORINFO       = 0x00000004;
enum RO_ERROR_REPORTING_SUPPRESSSETERRORINFO  = 0x00000008;

public enum AsyncStatus : int {
	Started		= 0,
	Completed	= 1,
	Canceled	= 2,
	Error		= 3
}

public enum BSOS_OPTIONS {
	BSOS_DEFAULT                  = 0,
	BSOS_PREFERDESTINATIONSTREAM  = 1
}

public enum ErrorOptions {
	None                  = RO_ERROR_REPORTING_NONE,
	SuppressExceptions    = RO_ERROR_REPORTING_SUPPRESSEXCEPTIONS,
	ForceExceptions       = RO_ERROR_REPORTING_FORCEEXCEPTIONS,
	UseSetErrorInfo       = RO_ERROR_REPORTING_USESETERRORINFO,
	SuppressSetErrorInfo  = RO_ERROR_REPORTING_SUPPRESSSETERRORINFO
}

public enum InputStreamOptions {
	None       = 0,
	Partial    = 1,
	ReadAhead  = 2
}

public enum PropertyType : int {
	Empty 				= 0,
	UInt8				= 1,
	Int16				= 2,
	UInt16				= 3,
	Int32				= 4,
	UInt32				= 5,
	Int64				= 6,
	UInt64				= 7,
	Single				= 8,
	Double				= 9,
	Char16				= 10,
	Boolean				= 11,
	String				= 12,
	Inspectable			= 13,
	DateTime			= 14,
	TimeSpan			= 15,
	Guid				= 16,
	Point				= 17,
	Size				= 18,
	Rect				= 19,
	OtherType			= 20,
	UInt8Array			= 1025,
	Int16Array			= 1026,
	UInt16Array			= 1027,
	Int32Array			= 1028,
	UInt32Array			= 1029,
	Int64Array			= 1030,
	UInt64Array			= 1031,
	SingleArray			= 1032,
	DoubleArray			= 1033,
	Char16Array			= 1034,
	BooleanArray		= 1035,
	StringArray			= 1036,
	InspectableArray	= 1037,
	DateTimeArray		= 1038,
	TimeSpanArray		= 1039,
	GuidArray			= 1040,
	PointArray			= 1041,
	SizeArray			= 1042,
	RectArray			= 1043,
	OtherTypeArray		= 1044,
}

public enum TrustLevel {
	BaseTrust     = 0,
	PartialTrust  = 1,
	FullTrust     = 2
}

public enum RO_INIT_TYPE {
	RO_INIT_MULTITHREADED  = 1
}

static if(Runtime81)
{

	public enum _ActivationType {
		InProcess		= 0,
		OutOfProcess	= 1
	}
	public alias _ActivationType ActivationType;

	public enum _AgileReferenceOptions {
		AGILEREFERENCE_DEFAULT			= 0,
		AGILEREFERENCE_DELAYEDMARSHAL	= 1
	}
	public alias _AgileReferenceOptions AgileReferenceOptions;

	public enum IdentityType {
		ActivateAsActivator  = 0,
		RunAs                = 1,
		ActivateAsPackage    = 2
	}

	public enum InstancingType {
		SingleInstance     = 0,
		MultipleInstances  = 1
	}

	public enum RegisteredTrustLevel {
		BaseTrust     = 0,
		PartialTrust  = 1,
		FullTrust     = 2
	}

	public enum RegistrationScope {
		PerMachine  = 0,
		PerUser     = 1,
		InboxApp    = 2
	}

	public enum ThreadingType {
		BOTH  = 0,
		STA   = 1,
		MTA   = 2
	}
}

//
// Structures
//

public struct TimeSpan {
	long Duration;
}

public struct DateTime {
	long UniversalTime;
}

public struct Rect {
	float X;
	float Y;
	float Width;
	float Height;
}

public struct Point {
	float X;
	float Y;
}

public struct Size {
	float Width;
	float Height;
}

public struct _TextRange {
	uint StartPosition;
	uint Length;
}
public alias _TextRange TextRange;
public alias _TextRange* PTextRange;

public struct EventRegistrationToken {
	long value;
}

public struct _ServiceInformation {
	uint ServerPid;
	uint ServerTid;
	ulong ServerAddress64;
}
public alias _ServiceInformation ServiceInformation;
public alias _ServiceInformation* PServiceInformation;

public struct _APARTMENT_SHUTDOWN_REGISTRATION_COOKIE  {
	long value;
}
public alias _APARTMENT_SHUTDOWN_REGISTRATION_COOKIE APARTMENT_SHUTDOWN_REGISTRATION_COOKIE;
public alias _APARTMENT_SHUTDOWN_REGISTRATION_COOKIE* PAPARTMENT_SHUTDOWN_REGISTRATION_COOKIE;

public struct _RO_REGISTRATION_COOKIE { }
public alias _RO_REGISTRATION_COOKIE* RO_REGISTRATION_COOKIE;