//! NOTE: this file is autogenerated, DO NOT MODIFY
//--------------------------------------------------------------------------------
// Section: Constants (0)
//--------------------------------------------------------------------------------

//--------------------------------------------------------------------------------
// Section: Types (14)
//--------------------------------------------------------------------------------
const CLSID_FhConfigMgr_Value = @import("../zig.zig").Guid.initString("ed43bb3c-09e9-498a-9df6-2177244c6db4");
pub const CLSID_FhConfigMgr = &CLSID_FhConfigMgr_Value;

const CLSID_FhReassociation_Value = @import("../zig.zig").Guid.initString("4d728e35-16fa-4320-9e8b-bfd7100a8846");
pub const CLSID_FhReassociation = &CLSID_FhReassociation_Value;

pub const FH_TARGET_PROPERTY_TYPE = enum(i32) {
    FH_TARGET_NAME = 0,
    FH_TARGET_URL = 1,
    FH_TARGET_DRIVE_TYPE = 2,
    MAX_TARGET_PROPERTY = 3,
};
pub const FH_TARGET_NAME = FH_TARGET_PROPERTY_TYPE.FH_TARGET_NAME;
pub const FH_TARGET_URL = FH_TARGET_PROPERTY_TYPE.FH_TARGET_URL;
pub const FH_TARGET_DRIVE_TYPE = FH_TARGET_PROPERTY_TYPE.FH_TARGET_DRIVE_TYPE;
pub const MAX_TARGET_PROPERTY = FH_TARGET_PROPERTY_TYPE.MAX_TARGET_PROPERTY;

pub const FH_TARGET_DRIVE_TYPES = enum(i32) {
    UNKNOWN = 0,
    REMOVABLE = 2,
    FIXED = 3,
    REMOTE = 4,
};
pub const FH_DRIVE_UNKNOWN = FH_TARGET_DRIVE_TYPES.UNKNOWN;
pub const FH_DRIVE_REMOVABLE = FH_TARGET_DRIVE_TYPES.REMOVABLE;
pub const FH_DRIVE_FIXED = FH_TARGET_DRIVE_TYPES.FIXED;
pub const FH_DRIVE_REMOTE = FH_TARGET_DRIVE_TYPES.REMOTE;

// TODO: this type is limited to platform 'windows8.0'
const IID_IFhTarget_Value = @import("../zig.zig").Guid.initString("d87965fd-2bad-4657-bd3b-9567eb300ced");
pub const IID_IFhTarget = &IID_IFhTarget_Value;
pub const IFhTarget = extern struct {
    pub const VTable = extern struct {
        base: IUnknown.VTable,
        GetStringProperty: fn(
            self: *const IFhTarget,
            PropertyType: FH_TARGET_PROPERTY_TYPE,
            PropertyValue: ?*?BSTR,
        ) callconv(@import("std").os.windows.WINAPI) HRESULT,
        GetNumericalProperty: fn(
            self: *const IFhTarget,
            PropertyType: FH_TARGET_PROPERTY_TYPE,
            PropertyValue: ?*u64,
        ) callconv(@import("std").os.windows.WINAPI) HRESULT,
    };
    vtable: *const VTable,
    pub fn MethodMixin(comptime T: type) type { return struct {
        pub usingnamespace IUnknown.MethodMixin(T);
        // NOTE: method is namespaced with interface name to avoid conflicts for now
        pub fn IFhTarget_GetStringProperty(self: *const T, PropertyType: FH_TARGET_PROPERTY_TYPE, PropertyValue: ?*?BSTR) callconv(.Inline) HRESULT {
            return @ptrCast(*const IFhTarget.VTable, self.vtable).GetStringProperty(@ptrCast(*const IFhTarget, self), PropertyType, PropertyValue);
        }
        // NOTE: method is namespaced with interface name to avoid conflicts for now
        pub fn IFhTarget_GetNumericalProperty(self: *const T, PropertyType: FH_TARGET_PROPERTY_TYPE, PropertyValue: ?*u64) callconv(.Inline) HRESULT {
            return @ptrCast(*const IFhTarget.VTable, self.vtable).GetNumericalProperty(@ptrCast(*const IFhTarget, self), PropertyType, PropertyValue);
        }
    };}
    pub usingnamespace MethodMixin(@This());
};

// TODO: this type is limited to platform 'windows8.0'
const IID_IFhScopeIterator_Value = @import("../zig.zig").Guid.initString("3197abce-532a-44c6-8615-f3666566a720");
pub const IID_IFhScopeIterator = &IID_IFhScopeIterator_Value;
pub const IFhScopeIterator = extern struct {
    pub const VTable = extern struct {
        base: IUnknown.VTable,
        MoveToNextItem: fn(
            self: *const IFhScopeIterator,
        ) callconv(@import("std").os.windows.WINAPI) HRESULT,
        GetItem: fn(
            self: *const IFhScopeIterator,
            Item: ?*?BSTR,
        ) callconv(@import("std").os.windows.WINAPI) HRESULT,
    };
    vtable: *const VTable,
    pub fn MethodMixin(comptime T: type) type { return struct {
        pub usingnamespace IUnknown.MethodMixin(T);
        // NOTE: method is namespaced with interface name to avoid conflicts for now
        pub fn IFhScopeIterator_MoveToNextItem(self: *const T) callconv(.Inline) HRESULT {
            return @ptrCast(*const IFhScopeIterator.VTable, self.vtable).MoveToNextItem(@ptrCast(*const IFhScopeIterator, self));
        }
        // NOTE: method is namespaced with interface name to avoid conflicts for now
        pub fn IFhScopeIterator_GetItem(self: *const T, Item: ?*?BSTR) callconv(.Inline) HRESULT {
            return @ptrCast(*const IFhScopeIterator.VTable, self.vtable).GetItem(@ptrCast(*const IFhScopeIterator, self), Item);
        }
    };}
    pub usingnamespace MethodMixin(@This());
};

pub const FH_PROTECTED_ITEM_CATEGORY = enum(i32) {
    FH_FOLDER = 0,
    FH_LIBRARY = 1,
    MAX_PROTECTED_ITEM_CATEGORY = 2,
};
pub const FH_FOLDER = FH_PROTECTED_ITEM_CATEGORY.FH_FOLDER;
pub const FH_LIBRARY = FH_PROTECTED_ITEM_CATEGORY.FH_LIBRARY;
pub const MAX_PROTECTED_ITEM_CATEGORY = FH_PROTECTED_ITEM_CATEGORY.MAX_PROTECTED_ITEM_CATEGORY;

pub const FH_LOCAL_POLICY_TYPE = enum(i32) {
    FH_FREQUENCY = 0,
    FH_RETENTION_TYPE = 1,
    FH_RETENTION_AGE = 2,
    MAX_LOCAL_POLICY = 3,
};
pub const FH_FREQUENCY = FH_LOCAL_POLICY_TYPE.FH_FREQUENCY;
pub const FH_RETENTION_TYPE = FH_LOCAL_POLICY_TYPE.FH_RETENTION_TYPE;
pub const FH_RETENTION_AGE = FH_LOCAL_POLICY_TYPE.FH_RETENTION_AGE;
pub const MAX_LOCAL_POLICY = FH_LOCAL_POLICY_TYPE.MAX_LOCAL_POLICY;

pub const FH_RETENTION_TYPES = enum(i32) {
    FH_RETENTION_DISABLED = 0,
    FH_RETENTION_UNLIMITED = 1,
    FH_RETENTION_AGE_BASED = 2,
    MAX_RETENTION_TYPE = 3,
};
pub const FH_RETENTION_DISABLED = FH_RETENTION_TYPES.FH_RETENTION_DISABLED;
pub const FH_RETENTION_UNLIMITED = FH_RETENTION_TYPES.FH_RETENTION_UNLIMITED;
pub const FH_RETENTION_AGE_BASED = FH_RETENTION_TYPES.FH_RETENTION_AGE_BASED;
pub const MAX_RETENTION_TYPE = FH_RETENTION_TYPES.MAX_RETENTION_TYPE;

pub const FH_BACKUP_STATUS = enum(i32) {
    FH_STATUS_DISABLED = 0,
    FH_STATUS_DISABLED_BY_GP = 1,
    FH_STATUS_ENABLED = 2,
    FH_STATUS_REHYDRATING = 3,
    MAX_BACKUP_STATUS = 4,
};
pub const FH_STATUS_DISABLED = FH_BACKUP_STATUS.FH_STATUS_DISABLED;
pub const FH_STATUS_DISABLED_BY_GP = FH_BACKUP_STATUS.FH_STATUS_DISABLED_BY_GP;
pub const FH_STATUS_ENABLED = FH_BACKUP_STATUS.FH_STATUS_ENABLED;
pub const FH_STATUS_REHYDRATING = FH_BACKUP_STATUS.FH_STATUS_REHYDRATING;
pub const MAX_BACKUP_STATUS = FH_BACKUP_STATUS.MAX_BACKUP_STATUS;

pub const FH_DEVICE_VALIDATION_RESULT = enum(i32) {
    FH_ACCESS_DENIED = 0,
    FH_INVALID_DRIVE_TYPE = 1,
    FH_READ_ONLY_PERMISSION = 2,
    FH_CURRENT_DEFAULT = 3,
    FH_NAMESPACE_EXISTS = 4,
    FH_TARGET_PART_OF_LIBRARY = 5,
    FH_VALID_TARGET = 6,
    MAX_VALIDATION_RESULT = 7,
};
pub const FH_ACCESS_DENIED = FH_DEVICE_VALIDATION_RESULT.FH_ACCESS_DENIED;
pub const FH_INVALID_DRIVE_TYPE = FH_DEVICE_VALIDATION_RESULT.FH_INVALID_DRIVE_TYPE;
pub const FH_READ_ONLY_PERMISSION = FH_DEVICE_VALIDATION_RESULT.FH_READ_ONLY_PERMISSION;
pub const FH_CURRENT_DEFAULT = FH_DEVICE_VALIDATION_RESULT.FH_CURRENT_DEFAULT;
pub const FH_NAMESPACE_EXISTS = FH_DEVICE_VALIDATION_RESULT.FH_NAMESPACE_EXISTS;
pub const FH_TARGET_PART_OF_LIBRARY = FH_DEVICE_VALIDATION_RESULT.FH_TARGET_PART_OF_LIBRARY;
pub const FH_VALID_TARGET = FH_DEVICE_VALIDATION_RESULT.FH_VALID_TARGET;
pub const MAX_VALIDATION_RESULT = FH_DEVICE_VALIDATION_RESULT.MAX_VALIDATION_RESULT;

// TODO: this type is limited to platform 'windows8.0'
const IID_IFhConfigMgr_Value = @import("../zig.zig").Guid.initString("6a5fea5b-bf8f-4ee5-b8c3-44d8a0d7331c");
pub const IID_IFhConfigMgr = &IID_IFhConfigMgr_Value;
pub const IFhConfigMgr = extern struct {
    pub const VTable = extern struct {
        base: IUnknown.VTable,
        LoadConfiguration: fn(
            self: *const IFhConfigMgr,
        ) callconv(@import("std").os.windows.WINAPI) HRESULT,
        CreateDefaultConfiguration: fn(
            self: *const IFhConfigMgr,
            OverwriteIfExists: BOOL,
        ) callconv(@import("std").os.windows.WINAPI) HRESULT,
        SaveConfiguration: fn(
            self: *const IFhConfigMgr,
        ) callconv(@import("std").os.windows.WINAPI) HRESULT,
        AddRemoveExcludeRule: fn(
            self: *const IFhConfigMgr,
            Add: BOOL,
            Category: FH_PROTECTED_ITEM_CATEGORY,
            Item: ?BSTR,
        ) callconv(@import("std").os.windows.WINAPI) HRESULT,
        GetIncludeExcludeRules: fn(
            self: *const IFhConfigMgr,
            Include: BOOL,
            Category: FH_PROTECTED_ITEM_CATEGORY,
            Iterator: ?*?*IFhScopeIterator,
        ) callconv(@import("std").os.windows.WINAPI) HRESULT,
        GetLocalPolicy: fn(
            self: *const IFhConfigMgr,
            LocalPolicyType: FH_LOCAL_POLICY_TYPE,
            PolicyValue: ?*u64,
        ) callconv(@import("std").os.windows.WINAPI) HRESULT,
        SetLocalPolicy: fn(
            self: *const IFhConfigMgr,
            LocalPolicyType: FH_LOCAL_POLICY_TYPE,
            PolicyValue: u64,
        ) callconv(@import("std").os.windows.WINAPI) HRESULT,
        GetBackupStatus: fn(
            self: *const IFhConfigMgr,
            BackupStatus: ?*FH_BACKUP_STATUS,
        ) callconv(@import("std").os.windows.WINAPI) HRESULT,
        SetBackupStatus: fn(
            self: *const IFhConfigMgr,
            BackupStatus: FH_BACKUP_STATUS,
        ) callconv(@import("std").os.windows.WINAPI) HRESULT,
        GetDefaultTarget: fn(
            self: *const IFhConfigMgr,
            DefaultTarget: ?*?*IFhTarget,
        ) callconv(@import("std").os.windows.WINAPI) HRESULT,
        ValidateTarget: fn(
            self: *const IFhConfigMgr,
            TargetUrl: ?BSTR,
            ValidationResult: ?*FH_DEVICE_VALIDATION_RESULT,
        ) callconv(@import("std").os.windows.WINAPI) HRESULT,
        ProvisionAndSetNewTarget: fn(
            self: *const IFhConfigMgr,
            TargetUrl: ?BSTR,
            TargetName: ?BSTR,
        ) callconv(@import("std").os.windows.WINAPI) HRESULT,
        ChangeDefaultTargetRecommendation: fn(
            self: *const IFhConfigMgr,
            Recommend: BOOL,
        ) callconv(@import("std").os.windows.WINAPI) HRESULT,
        QueryProtectionStatus: fn(
            self: *const IFhConfigMgr,
            ProtectionState: ?*u32,
            ProtectedUntilTime: ?*?BSTR,
        ) callconv(@import("std").os.windows.WINAPI) HRESULT,
    };
    vtable: *const VTable,
    pub fn MethodMixin(comptime T: type) type { return struct {
        pub usingnamespace IUnknown.MethodMixin(T);
        // NOTE: method is namespaced with interface name to avoid conflicts for now
        pub fn IFhConfigMgr_LoadConfiguration(self: *const T) callconv(.Inline) HRESULT {
            return @ptrCast(*const IFhConfigMgr.VTable, self.vtable).LoadConfiguration(@ptrCast(*const IFhConfigMgr, self));
        }
        // NOTE: method is namespaced with interface name to avoid conflicts for now
        pub fn IFhConfigMgr_CreateDefaultConfiguration(self: *const T, OverwriteIfExists: BOOL) callconv(.Inline) HRESULT {
            return @ptrCast(*const IFhConfigMgr.VTable, self.vtable).CreateDefaultConfiguration(@ptrCast(*const IFhConfigMgr, self), OverwriteIfExists);
        }
        // NOTE: method is namespaced with interface name to avoid conflicts for now
        pub fn IFhConfigMgr_SaveConfiguration(self: *const T) callconv(.Inline) HRESULT {
            return @ptrCast(*const IFhConfigMgr.VTable, self.vtable).SaveConfiguration(@ptrCast(*const IFhConfigMgr, self));
        }
        // NOTE: method is namespaced with interface name to avoid conflicts for now
        pub fn IFhConfigMgr_AddRemoveExcludeRule(self: *const T, Add: BOOL, Category: FH_PROTECTED_ITEM_CATEGORY, Item: ?BSTR) callconv(.Inline) HRESULT {
            return @ptrCast(*const IFhConfigMgr.VTable, self.vtable).AddRemoveExcludeRule(@ptrCast(*const IFhConfigMgr, self), Add, Category, Item);
        }
        // NOTE: method is namespaced with interface name to avoid conflicts for now
        pub fn IFhConfigMgr_GetIncludeExcludeRules(self: *const T, Include: BOOL, Category: FH_PROTECTED_ITEM_CATEGORY, Iterator: ?*?*IFhScopeIterator) callconv(.Inline) HRESULT {
            return @ptrCast(*const IFhConfigMgr.VTable, self.vtable).GetIncludeExcludeRules(@ptrCast(*const IFhConfigMgr, self), Include, Category, Iterator);
        }
        // NOTE: method is namespaced with interface name to avoid conflicts for now
        pub fn IFhConfigMgr_GetLocalPolicy(self: *const T, LocalPolicyType: FH_LOCAL_POLICY_TYPE, PolicyValue: ?*u64) callconv(.Inline) HRESULT {
            return @ptrCast(*const IFhConfigMgr.VTable, self.vtable).GetLocalPolicy(@ptrCast(*const IFhConfigMgr, self), LocalPolicyType, PolicyValue);
        }
        // NOTE: method is namespaced with interface name to avoid conflicts for now
        pub fn IFhConfigMgr_SetLocalPolicy(self: *const T, LocalPolicyType: FH_LOCAL_POLICY_TYPE, PolicyValue: u64) callconv(.Inline) HRESULT {
            return @ptrCast(*const IFhConfigMgr.VTable, self.vtable).SetLocalPolicy(@ptrCast(*const IFhConfigMgr, self), LocalPolicyType, PolicyValue);
        }
        // NOTE: method is namespaced with interface name to avoid conflicts for now
        pub fn IFhConfigMgr_GetBackupStatus(self: *const T, BackupStatus: ?*FH_BACKUP_STATUS) callconv(.Inline) HRESULT {
            return @ptrCast(*const IFhConfigMgr.VTable, self.vtable).GetBackupStatus(@ptrCast(*const IFhConfigMgr, self), BackupStatus);
        }
        // NOTE: method is namespaced with interface name to avoid conflicts for now
        pub fn IFhConfigMgr_SetBackupStatus(self: *const T, BackupStatus: FH_BACKUP_STATUS) callconv(.Inline) HRESULT {
            return @ptrCast(*const IFhConfigMgr.VTable, self.vtable).SetBackupStatus(@ptrCast(*const IFhConfigMgr, self), BackupStatus);
        }
        // NOTE: method is namespaced with interface name to avoid conflicts for now
        pub fn IFhConfigMgr_GetDefaultTarget(self: *const T, DefaultTarget: ?*?*IFhTarget) callconv(.Inline) HRESULT {
            return @ptrCast(*const IFhConfigMgr.VTable, self.vtable).GetDefaultTarget(@ptrCast(*const IFhConfigMgr, self), DefaultTarget);
        }
        // NOTE: method is namespaced with interface name to avoid conflicts for now
        pub fn IFhConfigMgr_ValidateTarget(self: *const T, TargetUrl: ?BSTR, ValidationResult: ?*FH_DEVICE_VALIDATION_RESULT) callconv(.Inline) HRESULT {
            return @ptrCast(*const IFhConfigMgr.VTable, self.vtable).ValidateTarget(@ptrCast(*const IFhConfigMgr, self), TargetUrl, ValidationResult);
        }
        // NOTE: method is namespaced with interface name to avoid conflicts for now
        pub fn IFhConfigMgr_ProvisionAndSetNewTarget(self: *const T, TargetUrl: ?BSTR, TargetName: ?BSTR) callconv(.Inline) HRESULT {
            return @ptrCast(*const IFhConfigMgr.VTable, self.vtable).ProvisionAndSetNewTarget(@ptrCast(*const IFhConfigMgr, self), TargetUrl, TargetName);
        }
        // NOTE: method is namespaced with interface name to avoid conflicts for now
        pub fn IFhConfigMgr_ChangeDefaultTargetRecommendation(self: *const T, Recommend: BOOL) callconv(.Inline) HRESULT {
            return @ptrCast(*const IFhConfigMgr.VTable, self.vtable).ChangeDefaultTargetRecommendation(@ptrCast(*const IFhConfigMgr, self), Recommend);
        }
        // NOTE: method is namespaced with interface name to avoid conflicts for now
        pub fn IFhConfigMgr_QueryProtectionStatus(self: *const T, ProtectionState: ?*u32, ProtectedUntilTime: ?*?BSTR) callconv(.Inline) HRESULT {
            return @ptrCast(*const IFhConfigMgr.VTable, self.vtable).QueryProtectionStatus(@ptrCast(*const IFhConfigMgr, self), ProtectionState, ProtectedUntilTime);
        }
    };}
    pub usingnamespace MethodMixin(@This());
};

// TODO: this type is limited to platform 'windows8.0'
const IID_IFhReassociation_Value = @import("../zig.zig").Guid.initString("6544a28a-f68d-47ac-91ef-16b2b36aa3ee");
pub const IID_IFhReassociation = &IID_IFhReassociation_Value;
pub const IFhReassociation = extern struct {
    pub const VTable = extern struct {
        base: IUnknown.VTable,
        ValidateTarget: fn(
            self: *const IFhReassociation,
            TargetUrl: ?BSTR,
            ValidationResult: ?*FH_DEVICE_VALIDATION_RESULT,
        ) callconv(@import("std").os.windows.WINAPI) HRESULT,
        ScanTargetForConfigurations: fn(
            self: *const IFhReassociation,
            TargetUrl: ?BSTR,
        ) callconv(@import("std").os.windows.WINAPI) HRESULT,
        GetConfigurationDetails: fn(
            self: *const IFhReassociation,
            Index: u32,
            UserName: ?*?BSTR,
            PcName: ?*?BSTR,
            BackupTime: ?*FILETIME,
        ) callconv(@import("std").os.windows.WINAPI) HRESULT,
        SelectConfiguration: fn(
            self: *const IFhReassociation,
            Index: u32,
        ) callconv(@import("std").os.windows.WINAPI) HRESULT,
        PerformReassociation: fn(
            self: *const IFhReassociation,
            OverwriteIfExists: BOOL,
        ) callconv(@import("std").os.windows.WINAPI) HRESULT,
    };
    vtable: *const VTable,
    pub fn MethodMixin(comptime T: type) type { return struct {
        pub usingnamespace IUnknown.MethodMixin(T);
        // NOTE: method is namespaced with interface name to avoid conflicts for now
        pub fn IFhReassociation_ValidateTarget(self: *const T, TargetUrl: ?BSTR, ValidationResult: ?*FH_DEVICE_VALIDATION_RESULT) callconv(.Inline) HRESULT {
            return @ptrCast(*const IFhReassociation.VTable, self.vtable).ValidateTarget(@ptrCast(*const IFhReassociation, self), TargetUrl, ValidationResult);
        }
        // NOTE: method is namespaced with interface name to avoid conflicts for now
        pub fn IFhReassociation_ScanTargetForConfigurations(self: *const T, TargetUrl: ?BSTR) callconv(.Inline) HRESULT {
            return @ptrCast(*const IFhReassociation.VTable, self.vtable).ScanTargetForConfigurations(@ptrCast(*const IFhReassociation, self), TargetUrl);
        }
        // NOTE: method is namespaced with interface name to avoid conflicts for now
        pub fn IFhReassociation_GetConfigurationDetails(self: *const T, Index: u32, UserName: ?*?BSTR, PcName: ?*?BSTR, BackupTime: ?*FILETIME) callconv(.Inline) HRESULT {
            return @ptrCast(*const IFhReassociation.VTable, self.vtable).GetConfigurationDetails(@ptrCast(*const IFhReassociation, self), Index, UserName, PcName, BackupTime);
        }
        // NOTE: method is namespaced with interface name to avoid conflicts for now
        pub fn IFhReassociation_SelectConfiguration(self: *const T, Index: u32) callconv(.Inline) HRESULT {
            return @ptrCast(*const IFhReassociation.VTable, self.vtable).SelectConfiguration(@ptrCast(*const IFhReassociation, self), Index);
        }
        // NOTE: method is namespaced with interface name to avoid conflicts for now
        pub fn IFhReassociation_PerformReassociation(self: *const T, OverwriteIfExists: BOOL) callconv(.Inline) HRESULT {
            return @ptrCast(*const IFhReassociation.VTable, self.vtable).PerformReassociation(@ptrCast(*const IFhReassociation, self), OverwriteIfExists);
        }
    };}
    pub usingnamespace MethodMixin(@This());
};

pub const FhBackupStopReason = enum(i32) {
    InvalidStopReason = 0,
    LimitUserBusyMachineOnAC = 1,
    LimitUserIdleMachineOnDC = 2,
    LimitUserBusyMachineOnDC = 3,
    Cancelled = 4,
};
pub const BackupInvalidStopReason = FhBackupStopReason.InvalidStopReason;
pub const BackupLimitUserBusyMachineOnAC = FhBackupStopReason.LimitUserBusyMachineOnAC;
pub const BackupLimitUserIdleMachineOnDC = FhBackupStopReason.LimitUserIdleMachineOnDC;
pub const BackupLimitUserBusyMachineOnDC = FhBackupStopReason.LimitUserBusyMachineOnDC;
pub const BackupCancelled = FhBackupStopReason.Cancelled;


//--------------------------------------------------------------------------------
// Section: Functions (7)
//--------------------------------------------------------------------------------
// TODO: this type is limited to platform 'windows8.0'
pub extern "fhsvcctl" fn FhServiceOpenPipe(
    StartServiceIfStopped: BOOL,
    Pipe: ?*FH_SERVICE_PIPE_HANDLE,
) callconv(@import("std").os.windows.WINAPI) HRESULT;

// TODO: this type is limited to platform 'windows8.0'
pub extern "fhsvcctl" fn FhServiceClosePipe(
    Pipe: FH_SERVICE_PIPE_HANDLE,
) callconv(@import("std").os.windows.WINAPI) HRESULT;

// TODO: this type is limited to platform 'windows8.0'
pub extern "fhsvcctl" fn FhServiceStartBackup(
    Pipe: FH_SERVICE_PIPE_HANDLE,
    LowPriorityIo: BOOL,
) callconv(@import("std").os.windows.WINAPI) HRESULT;

// TODO: this type is limited to platform 'windows8.0'
pub extern "fhsvcctl" fn FhServiceStopBackup(
    Pipe: FH_SERVICE_PIPE_HANDLE,
    StopTracking: BOOL,
) callconv(@import("std").os.windows.WINAPI) HRESULT;

// TODO: this type is limited to platform 'windows8.0'
pub extern "fhsvcctl" fn FhServiceReloadConfiguration(
    Pipe: FH_SERVICE_PIPE_HANDLE,
) callconv(@import("std").os.windows.WINAPI) HRESULT;

// TODO: this type is limited to platform 'windows8.0'
pub extern "fhsvcctl" fn FhServiceBlockBackup(
    Pipe: FH_SERVICE_PIPE_HANDLE,
) callconv(@import("std").os.windows.WINAPI) HRESULT;

// TODO: this type is limited to platform 'windows8.0'
pub extern "fhsvcctl" fn FhServiceUnblockBackup(
    Pipe: FH_SERVICE_PIPE_HANDLE,
) callconv(@import("std").os.windows.WINAPI) HRESULT;


//--------------------------------------------------------------------------------
// Section: Unicode Aliases (0)
//--------------------------------------------------------------------------------
const thismodule = @This();
pub usingnamespace switch (@import("../zig.zig").unicode_mode) {
    .ansi => struct {
    },
    .wide => struct {
    },
    .unspecified => if (@import("builtin").is_test) struct {
    } else struct {
    },
};
//--------------------------------------------------------------------------------
// Section: Imports (6)
//--------------------------------------------------------------------------------
const BOOL = @import("../foundation.zig").BOOL;
const BSTR = @import("../foundation.zig").BSTR;
const FH_SERVICE_PIPE_HANDLE = @import("../system/windows_programming.zig").FH_SERVICE_PIPE_HANDLE;
const FILETIME = @import("../foundation.zig").FILETIME;
const HRESULT = @import("../foundation.zig").HRESULT;
const IUnknown = @import("../system/com.zig").IUnknown;

test {
    @setEvalBranchQuota(
        @import("std").meta.declarations(@This()).len * 3
    );

    // reference all the pub declarations
    if (!@import("builtin").is_test) return;
    inline for (@import("std").meta.declarations(@This())) |decl| {
        if (decl.is_pub) {
            _ = decl;
        }
    }
}
